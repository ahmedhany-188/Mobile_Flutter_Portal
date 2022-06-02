class AppsModel {
  int? code;
  bool? error;
  String? message;
  List<AppsData>? data;

  AppsModel({this.code, this.error, this.message, this.data});

  AppsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AppsData>[];
      json['data'].forEach((v) {
        data!.add(AppsData.fromJson(v));
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

class AppsData {
  int? sysID;
  String? sysName;
  String? sysIcon;
  String? angularIcon;
  String? sysLink;
  bool? sysIsWeb;
  bool? sysIsMobile;
  bool? sysIsTopManage;
  String? companyAccess;
  String? responsiblePersonHRCode;

  AppsData(
      {this.sysID,
        this.sysName,
        this.sysIcon,
        this.angularIcon,
        this.sysLink,
        this.sysIsWeb,
        this.sysIsMobile,
        this.sysIsTopManage,
        this.companyAccess,
        this.responsiblePersonHRCode});

  AppsData.fromJson(Map<String, dynamic> json) {
    sysID = json['sys_ID'];
    sysName = json['sys_Name'];
    sysIcon = json['sys_Icon'];
    angularIcon = json['angular_Icon'];
    sysLink = json['sys_Link'];
    sysIsWeb = json['sys_IsWeb'];
    sysIsMobile = json['sys_IsMobile'];
    sysIsTopManage = json['sys_IsTopManage'];
    companyAccess = json['companyAccess'];
    responsiblePersonHRCode = json['responsiblePerson_HRCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{}; /// means Map<String, dynamic>
    data['sys_ID'] = sysID;
    data['sys_Name'] = sysName;
    data['sys_Icon'] = sysIcon;
    data['angular_Icon'] = angularIcon;
    data['sys_Link'] = sysLink;
    data['sys_IsWeb'] = sysIsWeb;
    data['sys_IsMobile'] = sysIsMobile;
    data['sys_IsTopManage'] = sysIsTopManage;
    data['companyAccess'] = companyAccess;
    data['responsiblePerson_HRCode'] = responsiblePersonHRCode;
    return data;
  }
}