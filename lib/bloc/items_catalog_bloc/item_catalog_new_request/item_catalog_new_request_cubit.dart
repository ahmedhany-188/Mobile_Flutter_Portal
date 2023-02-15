import 'package:file_picker/file_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_state.dart';
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
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      final itemName = RequestDate.dirty(state.itemName.value);
      final itemDescription = RequestDate.dirty(state.itemDescription.value);
      final itemAttach = state.itemAttach;
      final selectedCategory = RequestDate.dirty(state.selectedCategory.value);

      final quality=state.newRequestQuality;
      final entity=state.newRequestEntity;

      if (itemName.toString().length > 40) {
        emit(
            state.copyWith(
              itemName: itemName,
              errorMessage: "Maximum item name 40 letter",
              newRequestCatalogEnumState: NewRequestCatalogEnumState.failed,
            ));
      }
      else {
        emit(state.copyWith(
          itemName: itemName,
          itemDescription: itemDescription,
          itemAttach: itemAttach,
          selectedCategory: selectedCategory,
          newRequestEntity: entity,
          newRequestQuality: quality,
          status: Formz.validate([itemName, itemDescription, selectedCategory]),
        ));
        if (state.status.isValidated) {
          NewRequestCatalogModel newRequestCatalogModel = NewRequestCatalogModel(
              itemName: itemName.value,
              itemDesc: itemDescription.value,
              catID: int.parse(selectedCategory.value),
              brandEnabled: entity,
              qualityEnabled: quality,
              inUser: hrcode);
          emit(state.copyWith(
              status: FormzStatus.submissionInProgress,
              newRequestCatalogEnumState: NewRequestCatalogEnumState.loading
          ));
          final newRequestCatalog = await requestRepository
              .postNewRequestCatalog(newRequestCatalogModel);
          if (newRequestCatalog.error == false) {
            int? reqID = newRequestCatalog.data?[0].requestID;
            if (reqID != null) {
              if (itemAttach.isNotEmpty) {
                for (int i = 0; i < state.itemAttach.length; i++) {
                  //final newRequestImageCatalog =
                  await requestRepository.postNewRequestImageCatalog
                    (state.itemAttach[i], hrcode, reqID);
                }
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
                newRequestCatalogEnumState: NewRequestCatalogEnumState.failed),
            );
          }
        }
      }
    } else {
      emit(
        state.copyWith(
            newRequestCatalogEnumState: NewRequestCatalogEnumState
                .noConnection
        ),
      );
    }
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

  void addQualityEnabled(value) {
    emit(
      state.copyWith(
        newRequestQuality: value,
      ),
    );
  }

  void addEntityEnabled(value) {
    emit(
      state.copyWith(
        newRequestEntity: value,
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

  void addChosenImageName(bool main) async {
    await FilePicker.platform.pickFiles(type: FileType.image,)
        .then((value) async {
      if (value != null) {
        if (main) {
          // List<ItemImageCatalogModel> itemAttach = state.itemAttach;
          for (int i = 0; i < state.itemAttach.length; i++) {
            state.itemAttach[i].isMain = false;
          }
        }
        ItemImageCatalogModel imageCatalogModel = ItemImageCatalogModel(
            main, value);
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
      emit(
        state.copyWith(
            errorMessage: 'Something went wrong',
            status: FormzStatus.submissionFailure,
            newRequestCatalogEnumState: NewRequestCatalogEnumState.failed
        ),
      );
      throw err;
    });
  }

}





