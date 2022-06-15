class VacationRequestData {
  int? requestNo;
  String? serviceId;
  String? requestHrCode;
  String? ownerHrCode;
  String? responsible;
  String? date;
  bool? newComer;
  String? approvalPathId;
  int? status;
  String? comments;
  String? nplusEmail;
  String? closedDate;
  String? vacationType;
  String? dateFrom;
  String? dateTo;
  int? noOfDays;
  String? replacedWith;
  String? replacedWithTo;
  String? fileName;
  String? projectId;

  VacationRequestData(
      {this.requestNo,
        this.serviceId,
        this.requestHrCode,
        this.ownerHrCode,
        this.responsible,
        this.date,
        this.newComer,
        this.approvalPathId,
        this.status,
        this.comments,
        this.nplusEmail,
        this.closedDate,
        this.vacationType,
        this.dateFrom,
        this.dateTo,
        this.noOfDays,
        this.replacedWith,
        this.replacedWithTo,
        this.fileName,
        this.projectId});

  VacationRequestData.fromJson(Map<String, dynamic> json) {
    requestNo = json['requestNo'];
    serviceId = json['serviceId'];
    requestHrCode = json['requestHrCode'];
    ownerHrCode = json['ownerHrCode'];
    responsible = json['responsible'];
    date = json['date'];
    newComer = json['newComer'];
    approvalPathId = json['approvalPathId'];
    status = json['status'];
    comments = json['comments'];
    nplusEmail = json['nplusEmail'];
    closedDate = json['closedDate'];
    vacationType = json['vacationType'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    noOfDays = json['noOfDays'];
    replacedWith = json['replacedWith'];
    replacedWithTo = json['replacedWithTo'];
    fileName = json['fileName'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestNo'] = this.requestNo;
    data['serviceId'] = this.serviceId;
    data['requestHrCode'] = this.requestHrCode;
    data['ownerHrCode'] = this.ownerHrCode;
    data['responsible'] = this.responsible;
    data['date'] = this.date;
    data['newComer'] = this.newComer;
    data['approvalPathId'] = this.approvalPathId;
    data['status'] = this.status;
    data['comments'] = this.comments;
    data['nplusEmail'] = this.nplusEmail;
    data['closedDate'] = this.closedDate;
    data['vacationType'] = this.vacationType;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['noOfDays'] = this.noOfDays;
    data['replacedWith'] = this.replacedWith;
    data['replacedWithTo'] = this.replacedWithTo;
    data['fileName'] = this.fileName;
    data['projectId'] = this.projectId;
    return data;
  }
}