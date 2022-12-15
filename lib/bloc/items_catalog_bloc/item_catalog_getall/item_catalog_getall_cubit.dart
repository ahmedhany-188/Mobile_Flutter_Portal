import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_getall/item_catalog_getall_state.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ItemsCatalogCubit extends Cubit<ItemCatalogGetAllState> with HydratedMixin{
  ItemsCatalogCubit(this.itemsCatalogRepository) : super(ItemCatalogGetAllState()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.itemCatalogGetAllDataEnumStates == ItemCatalogGetAllDataEnumStates.failed ||
          state.itemCatalogGetAllDataEnumStates ==
              ItemCatalogGetAllDataEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getAllItemsCatalog(itemsCatalogRepository.userData?.employeeData?.userHrCode??"");
          } catch (e) {
            emit(state.copyWith(
              itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.noConnection,
          ));
        }
      }
    });
  }

  Connectivity connectivity = Connectivity();
  ItemsCatalogGetAllRepository itemsCatalogRepository;

   getAllItemsCatalog(userHRCode) async{

    if(state.getAllItemsCatalogList.isEmpty){
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.loading,
          ));
          await itemsCatalogRepository.getItemsCatalogTreeRepository(userHRCode)
              .then((value) async {

                emit(state.copyWith(
                  itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.success,
                  getAllItemsCatalogList: state.getAllItemsCatalogList,
                ));

          }).catchError((error) {
            emit(state.copyWith(
              itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.failed,
            ));
          });
        } catch (e) {
          emit(state.copyWith(
            itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.failed,
          ));
        }
      } else {
        emit(state.copyWith(
          itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.noConnection,
        ));
      }
    }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  ItemCatalogGetAllState? fromJson(Map<String, dynamic> json) {
    return ItemCatalogGetAllState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ItemCatalogGetAllState state) {
    if (state.itemCatalogGetAllDataEnumStates == ItemCatalogGetAllDataEnumStates.success &&
        state.getAllItemsCatalogList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}