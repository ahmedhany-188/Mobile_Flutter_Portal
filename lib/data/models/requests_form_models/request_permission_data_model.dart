class PermissionRequestData {
  int? requestNo;
  String? serviceId;
  String? requestHrCode;
  String? ownerHrCode;
  String? date;
  bool? newComer;
  String? approvalPathId;
  int? status;
  String? comments;
  String? nplusEmail;
  String? closedDate;
  int? type;
  String? dateFrom;
  String? dateTo;
  String? dateFromAmpm;
  String? dateToAmpm;
  String? permissionDate;
  String? projectId;

  PermissionRequestData(
      {this.requestNo,
        this.serviceId,
        this.requestHrCode,
        this.ownerHrCode,
        this.date,
        this.newComer,
        this.approvalPathId,
        this.status,
        this.comments,
        this.nplusEmail,
        this.closedDate,
        this.type,
        this.dateFrom,
        this.dateTo,
        this.dateFromAmpm,
        this.dateToAmpm,
        this.permissionDate,
        this.projectId});

  PermissionRequestData.fromJson(Map<String, dynamic> json) {
    requestNo = json['requestNo'];
    serviceId = json['serviceId'];
    requestHrCode = json['requestHrCode'];
    ownerHrCode = json['ownerHrCode'];
    date = json['date'];
    newComer = json['newComer'];
    approvalPathId = json['approvalPathId'];
    status = json['status'];
    comments = json['comments'];
    nplusEmail = json['nplusEmail'];
    closedDate = json['closedDate'];
    type = json['type'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    dateFromAmpm = json['dateFromAmpm'];
    dateToAmpm = json['dateToAmpm'];
    permissionDate = json['permissionDate'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestNo'] = this.requestNo;
    data['serviceId'] = this.serviceId;
    data['requestHrCode'] = this.requestHrCode;
    data['ownerHrCode'] = this.ownerHrCode;
    data['date'] = this.date;
    data['newComer'] = this.newComer;
    data['approvalPathId'] = this.approvalPathId;
    data['status'] = this.status;
    data['comments'] = this.comments;
    data['nplusEmail'] = this.nplusEmail;
    data['closedDate'] = this.closedDate;
    data['type'] = this.type;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['dateFromAmpm'] = this.dateFromAmpm;
    data['dateToAmpm'] = this.dateToAmpm;
    data['permissionDate'] = this.permissionDate;
    data['projectId'] = this.projectId;
    return data;
  }
}