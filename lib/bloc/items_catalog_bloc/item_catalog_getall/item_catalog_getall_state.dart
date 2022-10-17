
import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';

enum ItemCatalogGetAllDataEnumStates {loading, success, failed,noConnection}

class ItemCatalogGetAllState extends Equatable{

  final ItemCatalogGetAllDataEnumStates itemCatalogGetAllDataEnumStates;
  final  List<ItemsCatalogCategory> getAllItemsCatalogList;

  ItemCatalogGetAllState({
    this.itemCatalogGetAllDataEnumStates = ItemCatalogGetAllDataEnumStates.loading,
    this.getAllItemsCatalogList = const <ItemsCatalogCategory>[],
  });

  ItemCatalogGetAllState copyWith({
    ItemCatalogGetAllDataEnumStates? itemCatalogGetAllDataEnumStates,
    List<ItemsCatalogCategory>? getAllItemsCatalogList,
  }) {
    return ItemCatalogGetAllState(
      itemCatalogGetAllDataEnumStates: itemCatalogGetAllDataEnumStates ?? this.itemCatalogGetAllDataEnumStates,
      getAllItemsCatalogList: getAllItemsCatalogList ?? this.getAllItemsCatalogList,
    );
  }

  @override
  List<Object> get props => [
    itemCatalogGetAllDataEnumStates,getAllItemsCatalogList
  ];

  static ItemCatalogGetAllState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return ItemCatalogGetAllState(
        itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.loading,
        getAllItemsCatalogList: <ItemsCatalogCategory>[],
      );
    }
    int val = json['itemCatalogGetAllDataEnumStates'];
    return ItemCatalogGetAllState(
        itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.values[val],
        getAllItemsCatalogList: List<ItemsCatalogCategory>.from(
            json['getAllItemsCatalogList']?.map((p) =>
                ItemsCatalogCategory.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCatalogGetAllDataEnumStates':itemCatalogGetAllDataEnumStates.index,
      'getAllItemsCatalogList': getAllItemsCatalogList,
    };
  }
}