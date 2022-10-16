
import 'package:equatable/equatable.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';

enum ItemCatalogGetAllDataEnumStates {loading, success, failed,noConnection,fullSuccess}

class ItemCatalogGetAllState extends Equatable{

  final ItemCatalogGetAllDataEnumStates itemCatalogGetAllDataEnumStates;
  final  List<ItemsCatalogModel> getAllItemsCatalogList;

  ItemCatalogGetAllState({
    this.itemCatalogGetAllDataEnumStates = ItemCatalogGetAllDataEnumStates.loading,
    this.getAllItemsCatalogList = const <ItemsCatalogModel>[],
  });

  ItemCatalogGetAllState copyWith({
    ItemCatalogGetAllDataEnumStates? itemCatalogGetAllDataEnumStates,
    List<ItemsCatalogModel>? getAllItemsCatalogList,
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
        getAllItemsCatalogList: <ItemsCatalogModel>[],
      );
    }
    int val = json['itemCatalogGetAllDataEnumStates'];
    return ItemCatalogGetAllState(
        itemCatalogGetAllDataEnumStates: ItemCatalogGetAllDataEnumStates.values[val],
        getAllItemsCatalogList: List<ItemsCatalogModel>.from(
            json['getAllItemsCatalogList']?.map((p) =>
                ItemsCatalogModel.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCatalogGetAllDataEnumStates':itemCatalogGetAllDataEnumStates.index,
      'getAllItemsCatalogList': getAllItemsCatalogList,
    };
  }
}