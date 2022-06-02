class SubsidiariesModel {
  int? code;
  bool? error;
  String? message;
  List<SubsidiariesData>? data;

  SubsidiariesModel({this.code, this.error, this.message, this.data});

  SubsidiariesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubsidiariesData>[];
      json['data'].forEach((v) {
        data!.add(SubsidiariesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubsidiariesData {
  int? subID;
  String? subName;
  String? subIcone;
  String? subDesc;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? inDate;
  String? inUser;

  SubsidiariesData(
      {this.subID,
        this.subName,
        this.subIcone,
        this.subDesc,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.inDate,
        this.inUser});

  SubsidiariesData.fromJson(Map<String, dynamic> json) {
    subID = json['subID'];
    subName = json['subName'];
    subIcone = json['subIcone'];
    subDesc = json['subDesc'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    inDate = json['inDate'];
    inUser = json['inUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subID'] = subID;
    data['subName'] = subName;
    data['subIcone'] = subIcone;
    data['subDesc'] = subDesc;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['image4'] = image4;
    data['inDate'] = inDate;
    data['inUser'] = inUser;
    return data;
  }
}