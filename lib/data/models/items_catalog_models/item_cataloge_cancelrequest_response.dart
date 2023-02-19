import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';

class NewRequestCatalogCancelRequestResponse {
  int? code;
  String? message;
  bool? error;
  List<NewRequestCatalogModel>? data;

  NewRequestCatalogCancelRequestResponse({this.code, this.message, this.error, this.data});

  NewRequestCatalogCancelRequestResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <NewRequestCatalogModel>[];
      json['data'].forEach((v) {
        data!.add( NewRequestCatalogModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}