part of 'item_catalog_search_cubit.dart';

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed,loadingTreeData, successTreeData,noConnection }

class ItemCatalogSearchState extends Equatable {

  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
  final List<ItemCatalogSearchData> searchResult;
  final List<ItemCatalogFavoriteData> favoriteResult;
  final List<CartModelData> cartResult;
  final String searchString;
  final bool detail;

  final List<ItemCategorygetAllData> itemAllDatalist;

   List<ItemCategorygetAllData> itemsGetItemsCategory;

  final ItemsCatalogCategory getAllItemsCatalogList;
   List<ItemsCatalogTreeModel> itemsGetAllTree;
  final List<ItemCategoryAttachData> itemCategoryAttachData;

  final  String treeDirection;



   ItemCatalogSearchState({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.favoriteResult = const <ItemCatalogFavoriteData>[],
    this.cartResult = const <CartModelData>[],
    this.itemCatalogAllDataEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemAllDatalist = const <ItemCategorygetAllData>[],
    this.itemsGetAllTree=const<ItemsCatalogTreeModel>[],
    this.itemCategoryAttachData=const<ItemCategoryAttachData>[],
    this.itemsGetItemsCategory=const<ItemCategorygetAllData>[],
    this.detail = false,

    this.searchString = "",
    this.treeDirection="",
    required this.getAllItemsCatalogList,

  });

  ItemCatalogSearchState copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    List<ItemCatalogFavoriteData>? favoriteResult,
    List<CartModelData>? cartResult,
    ItemCatalogSearchEnumStates? itemCatalogAllDataEnumStates,
    List<ItemCategorygetAllData>? itemAllDatalist,
    bool? detail,
    String?  treeDirection,
    String? searchString,
    List<ItemCategoryAttachData>? itemCategoryAttachData,
    List<ItemsCatalogTreeModel>? itemsGetAllTree,
    List<ItemCategorygetAllData>? itemsGetItemsCategory,
    ItemsCatalogCategory? getAllItemsCatalogList,

  }) {
    return ItemCatalogSearchState(
      itemCatalogSearchEnumStates: itemCatalogSearchEnumStates ??
          this.itemCatalogSearchEnumStates,
      searchResult: searchResult ?? this.searchResult,
      favoriteResult: favoriteResult ?? this.favoriteResult,
      cartResult: cartResult ?? this.cartResult,
      itemCatalogAllDataEnumStates: itemCatalogAllDataEnumStates ??
          this.itemCatalogAllDataEnumStates,
      itemAllDatalist: itemAllDatalist ?? this.itemAllDatalist,
      searchString: searchString ?? this.searchString,
      treeDirection:treeDirection??this.treeDirection,
      itemCategoryAttachData:itemCategoryAttachData??this.itemCategoryAttachData,
      itemsGetAllTree : itemsGetAllTree ?? this.itemsGetAllTree,
      itemsGetItemsCategory : itemsGetItemsCategory ?? this.itemsGetItemsCategory,
      getAllItemsCatalogList: getAllItemsCatalogList ?? this.getAllItemsCatalogList,
      detail: detail ?? this.detail,
    );
  }

  @override
  List<Object> get props =>
      [
        itemCatalogSearchEnumStates,
        searchResult,
        favoriteResult,
        cartResult,
        itemCatalogAllDataEnumStates,
        itemAllDatalist,
        searchString,
        treeDirection,
        getAllItemsCatalogList,
        itemsGetAllTree,
        itemsGetItemsCategory,
        detail,
        itemCategoryAttachData,
        itemsGetItemsCategory
      ];

  Map<String, dynamic> toMap() {
    return {
      // 'itemCatalogSearchEnumStates': this.itemCatalogSearchEnumStates,
      // 'itemCatalogAllDataEnumStates': this.itemCatalogAllDataEnumStates,
      'searchResult': searchResult,
      'favoriteResult': favoriteResult,
      'cartResult': cartResult,
      'searchString': searchString,
      'detail': detail,
      'itemAllDatalist': itemAllDatalist,
      'itemsGetItemsCategory': itemsGetItemsCategory,
      'getAllItemsCatalogList': getAllItemsCatalogList,
      'itemsGetAllTree': itemsGetAllTree,
      'itemCategoryAttachData': itemCategoryAttachData,
      'treeDirection': treeDirection,
    };
  }

  factory ItemCatalogSearchState.fromMap(Map<String, dynamic> map) {
    return ItemCatalogSearchState(
      // itemCatalogSearchEnumStates:
      //     map['itemCatalogSearchEnumStates'] as ItemCatalogSearchEnumStates,
      // itemCatalogAllDataEnumStates:
      //     map['itemCatalogAllDataEnumStates'] as ItemCatalogSearchEnumStates,
      searchResult: map['searchResult'] as List<ItemCatalogSearchData>,
      favoriteResult: map['favoriteResult'] as List<ItemCatalogFavoriteData>,
      cartResult: map['cartResult'] as List<CartModelData>,
      searchString: map['searchString'] as String,
      detail: map['detail'] as bool,
      itemAllDatalist: map['itemAllDatalist'] as List<ItemCategorygetAllData>,
      itemsGetItemsCategory:
          map['itemsGetItemsCategory'] as List<ItemCategorygetAllData>,
      getAllItemsCatalogList:
          map['getAllItemsCatalogList'] as ItemsCatalogCategory,
      itemsGetAllTree: map['itemsGetAllTree'] as List<ItemsCatalogTreeModel>,
      itemCategoryAttachData:
          map['itemCategoryAttachData'] as List<ItemCategoryAttachData>,
      treeDirection: map['treeDirection'] as String,
    );
  }
}




