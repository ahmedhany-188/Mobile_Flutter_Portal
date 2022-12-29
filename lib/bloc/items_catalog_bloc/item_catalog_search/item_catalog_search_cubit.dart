import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_attachs_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/export_excel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/data_providers/general_dio/general_dio.dart';
import '../../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../../data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../../data/models/items_catalog_models/item_catalog_cart_model.dart';
import '../../../data/models/items_catalog_models/item_catalog_favorite.dart';
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
          if(!isClosed){
            emit(state.copyWith(
              itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            ));
          }

        }
      }
    });
  }

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;
  final ItemsCatalogGetAllRepository itemsCatalogRepository;

  static ItemCatalogSearchCubit get(context) => BlocProvider.of(context);

  void getSearchList() async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
      ));
      await _generalDio
          .getItemCatalogSearch(state.searchString)
          .then((value) {
        if (value.data['data'] != null && value.statusCode == 200) {
          List<ItemCatalogSearchData> searchResult =
          List<ItemCatalogSearchData>.from(value.data['data']
              .map((model) => ItemCatalogSearchData.fromJson(model)));
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
            searchResult: searchResult,
          ));
        } else if (value.data['data'] == null) {
          emit(state.copyWith(
            searchResult: [],
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noDataFound,
          ));
        } else {
          throw RequestFailureApi.fromCode(value.statusCode!);
        }
      }).catchError((error) {
        emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed));
      });
    }else{
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noConnection,
      ));
    }
  }

  void getFavoriteItems({required String userHrCode}) async{
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
    ));
    await _generalDio.getItemCatalogFavorite(userHrCode).then((value) {
      if (value.data['data'] != null && value.statusCode == 200) {
        List<ItemCatalogFavoriteData> favoriteResult =
        List<ItemCatalogFavoriteData>.from(value.data['data']
            .map((model) => ItemCatalogFavoriteData.fromJson(model)));
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
          favoriteResult: favoriteResult,
        ));
      }
      else if (value.data['data'] == null) {
        emit(state.copyWith(
          favoriteResult: [],
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noDataFound,
        ));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    });
    }else{
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noConnection,
      ));
    }
  }

  void getCartItems({required String userHrCode}) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
            .loadingTreeData,
      ));
      await _generalDio.getItemCatalogCart(userHrCode).then((value) {
        if (value.data['data'] != null && value.statusCode == 200) {
          List<CartModelData> cartResult =
          List<CartModelData>.from(value.data['data']
              .map((model) => CartModelData.fromJson(model)));
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
            cartResult: cartResult,
          ));
        }
        else if (value.data['data'] == null) {
          emit(state.copyWith(
            cartResult: [],
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                .noDataFound,
          ));
        } else {
          throw RequestFailureApi.fromCode(value.statusCode!);
        }
      });
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noConnection,
      ));
    }
  }

  void setSearchString(String searchString) {
    emit(state.copyWith(searchString: searchString,detail: true, searchResult: [],));
    getSearchList();
  }

  getAllItemsCatalog(userHRCode) async {

    ItemsCatalogCategory listData=state.getAllItemsCatalogList;
    listData.data=[];

    emit(state.copyWith(
      getAllItemsCatalogList:listData,
    ));

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
                state.itemsGetAllTree=getAllItemsCatalogTreeList!;

                List<String> mainCategories=[];
                for(int i=0;i<getAllItemsCatalogTreeList.length;i++){
                  mainCategories.add(getAllItemsCatalogTreeList[i].text??"");
                }
                List<int> mainCategoriesID=[];
                for(int i=0;i<getAllItemsCatalogTreeList.length;i++){
                  mainCategoriesID.add(getAllItemsCatalogTreeList[i].id??0);
                }
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
                  // itemsGetAllTree: getAllItemsCatalogTreeList,
                  mainCategoriesID:mainCategoriesID,
                  getAllItemsCatalogList: value,
                  mainCategories: mainCategories,
                ));

              } else {
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .noDataFound,
                ));
              }
            }).catchError((error) {
              emit(state.copyWith(
                itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
              ));
            });

            await itemsCatalogRepository.getItemsCatalogAttachTreeRepository(userHRCode)
                .then((value) async {
              List<ItemCategoryAttachData> getAllItemsCatalogAttachTreeList = [];
              if (value.data != null) {
                getAllItemsCatalogAttachTreeList = value.data??[];
                getCategoryImages(getAllItemsCatalogAttachTreeList);
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
                ));
              } else {
                emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .noDataFound,
                ));
              }
            }).catchError((error) {
              emit(state.copyWith(
                itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
              ));
            });
          } catch (e) {
            /// commented this to avoid emit after close the state to avoid error crashes
            // emit(state.copyWith(
            //   itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
            // ));
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

  Future<void> setFavorite({required String hrCode, required int itemCode}) async{

    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    Map<String, dynamic> favoriteDataPost =
      {
        "id": 0,
        "hrCode": hrCode,
        "item_Code": itemCode,
        "in_User": hrCode,
        "in_Date": DateTime.now().toString(),
        "up_User": "",
        "up_Date": DateTime.now().toString(),
    };
    await _generalDio.postItemCatalogFavorite(favoriteDataPost).
    then((value) {
      getFavoriteItems(userHrCode: hrCode);
      EasyLoading.dismiss();
    })
        .catchError((e) {
      EasyLoading.showError('Something went wrong');
      throw e;
    });
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
            .noConnection,
      ));
    }
  }
  Future<void> deleteFavorite({required String hrCode,required int itemId}) async{
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {

      EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    await _generalDio.removeItemCatalogFavorite(itemId).
    then((value) {
      getFavoriteItems(userHrCode: hrCode);
      EasyLoading.dismiss();
    })
        .catchError((e) {
      EasyLoading.showError('Something went wrong');
      throw e;
    });
  } else {
  emit(state.copyWith(
  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
      .noConnection,
  ));
  }
  }
  Future<void> deleteAllFavorite({required String hrCode}) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
      ));
      await _generalDio.removeAllFavorite().
      then((value) {
        getFavoriteItems(userHrCode: hrCode);
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
        ));
      }).catchError((e) {
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
        ));
        throw e;
      });
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noConnection,
      ));
    }
  }

  Future<void> addToCart({required String hrCode, required int itemCode,required int qty}) async{
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {

      EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    Map<String, dynamic> cartDataPost =
    {
      "id": 0,
      "orderID": 0,
      "hrCode": hrCode,
      "item_Code": itemCode,
      "item_Qty": qty,
      "isClosed": true,
      "in_User": hrCode,
      "in_Date":  DateTime.now().toString(),
      "up_User": "",
      "up_Date":  DateTime.now().toString()
    };
    await _generalDio.postItemCatalogCart(cartDataPost).
    then((value) {
      // TODO: add to cart respnse here {value}
      getCartItems(userHrCode: hrCode);
      EasyLoading.dismiss();
    })
        .catchError((e) {
      EasyLoading.showError('Something went wrong');
      throw e;
    });
  } else {
emit(state.copyWith(
itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
    .noConnection,
));
}
  }
  Future<void> deleteFromCart({required String hrCode,required int itemId}) async{
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {

      EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
    ));
    await _generalDio.removeItemCatalogCart(itemId).
    then((value) {
      getCartItems(userHrCode: hrCode);
      EasyLoading.dismiss();
    })
        .catchError((e) {
      EasyLoading.showError('Something went wrong');
      throw e;
    });
  } else {
emit(state.copyWith(
itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
    .noConnection,
));
}
  }
  Future<void> placeOrder({required String hrCode}) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
      ));
      List<CartModelData> listData = [];
      for (int i = 0; i < state.cartResult.length; i++) {
        CartModelData detailedDataPost = CartModelData(
            id: state.cartResult[i].id,
            orderID: 0,
            hrCode: state.cartResult[i].hrCode,
            itemCode: state.cartResult[i].itemCode,
            itemQty: state.cartResult[i].itemQty,
            itmCatItems: state.cartResult[i].itmCatItems,
            isClosed: true,
            inUser: state.cartResult[i].inUser,
            inDate: state.cartResult[i].inDate,
            upUser: state.cartResult[i].upUser,
            upDate: state.cartResult[i].upDate
        );
        listData.add(detailedDataPost);
      }
      await _generalDio.putCartOrder(listData).then((value) async {
        if (value.data['data'] != null) {
          List<CartModelData> cartResultWithID = List<CartModelData>.from(
              value.data['data']
                  .map((model) => CartModelData.fromJson(model)));
          int? orderID = cartResultWithID[0].orderID ?? -1;
          if (orderID != -1) {
            await importDataCart(listData,
                orderID); //,cartList:ItemCatalogSearchCubit.get(context).state.cartResult );
          }
          emit(state.copyWith(cartResult: []));
          EasyLoading.showSuccess("Order Added");
        } else if (value.data['data'] == null) {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
          ));
        } else {
          throw RequestFailureApi.fromCode(value.statusCode!);
        }
      }).catchError((e) {
        emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
        ));
        throw e;
      });
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
            .noConnection,
      ));
    }
  }

  void getSubTree(List<Items>? item) {
    emit(state.copyWith(
     listTapAction: true,
        itemCategoryShow:false
    ));
    List<ItemsCatalogTreeModel> newTreeList = <ItemsCatalogTreeModel>[];
    if (item != null) {
      for (int i = 0; i < item.length; i++) {
        newTreeList.add(ItemsCatalogTreeModel.fromJson(item[i].toJson()));
      }
      emit(state.copyWith(
          itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
          itemsGetAllTree: newTreeList,
      ));
      getCategoryImages(state.itemCategoryAttachData);
    }
  }

  void setTreeDirectionList(String? name){


    List<String> treeDirectionList=[];
    for(int i=0;i<state.treeDirectionList.length;i++){
      treeDirectionList.add(state.treeDirectionList[i]);
    }
    treeDirectionList.add(name??"");
    emit(state.copyWith(
        treeDirectionList: treeDirectionList,
            listTapAction: false
    ));
  }

  void getCategoryDataWithId(userHRCode, id) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
          emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
              itemCategoryShow: true,
              itemsGetItemsCategory: []
          ));
          await itemsCatalogRepository.getItemsCatalogListData(userHRCode, id)
              .then((value) async {
            List<ItemCategorygetAllData>? itemCatalogSearchData = [];
            if (value.data != null) {
              itemCatalogSearchData = value.data;
              emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .success,
                  itemsGetItemsCategory: itemCatalogSearchData,
                  itemsGetAllTree: []
              ));
          } else if (value.data == null){
              emit(state.copyWith(
                  itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
                      .noDataFound,
                  itemsGetAllTree: [],
                  itemsGetItemsCategory: []
              ));
            }else{
            throw RequestFailureApi.fromCode(value.code!);
            }
          }).catchError((error) {
            emit(state.copyWith(
                itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
                itemsGetAllTree: [],
                itemsGetItemsCategory: []
            ));
          });
        }
      else {
        emit(state.copyWith(
            itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.noConnection,
            itemsGetAllTree: [],
            itemsGetItemsCategory: []
        ));
      }
  }

  void setInitialization() {
    emit(state.copyWith(
      treeDirectionList:["Home"],
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
      itemsGetAllTree: state.getAllItemsCatalogList.data,
        detail: false,
        itemCategoryShow:false
    ));

  }

  int getTreeLenght(){
    return state.treeDirectionList.length;
  }

  Future<void> getNewSubTree(int index) async {
    List<ItemsCatalogTreeModel>? treeList=state.getAllItemsCatalogList.data;
    List<String>? treeDirectionList =state.treeDirectionList;
    setInitialization();
    outerLoop:
    for(int i=0;i<treeDirectionList.length;i++){
      treeList = state.itemsGetAllTree;
      for(int j=0;j<treeList.length;j++){
        if(treeList[j].text==treeDirectionList[i]){
          getSubTree(treeList[j].items);
          if(index==i){
            index++;
            emit(state.copyWith(
                treeDirectionList:treeDirectionList.sublist(0,index)
            ));
            break outerLoop;
          }
        }
      }
    }
    emit(state.copyWith(
        listTapAction: false,
        itemCategoryShow:false
    ));
  }

  void clearData() {
    emit(state.copyWith(searchString: '', searchResult: [],detail: false));
  }

  // void setDetail({required String itemCode}) async{
  //   await getAllCatalogList(itemCode: itemCode);
  //   emit(state.copyWith(detail: true,));
  // }

  Future<void> getAllCatalogList({required String itemCode}) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      emit(state.copyWith(
        itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.initial,
        // itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.initial,
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
            // itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.success,
            itemAllDatalist: itemAllDatalist,
          ));
        } else if (value.data['data'] == null) {
          emit(state.copyWith(
            itemAllDatalist: [],
            itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.noDataFound,

            // itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed,
          ));
        } else {
          throw RequestFailureApi.fromCode(value.statusCode!);
        }
      }).catchError((error) {
        emit(state.copyWith(
            // itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.failed));
            itemCatalogAllDataEnumStates: ItemCatalogSearchEnumStates.failed));

      });
    } else {
      emit(state.copyWith(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
            .noConnection,
      ));
    }
  }

  @override
  ItemCatalogSearchState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return ItemCatalogSearchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ItemCatalogSearchState state) {
    // if (state.itemCatalogSearchEnumStates ==
    if (state.itemCatalogAllDataEnumStates  ==
        ItemCatalogSearchEnumStates.success &&
        state.itemsGetAllTree.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

  getCategoryImages(List<ItemCategoryAttachData> getAllItemsCatalogAttachTreeList) {
    List<ItemsCatalogTreeModel> itemsGetAllTreeTest = state.itemsGetAllTree;
    for (int i = 0; i < itemsGetAllTreeTest.length; i++) {
      for (int j = 0; j < getAllItemsCatalogAttachTreeList.length; j++) {
        if (itemsGetAllTreeTest[i].id == getAllItemsCatalogAttachTreeList[j].catId) {
          itemsGetAllTreeTest[i].main_Photo = getAllItemsCatalogAttachTreeList[j].catPhoto;
        }
      }
    }
    emit(state.copyWith(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates
          .success,
      itemsGetAllTree: itemsGetAllTreeTest,
      itemCategoryAttachData: getAllItemsCatalogAttachTreeList,
    ));
  }

}
