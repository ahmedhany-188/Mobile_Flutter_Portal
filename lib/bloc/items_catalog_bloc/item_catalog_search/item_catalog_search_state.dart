part of 'item_catalog_search_cubit.dart';

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed,loadingTreeData, successTreeData,noConnection }

class ItemCatalogSearchState extends Equatable {

   ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
   ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
   List<ItemCatalogSearchData> searchResult;
   String searchString;

   List<ItemCategorygetAllData> itemAllDatalist;

   List<ItemCategorygetAllData> itemsGetItemsCategory;

   ItemsCatalogCategory getAllItemsCatalogList;
   List<ItemsCatalogTreeModel> itemsGetAllTree;
   List<ItemCategoryAttachData> itemCategoryAttachData;

   String treeDirection;



  ItemCatalogSearchState({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.itemCatalogAllDataEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemAllDatalist = const <ItemCategorygetAllData>[],
    this.itemsGetAllTree=const<ItemsCatalogTreeModel>[],
    this.itemCategoryAttachData=const<ItemCategoryAttachData>[],
    this.itemsGetItemsCategory=const<ItemCategorygetAllData>[],

    this.searchString = "",
    this.treeDirection="",
    required this.getAllItemsCatalogList,

  });

  ItemCatalogSearchState copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    ItemCatalogSearchEnumStates? itemCatalogAllDataEnumStates,
    List<ItemCategorygetAllData>? itemAllDatalist,
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
      itemCatalogAllDataEnumStates: itemCatalogAllDataEnumStates ??
          this.itemCatalogAllDataEnumStates,
      itemAllDatalist: itemAllDatalist ?? this.itemAllDatalist,
      searchString: searchString ?? this.searchString,
      treeDirection:treeDirection??this.treeDirection,
      itemCategoryAttachData:itemCategoryAttachData??this.itemCategoryAttachData,
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
        itemCategoryAttachData,
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




