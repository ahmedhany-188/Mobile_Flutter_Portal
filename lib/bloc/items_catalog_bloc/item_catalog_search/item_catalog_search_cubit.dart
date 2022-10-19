import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/data_providers/general_dio/general_dio.dart';
import '../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../../data/models/items_catalog_models/item_catalog_search_model.dart';
part 'item_catalog_search_state.dart';

class ItemCatalogSearchCubit extends Cubit<ItemCatalogSearchState> with HydratedMixin {
  ItemCatalogSearchCubit(this._generalDio, this.itemsCatalogRepository) : super(
      ItemCatalogSearchState(getAllItemsCatalogList: ItemsCatalogCategory())) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.itemCatalogSearchEnumStates ==
          ItemCatalogSearchEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getContacts();
          } catch (e) {
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
          ));
        }
      }
    });
  }

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;
  final ItemsCatalogGetAllRepository itemsCatalogRepository;

  static ItemCatalogSearchCubit get(context) => BlocProvider.of(context);

  void getSearchList({int? catalogId}) async {
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    EasyLoading.show();
    await _generalDio
        .getItemCatalogSearch(state.searchString, categoryId: catalogId)
        .then((value) {
      // print("==${value.data['data'] != null}");
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCatalogSearchData> searchResult =
        List<ItemCatalogSearchData>.from(value.data['data']
            .map((model) => ItemCatalogSearchData.fromJson(model)));
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
          searchResult: searchResult,
        ));
        EasyLoading.dismiss();
      } else if (value.data['data'] == null) {
        EasyLoading.dismiss();
        emit(state.copyWith(
          searchResult: [],
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed));
    });
    EasyLoading.dismiss();
  }

  void setSearchString(String searchString) {
    emit(state.copyWith(searchString: searchString));
    getSearchList();
  }

  getAllItemsCatalog(userHRCode) async {
    state.getAllItemsCatalogList.data ??= [];
    if (state.getAllItemsCatalogList.data != null) {
      if (state.getAllItemsCatalogList.data!.isEmpty) {
        if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
          try {
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                  .loadingTreeData,
            ));
            await itemsCatalogRepository.getItemsCatalogTreeRepository(
                userHRCode)
                .then((value) async {
              List<ItemsCatalogTreeModel>? getAllItemsCatalogTreeList = [];
              if (value.data != null) {
                getAllItemsCatalogTreeList = value.data;
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .success,
                  itemsGetAllTree: getAllItemsCatalogTreeList,
                  getAllItemsCatalogList: value,
                ));
              } else {
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .failed,
                ));
              }
            }).catchError((error) {
              emit(state.copyWith(
                itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
              ));
            });
          } catch (e) {
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            ));
          }
        } else {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                .noConnection,
          ));
        }
      }
    }
  }

  void getSubTree(List<Items>? item, String? name) {
    List<ItemsCatalogTreeModel> newTreeList = <ItemsCatalogTreeModel>[];
    if (item != null) {
      for (int i = 0; i < item.length; i++) {
        newTreeList.add(
            ItemsCatalogTreeModel.fromJson(item[i].toJson()));
      }
      String dir = "";
      if (name != null) {
        dir = state.treeDirection + " > " + name;
      }
      emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
          itemsGetAllTree: newTreeList,
          treeDirection: dir
      ));
    }
  }

  void getCategoryDataWithId(userHRCode, id) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
              .loadingTreeData,
        ));
        await itemsCatalogRepository.getItemsCatalogListData(userHRCode, id)
            .then((value) async {
          List<ItemCategorygetAllData>? itemCatalogSearchData = [];
          if (value.data != null) {
            itemCatalogSearchData = value.data;
            print(itemCatalogSearchData?[2].itemDesc);
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
              itemsGetItemsCategory: itemCatalogSearchData,
                itemsGetAllTree:[]
            ));
          } else {
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            ));
          }
        }).catchError((error) {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
      }
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
            .noConnection,
      ));
    }
  }

  void setInitialization() {
  }

  void clearData() {
    emit(state.copyWith(searchString: '', searchResult: []));
  }

  void getAllCatalogList({required String itemCode}) async {
    emit(state.copyWith(
      itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    await _generalDio
        .getItemCatalogAllData(itemCode)
        .then((value) {
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCategorygetAllData> itemAllDatalist =
        List<ItemCategorygetAllData>.from(value.data['data']
            .map((model) => ItemCategorygetAllData.fromJson(model)));
        emit(state.copyWith(
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.success,
          itemAllDatalist: itemAllDatalist,
        ));
      } else if (value.data['data'] == null) {
        emit(state.copyWith(
          itemAllDatalist: [],
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      emit(state.copyWith(
          itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.failed));
    });
  }

  @override
  ItemCatalogSearchState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return ItemCatalogSearchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ItemCatalogSearchState state) {
    if (state.itemCatalogAllDataEnumStates ==
        ItemCatalogSearchEnumStates.success &&
        state.itemsGetAllTree.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}
