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
        data!.add( Data.fromJson(v));
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
    data['requestID'] = requestID;
    data['findItem_ID'] = findItemID;
    data['date'] = date;
    data['itemName'] = itemName;
    data['cat_ID'] = catID;
    data['catName'] = catName;
    data['status'] = status;
    data['itemDesc'] = itemDesc;
    return data;
  }
}