import 'package:equatable/equatable.dart';

import '../../../constants/constants.dart';

class MyRequestsModelData extends Equatable {
  int? id;
  int? requestNo;
  String? serviceID;
  String? serviceName;
  String? titleName;
  String? imgProfile;
  int? reqStatus;
  String? reqDate;
  String? fullReq;
  String? requestHRCode;
  String? statusName;
  String? reqName;
  String? responsbleperson;
  String? rDate;

  MyRequestsModelData(
      {this.id,
        this.requestNo,
        this.serviceID,
        this.serviceName,
        this.titleName,
        this.imgProfile,
        this.reqStatus,
        this.reqDate,
        this.fullReq,
        this.requestHRCode,
        this.statusName,
        this.reqName,
        this.responsbleperson,
        this.rDate});

  MyRequestsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestNo = json['request_No'];
    serviceID = json['service_ID'];
    serviceName = json['service_Name'];
    titleName = json['title_Name'];
    imgProfile = json['imgProfile'];
    reqStatus = json['req_Status'];
    reqDate = json['req_Date'];
    fullReq = json['full_Req'];
    requestHRCode = json['request_HR_Code'];
    statusName = json['status_Name'];
    reqName = json['req_Name'];
    responsbleperson = json['responsbleperson'];
    rDate = json['rDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_No'] = this.requestNo;
    data['service_ID'] = this.serviceID;
    data['service_Name'] = this.serviceName;
    data['title_Name'] = this.titleName;
    data['imgProfile'] = this.imgProfile;
    data['req_Status'] = this.reqStatus;
    data['req_Date'] = this.reqDate;
    data['full_Req'] = this.fullReq;
    data['request_HR_Code'] = this.requestHRCode;
    data['status_Name'] = this.statusName;
    data['req_Name'] = this.reqName;
    data['responsbleperson'] = this.responsbleperson;
    data['rDate'] = this.rDate;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,requestNo,reqDate,serviceName];

}