class PayslipResponseModel {
  int? code;
  bool? error;
  String? message;
  String? data;

  PayslipResponseModel({this.code, this.error, this.message, this.data});

  PayslipResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}