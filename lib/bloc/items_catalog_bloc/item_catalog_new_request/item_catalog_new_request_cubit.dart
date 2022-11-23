import 'package:file_picker/file_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_state.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_image_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';

class NewRequestCatalogCubit extends Cubit<NewRequestCatalogInitial> {
  NewRequestCatalogCubit(this.requestRepository)
      : super(const NewRequestCatalogInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.newRequestCatalogEnumState ==
          NewRequestCatalogEnumState.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getAll();
          } catch (e) {
            emit(state.copyWith(
              newRequestCatalogEnumState: NewRequestCatalogEnumState.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            newRequestCatalogEnumState: NewRequestCatalogEnumState.failed,
          ));
        }
      }
    });
  }

  static NewRequestCatalogCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final ItemsCatalogGetAllRepository requestRepository;

  void submitCatalogNewRequest(hrcode) async {
    final itemName = RequestDate.dirty(state.itemName.value);
    final itemDescription = RequestDate.dirty(state.itemDescription.value);
    final itemAttach = state.itemAttach;
    final selectedCategory = RequestDate.dirty(state.selectedCategory.value);

    emit(state.copyWith(
      itemName: itemName,
      itemDescription: itemDescription,
      itemAttach: itemAttach,
      selectedCategory: selectedCategory,
      status: Formz.validate([itemName, itemDescription, selectedCategory]),
    ));

    if (state.status.isValidated) {
      if (itemAttach.isNotEmpty) {
        NewRequestCatalogModel newRequestCatalogModel = NewRequestCatalogModel(
            itemName: itemName.value,
            itemDesc: itemDescription.value,
            catID: int.parse(selectedCategory.value),
            inUser: hrcode);
        try {
          var connectivityResult = await connectivity.checkConnectivity();
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
            emit(state.copyWith(
                status: FormzStatus.submissionInProgress,
                newRequestCatalogEnumState: NewRequestCatalogEnumState.loading
            ));

            final newRequestCatalog = await requestRepository
                .postNewRequestCatalog(newRequestCatalogModel);

            if (newRequestCatalog.error == false) {

              int? reqID = newRequestCatalog.data?[0].requestID;

              print("ttttttttttt-:"+reqID.toString());
              if (reqID != null) {
                for (int i = 0; i < state.itemAttach.length; i++) {
                  final newRequestImageCatalog = await requestRepository.postNewRequestImageCatalog
                    (state.itemAttach[i], hrcode, reqID);
                    print("..........="+newRequestImageCatalog.toString());
                }
              }

              emit(state.copyWith(
                newRequestCatalogEnumState: NewRequestCatalogEnumState.success,
                errorMessage: reqID.toString(),
                status: FormzStatus.submissionSuccess,
              ),);

            } else {
              emit(state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: newRequestCatalog.message,
                  newRequestCatalogEnumState: NewRequestCatalogEnumState
                      .failed),

              );
            }
          } else {
            emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  newRequestCatalogEnumState: NewRequestCatalogEnumState
                      .noConnection
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
                errorMessage: e.toString(),
                status: FormzStatus.submissionFailure,
                newRequestCatalogEnumState: NewRequestCatalogEnumState.failed
            ),
          );
        }
      }else{
        emit(
          state.copyWith(
              errorMessage: "Invalid image",
              status: FormzStatus.submissionFailure,
              newRequestCatalogEnumState: NewRequestCatalogEnumState.failed
          ),
        );
      }
    }
  }

  void checkTheValueOfTree() {
    var now = DateTime.now();
    var formatter = GlobalConstants.dateFormatViewed;
    String formattedDate = formatter.format(now);
    final requestDate = RequestDate.dirty(formattedDate);
    emit(
      state.copyWith(
        newRequestDate: requestDate,
        newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
        status: Formz.validate([requestDate]),
      ),
    );
  }

  void addItemName(name) {
    final itemName = RequestDate.dirty(name);
    emit(
      state.copyWith(
        newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
        itemName: itemName,
        status: Formz.validate([itemName]),
      ),
    );
  }

  void addItemDescription(description) {
    final itemDescription = RequestDate.dirty(description);
    emit(
      state.copyWith(
        newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
        itemDescription: itemDescription,
        status: Formz.validate([itemDescription]),
      ),
    );
  }

  void addSelectedCategoryItem(category) async {
    final selectedCategory = RequestDate.dirty(category);
    emit(
      state.copyWith(
        newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
        selectedCategory: selectedCategory,
        status: Formz.validate([selectedCategory]),
      ),
    );
  }

  void addChosenImageName() async {

    await FilePicker.platform.pickFiles(type: FileType.image,)
        .then((value) async{

          if(value!=null){
            ItemImageCatalogModel imageCatalogModel = ItemImageCatalogModel(
                false, value);
            List<ItemImageCatalogModel> photos = [imageCatalogModel];
            photos += state.itemAttach;
            emit(
                state.copyWith(

                  itemAttach: photos,
                    errorMessage: "Image Added",
                  newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
                ));


          }

    }).catchError((err) {
      EasyLoading.showError('Something went wrong');
      throw err;
    });

    }

    void changeMainImage(index){

      for(int i=0; i<state.itemAttach.length; i++){
        state.itemAttach[i].isMain=false;
      }
      state.itemAttach[index].isMain=true;

      List<ItemImageCatalogModel> itemAttachs=state.itemAttach;

      emit(
          state.copyWith(
            itemAttach: itemAttachs,
            newRequestCatalogEnumState: NewRequestCatalogEnumState.valid,
          ));
    }

  }





