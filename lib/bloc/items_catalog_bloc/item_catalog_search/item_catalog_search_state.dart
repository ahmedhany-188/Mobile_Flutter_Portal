part of 'item_catalog_search_cubit.dart';

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed,loadingTreeData, successTreeData,noConnection, noDataFound}

class ItemCatalogSearchState extends Equatable {

  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
  final List<ItemCatalogSearchData> searchResult;
  final List<ItemCatalogFavoriteData> favoriteResult;
  final List<CartModelData> cartResult;
  final String searchString;
  final bool detail;
  final List<String> mainCategories;
  final List<int> mainCategoriesID;

  final bool itemCategoryShow;

  final List<ItemCategorygetAllData> itemAllDatalist;

  List<ItemCategorygetAllData> itemsGetItemsCategory;

  final ItemsCatalogCategory getAllItemsCatalogList;
  List<ItemsCatalogTreeModel> itemsGetAllTree;

  final bool listTapAction;

  final List<ItemCategoryAttachData> itemCategoryAttachData;

  final List<String> treeDirectionList;


  ItemCatalogSearchState({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemCatalogAllDataEnumStates=ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.favoriteResult = const <ItemCatalogFavoriteData>[],
    this.cartResult = const <CartModelData>[],
    this.itemAllDatalist = const <ItemCategorygetAllData>[],
    this.itemsGetAllTree = const<ItemsCatalogTreeModel>[],
    this.mainCategories = const<String>[],
    this.mainCategoriesID=const<int>[],
    this.itemCategoryAttachData = const<ItemCategoryAttachData>[],
    this.itemsGetItemsCategory = const<ItemCategorygetAllData>[],
    this.detail = false,
    this.itemCategoryShow=false,

    this.listTapAction=false,

    this.searchString = "",
    this.treeDirectionList = const<String>["Home"],
    required this.getAllItemsCatalogList,

  });

  ItemCatalogSearchState copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    ItemCatalogSearchEnumStates?itemCatalogAllDataEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    List<ItemCatalogFavoriteData>? favoriteResult,
    List<CartModelData>? cartResult,
    List<ItemCategorygetAllData>? itemAllDatalist,
    List<String>? mainCategories,
    List<int>? mainCategoriesID,
    bool? detail,
    bool? itemCategoryShow,
    bool? listTapAction,
    List<String>? treeDirectionList,
    String? searchString,
    List<ItemCategoryAttachData>? itemCategoryAttachData,
    List<ItemsCatalogTreeModel>? itemsGetAllTree,
    List<ItemCategorygetAllData>? itemsGetItemsCategory,
    ItemsCatalogCategory? getAllItemsCatalogList,

  }) {
    return ItemCatalogSearchState(
      itemCatalogSearchEnumStates: itemCatalogSearchEnumStates ?? this.itemCatalogSearchEnumStates,
      itemCatalogAllDataEnumStates:itemCatalogAllDataEnumStates??this.itemCatalogAllDataEnumStates,
      searchResult: searchResult ?? this.searchResult,
      favoriteResult: favoriteResult ?? this.favoriteResult,
      cartResult: cartResult ?? this.cartResult,
      itemAllDatalist: itemAllDatalist ?? this.itemAllDatalist,
      mainCategories: mainCategories ?? this.mainCategories,
      mainCategoriesID:mainCategoriesID??this.mainCategoriesID,
      searchString: searchString ?? this.searchString,
      treeDirectionList: treeDirectionList ?? this.treeDirectionList,
      itemCategoryAttachData: itemCategoryAttachData ??
          this.itemCategoryAttachData,
      itemsGetAllTree: itemsGetAllTree ?? this.itemsGetAllTree,
      itemsGetItemsCategory: itemsGetItemsCategory ??
          this.itemsGetItemsCategory,
      getAllItemsCatalogList: getAllItemsCatalogList ??
          this.getAllItemsCatalogList,
      detail: detail ?? this.detail,
      itemCategoryShow:itemCategoryShow??this.itemCategoryShow,
        listTapAction:listTapAction??this.listTapAction,
    );
  }

  @override
  List<Object> get props =>
      [
        itemCatalogSearchEnumStates,
        itemCatalogAllDataEnumStates,
        searchResult,
        favoriteResult,
        cartResult,
        itemAllDatalist,
        mainCategories,
        mainCategoriesID,
        searchString,
        treeDirectionList,
        getAllItemsCatalogList,
        itemsGetAllTree,
        itemsGetItemsCategory,
        detail,
        itemCategoryShow,
        listTapAction,
        itemCategoryAttachData,
        itemsGetItemsCategory
      ];

  Map<String, dynamic> toMap() {
    return {
      'itemCatalogSearchEnumStates': itemCatalogSearchEnumStates,
      'itemCatalogAllDataEnumStates':itemCatalogAllDataEnumStates,
      'searchResult': searchResult,
      'favoriteResult': favoriteResult,
      'cartResult': cartResult,
      'searchString': searchString,
      'detail': detail,
      'itemCategoryShow':itemCategoryShow,
      'listTapAction':listTapAction,
      'itemAllDatalist': itemAllDatalist,
      'mainCategories': mainCategories,
      'mainCategoriesID':mainCategoriesID,
      'itemsGetItemsCategory': itemsGetItemsCategory,
      'getAllItemsCatalogList': getAllItemsCatalogList,
      'itemsGetAllTree': itemsGetAllTree,
      'itemCategoryAttachData': itemCategoryAttachData,
      'treeDirectionList': treeDirectionList,
    };
  }

  factory ItemCatalogSearchState.fromMap(Map<String, dynamic> map) {
    return ItemCatalogSearchState(
      itemCatalogSearchEnumStates: map['itemCatalogSearchEnumStates'] as ItemCatalogSearchEnumStates,
      itemCatalogAllDataEnumStates:map['itemCatalogAllDataEnumStates'] as ItemCatalogSearchEnumStates,
      searchResult: map['searchResult'] as List<ItemCatalogSearchData>,
      favoriteResult: map['favoriteResult'] as List<ItemCatalogFavoriteData>,
      cartResult: map['cartResult'] as List<CartModelData>,
      searchString: map['searchString'] as String,
      detail: map['detail'] as bool,
      itemCategoryShow: map['itemCategoryShow'] as bool,
      listTapAction:map['listTapAction'] as bool,
      itemAllDatalist: map['itemAllDatalist'] as List<ItemCategorygetAllData>,
      mainCategories: map['mainCategories'] as List<String>,
      mainCategoriesID: map['mainCategoriesID'] as List<int>,
      itemsGetItemsCategory:
      map['itemsGetItemsCategory'] as List<ItemCategorygetAllData>,
      getAllItemsCatalogList:
      map['getAllItemsCatalogList'] as ItemsCatalogCategory,
      itemsGetAllTree: map['itemsGetAllTree'] as List<ItemsCatalogTreeModel>,
      itemCategoryAttachData:
      map['itemCategoryAttachData'] as List<ItemCategoryAttachData>,
      treeDirectionList: map['treeDirectionList'] as List<String>,
    );
  }
}




