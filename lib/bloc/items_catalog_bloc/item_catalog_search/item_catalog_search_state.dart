part of 'item_catalog_search_cubit.dart';

abstract class ItemCatalogSearchState extends Equatable {
  const ItemCatalogSearchState();
}

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed }

class ItemCatalogSearchInitial extends Equatable {
  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final List<ItemCatalogSearchData> searchResult;
  final ItemCatalogSearchEnumStates itemCatalogAllDataEnumStates;
  final List<ItemCategorygetAllData> itemAllDatalist;
  final String searchString;

  const ItemCatalogSearchInitial({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchData>[],
    this.itemCatalogAllDataEnumStates = ItemCatalogSearchEnumStates.initial,
    this.itemAllDatalist = const <ItemCategorygetAllData>[],

    this.searchString ="",
  });

  ItemCatalogSearchInitial copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchData>? searchResult,
    ItemCatalogSearchEnumStates? itemCatalogAllDataEnumStates,
    List<ItemCategorygetAllData>? itemAllDatalist,
    String? searchString,

  }) {
    return ItemCatalogSearchInitial(
      itemCatalogSearchEnumStates: itemCatalogSearchEnumStates ?? this.itemCatalogSearchEnumStates,
      searchResult: searchResult ?? this.searchResult,
      itemCatalogAllDataEnumStates: itemCatalogAllDataEnumStates ?? this.itemCatalogAllDataEnumStates,
      itemAllDatalist: itemAllDatalist ?? this.itemAllDatalist,

      searchString: searchString ?? this.searchString,
    );
  }

  @override
  List<Object> get props => [itemCatalogSearchEnumStates,searchResult,itemCatalogAllDataEnumStates,itemAllDatalist,searchString];
}
