part of 'item_catalog_search_cubit.dart';

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed,loadingTreeData, successTreeData,noConnection }

class ItemCatalogSearchState extends Equatable {

  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
  final List<ItemCatalogSearchData> searchResult;
  final String searchString;
  final bool detail;

  final List<ItemCategorygetAllData> itemAllDatalist;

  final List<ItemCategorygetAllData> itemsGetItemsCategory;

  final ItemsCatalogCategory getAllItemsCatalogList;
  final List<ItemsCatalogTreeModel> itemsGetAllTree;

  final String treeDirection;



  const ItemCatalogSearchState({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.itemCatalogAllDataEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemAllDatalist = const <ItemCategorygetAllData>[],
    this.itemsGetAllTree=const<ItemsCatalogTreeModel>[],
    this.itemsGetItemsCategory=const<ItemCategorygetAllData>[],
    this.detail = false,

    this.searchString = "",
    this.treeDirection="",
    required this.getAllItemsCatalogList,

  });

  ItemCatalogSearchState copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    ItemCatalogSearchEnumStates? itemCatalogAllDataEnumStates,
    List<ItemCategorygetAllData>? itemAllDatalist,
    bool? detail,
    String?  treeDirection,
    String? searchString,
    List<ItemsCatalogTreeModel>? itemsGetAllTree,
    List<ItemCategorygetAllData>? itemsGetItemsCategory,
    ItemsCatalogCategory? getAllItemsCatalogList,

  }) {
    return ItemCatalogSearchState(
      itemCatalogSearchEnumStates: itemCatalogSearchEnumStates ??
          this.itemCatalogSearchEnumStates,
      searchResult: searchResult ?? this.searchResult,
      itemCatalogAllDataEnumStates: itemCatalogAllDataEnumStates ??
          this.itemCatalogAllDataEnumStates,
      itemAllDatalist: itemAllDatalist ?? this.itemAllDatalist,
      searchString: searchString ?? this.searchString,
      treeDirection:treeDirection??this.treeDirection,
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
        itemCatalogAllDataEnumStates,
        itemAllDatalist,
        searchString,
        treeDirection,
        getAllItemsCatalogList,
        itemsGetAllTree,
        itemsGetItemsCategory,
        detail,
      ];


  static ItemCatalogSearchState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return ItemCatalogSearchState(
        itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.loadingTreeData,
        getAllItemsCatalogList: ItemsCatalogCategory(),
      );
    }
    ItemsCatalogCategory list = json['getAllItemsCatalogList'];
    int val = json['itemCatalogGetAllDataEnumStates'];
    return ItemCatalogSearchState(
      itemCatalogSearchEnumStates: ItemCatalogSearchEnumStates.values[val],
      getAllItemsCatalogList: list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCatalogGetAllDataEnumStates':itemCatalogSearchEnumStates.index,
      'getAllItemsCatalogList': getAllItemsCatalogList,
    };
  }


}




