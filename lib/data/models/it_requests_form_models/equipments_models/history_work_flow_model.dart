class HistoryWorkFlowModel {
  String? empFromHRCode;
  String? empFrom;
  String? createdate;
  String? comments;
  int? status;
  String? emptoHRCode;
  String? empto;
  String? submitDate;
  String? imgProfile;
  String? imgProfileto;
  String? titleName;
  String? titleNameto;

  HistoryWorkFlowModel(
      {this.empFromHRCode,
        this.empFrom,
        this.createdate,
        this.comments,
        this.status,
        this.emptoHRCode,
        this.empto,
        this.submitDate,
        this.imgProfile,
        this.imgProfileto,
        this.titleName,
        this.titleNameto});

  HistoryWorkFlowModel.fromJson(Map<String, dynamic> json) {
    empFromHRCode = json['empFromHRCode'];
    empFrom = json['empFrom'];
    createdate = json['createdate'];
    comments = json['comments'];
    status = json['status'];
    emptoHRCode = json['emptoHRCode'];
    empto = json['empto'];
    submitDate = json['submitDate'];
    imgProfile = json['imgProfile'];
    imgProfileto = json['imgProfileto'];
    titleName = json['titleName'];
    titleNameto = json['titleNameto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['empFromHRCode'] = empFromHRCode;
    data['empFrom'] = empFrom;
    data['createdate'] = createdate;
    data['comments'] = comments;
    data['status'] = status;
    data['emptoHRCode'] = emptoHRCode;
    data['empto'] = empto;
    data['submitDate'] = submitDate;
    data['imgProfile'] = imgProfile;
    data['imgProfileto'] = imgProfileto;
    data['titleName'] = titleName;
    data['titleNameto'] = titleNameto;
    return data;
  }
}