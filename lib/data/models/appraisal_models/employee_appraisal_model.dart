

class EmployeeAppraisalModel {
  int? code;
  bool? error;
  String? message;
  List<DataEmployeeAppraisalModel>? data;

  EmployeeAppraisalModel({this.code, this.error, this.message, this.data});

  EmployeeAppraisalModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataEmployeeAppraisalModel>[];
      json['data'].forEach((v) {
        data!.add(new DataEmployeeAppraisalModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataEmployeeAppraisalModel{


  int? id;
  int? appID;
  String? hrCode;
  int? status;
  double? companyScore;
  double? departmentScore;
  double? competencescore;
  double? individualScore;
  double? overallscore;
  String? trainingneeds;
  bool? acknowledge1;
  bool? acknowledge2;
  String? inUser;
  String? inDate;

  DataEmployeeAppraisalModel(
      {this.id,
        this.appID,
        this.hrCode,
        this.status,
        this.companyScore,
        this.departmentScore,
        this.competencescore,
        this.individualScore,
        this.overallscore,
        this.trainingneeds,
        this.acknowledge1,
        this.acknowledge2,
        this.inUser,
        this.inDate});

  DataEmployeeAppraisalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appID = json['appID'];
    hrCode = json['hrCode'];
    status = json['status'];
    companyScore = json['companyScore'];
    departmentScore = json['departmentScore'];
    competencescore = json['competencescore'];
    individualScore = json['individualScore'];
    overallscore = json['overallscore'];
    trainingneeds = json['trainingneeds'];
    acknowledge1 = json['acknowledge1'];
    acknowledge2 = json['acknowledge2'];
    inUser = json['inUser'];
    inDate = json['inDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appID'] = this.appID;
    data['hrCode'] = this.hrCode;
    data['status'] = this.status;
    data['companyScore'] = this.companyScore;
    data['departmentScore'] = this.departmentScore;
    data['competencescore'] = this.competencescore;
    data['individualScore'] = this.individualScore;
    data['overallscore'] = this.overallscore;
    data['trainingneeds'] = this.trainingneeds;
    data['acknowledge1'] = this.acknowledge1;
    data['acknowledge2'] = this.acknowledge2;
    data['inUser'] = this.inUser;
    data['inDate'] = this.inDate;
    return data;
  }
}