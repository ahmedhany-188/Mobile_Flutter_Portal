part of 'item_catalog_search_cubit.dart';

abstract class ItemCatalogSearchState extends Equatable {
  const ItemCatalogSearchState();
}

enum ItemCatalogSearchEnumStates { initial, success, filtered, failed }

class ItemCatalogSearchInitial extends ItemCatalogSearchState {
  final ItemCatalogSearchEnumStates itemCatalogSearchEnumStates;
  final List<ItemCatalogSearchModel> searchResult;

  const ItemCatalogSearchInitial({
    this.itemCatalogSearchEnumStates = ItemCatalogSearchEnumStates.initial,
    this.searchResult = const <ItemCatalogSearchModel>[],
  });

  ItemCatalogSearchInitial copyWith({
    ItemCatalogSearchEnumStates? itemCatalogSearchEnumStates,
    List<ItemCatalogSearchModel>? searchResult,

  }) {
    return ItemCatalogSearchInitial(
      itemCatalogSearchEnumStates: itemCatalogSearchEnumStates ?? this.itemCatalogSearchEnumStates,
      searchResult: searchResult ?? this.searchResult
    );
  }

  @override
  List<Object> get props => [itemCatalogSearchEnumStates,searchResult];
}
