part of 'item_catalog_search_cubit.dart';

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed,loadingTreeData, successTreeData,noConnection }

class ItemCatalogSearchState extends Equatable {

  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final List<ItemCatalogSearchData> searchResult;
  final ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
  final List<ItemCategorygetAllData> itemAllDatalist;
  final List<ItemsCatalogTreeModel> itemsGetAllTree;
  final List<ItemCategorygetAllData> itemsGetItemsCategory;

  final String searchString;
  final ItemsCatalogCategory getAllItemsCatalogList;
  final String treeDirection;



  ItemCatalogSearchState({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.itemCatalogAllDataEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemAllDatalist = const <ItemCategorygetAllData>[],
    this.itemsGetAllTree=const<ItemsCatalogTreeModel>[],
    this.itemsGetItemsCategory=const<ItemCategorygetAllData>[],

    this.searchString = "",
    this.treeDirection="Home",
    required this.getAllItemsCatalogList,

  });

  ItemCatalogSearchState copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    ItemCatalogSearchEnumStates? itemCatalogAllDataEnumStates,
    List<ItemCategorygetAllData>? itemAllDatalist,
    String? searchString,treeDirection,
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
        itemsGetItemsCategory
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




