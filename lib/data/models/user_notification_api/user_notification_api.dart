class UserNotificationApi {
  int? id;
  int? requestNo;
  String? userID;
  String? name;
  String? serviceID;
  String? serviceName;
  String? createDate;
  int? detailApprovalID;
  String? status;
  String? fullReqNo;
  String? requestHRCode;
  String? reqDate;
  int? reqStatus;
  String? reqComment;
  String? reqName;
  String? projectName;
  String? imgProfile;

  UserNotificationApi(
      {this.id,
        this.requestNo,
        this.userID,
        this.name,
        this.serviceID,
        this.serviceName,
        this.createDate,
        this.detailApprovalID,
        this.status,
        this.fullReqNo,
        this.requestHRCode,
        this.reqDate,
        this.reqStatus,
        this.reqComment,
        this.reqName,
        this.projectName,
        this.imgProfile});

  UserNotificationApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestNo = json['request_No'];
    userID = json['user_ID'];
    name = json['name'];
    serviceID = json['service_ID'];
    serviceName = json['service_Name'];
    createDate = json['createDate'];
    detailApprovalID = json['detail_Approval_ID'];
    status = json['status'];
    fullReqNo = json['fullReq_No'];
    requestHRCode = json['request_HR_Code'];
    reqDate = json['req_Date'];
    reqStatus = json['req_Status'];
    reqComment = json['req_comment'];
    reqName = json['req_Name'];
    projectName = json['projectName'];
    imgProfile = json['imgProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_No'] = this.requestNo;
    data['user_ID'] = this.userID;
    data['name'] = this.name;
    data['service_ID'] = this.serviceID;
    data['service_Name'] = this.serviceName;
    data['createDate'] = this.createDate;
    data['detail_Approval_ID'] = this.detailApprovalID;
    data['status'] = this.status;
    data['fullReq_No'] = this.fullReqNo;
    data['request_HR_Code'] = this.requestHRCode;
    data['req_Date'] = this.reqDate;
    data['req_Status'] = this.reqStatus;
    data['req_comment'] = this.reqComment;
    data['req_Name'] = this.reqName;
    data['projectName'] = this.projectName;
    data['imgProfile'] = this.imgProfile;
    return data;
  }
}