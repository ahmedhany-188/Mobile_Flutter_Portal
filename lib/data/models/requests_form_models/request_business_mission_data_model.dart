class BusinessMissionRequestData {
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
  String? missionLocation;
  String? dateFrom;
  String? dateTo;
  String? hourFrom;
  String? hourTo;
  String? dateFromAmpm;
  String? dateToAmpm;
  String? projectId;

  BusinessMissionRequestData(
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
        this.missionLocation,
        this.dateFrom,
        this.dateTo,
        this.hourFrom,
        this.hourTo,
        this.dateFromAmpm,
        this.dateToAmpm,
        this.projectId});

  BusinessMissionRequestData.fromJson(Map<String, dynamic> json) {
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
    missionLocation = json['missionLocation'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    hourFrom = json['hourFrom'];
    hourTo = json['hourTo'];
    dateFromAmpm = json['dateFromAmpm'];
    dateToAmpm = json['dateToAmpm'];
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
    data['missionLocation'] = this.missionLocation;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['hourFrom'] = this.hourFrom;
    data['hourTo'] = this.hourTo;
    data['dateFromAmpm'] = this.dateFromAmpm;
    data['dateToAmpm'] = this.dateToAmpm;
    data['projectId'] = this.projectId;
    return data;
  }
}