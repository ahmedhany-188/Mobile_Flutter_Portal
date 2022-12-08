class OrderHistoryModel {
  int? code;
  String? message;
  bool? error;
  List<OrderHistoryData>? data;

  OrderHistoryModel({this.code, this.message, this.error, this.data});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OrderHistoryData>[];
      json['data'].forEach((v) {
        data!.add(OrderHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistoryData {
  int? id;
  int? itemCount;
  String? orderDate;

  OrderHistoryData({this.id, this.itemCount, this.orderDate});

  OrderHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCount = json['itemCount'];
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemCount'] = itemCount;
    data['orderDate'] = orderDate;
    return data;
  }
}
