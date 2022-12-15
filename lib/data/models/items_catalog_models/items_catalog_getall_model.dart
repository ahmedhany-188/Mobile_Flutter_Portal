
import '../../../data/models/items_catalog_models/items_catalog_tree_model.dart';

class ItemsCatalogCategory {
  int? code;
  String? message;
  bool? error;
  List<ItemsCatalogTreeModel>? data;
   ItemsCatalogCategory({this.code, this.message, this.error, this.data});

  ItemsCatalogCategory.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ItemsCatalogTreeModel>[];
      json['data'].forEach((v) {
        data!.add(ItemsCatalogTreeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

