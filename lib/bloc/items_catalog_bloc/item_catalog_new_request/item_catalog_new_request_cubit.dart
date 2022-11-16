import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_state.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';

class NewRequestCatalogCubit extends Cubit<NewRequestCatalogInitial> {
  NewRequestCatalogCubit(this._requestRepository)
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

  final Connectivity connectivity = Connectivity();
  final RequestRepository _requestRepository;


  void postNewRequestDataSubmit(){

      // final model=state.catalogNewRequests;



      if(state.status.isValidated){

      }
      else{

      }

  }

  void newFunctionForTest(){
    print("");
  }



}
