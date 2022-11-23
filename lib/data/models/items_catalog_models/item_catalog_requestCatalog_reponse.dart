class NewRequestCatalogModelResponse {
  int? code;
  String? message;
  bool? error;
  List<Data>? data;

  NewRequestCatalogModelResponse({this.code, this.message, this.error, this.data});

  NewRequestCatalogModelResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? requestID;
  int? findItemID;
  String? date;
  String? itemName;
  int? catID;
  String? catName;
  String? status;
  String? itemDesc;

  Data(
      {this.requestID,
        this.findItemID,
        this.date,
        this.itemName,
        this.catID,
        this.catName,
        this.status,
        this.itemDesc});

  Data.fromJson(Map<String, dynamic> json) {
    requestID = json['requestID'];
    findItemID = json['findItem_ID'];
    date = json['date'];
    itemName = json['itemName'];
    catID = json['cat_ID'];
    catName = json['catName'];
    status = json['status'];
    itemDesc = json['itemDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestID'] = this.requestID;
    data['findItem_ID'] = this.findItemID;
    data['date'] = this.date;
    data['itemName'] = this.itemName;
    data['cat_ID'] = this.catID;
    data['catName'] = this.catName;
    data['status'] = this.status;
    data['itemDesc'] = this.itemDesc;
    return data;
  }
}