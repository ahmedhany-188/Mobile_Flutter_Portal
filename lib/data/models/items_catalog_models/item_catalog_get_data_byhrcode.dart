class ItemCatalogUserInfo {
  int? code;
  String? message;
  bool? error;
  List<Data>? data;

  ItemCatalogUserInfo({this.code, this.message, this.error, this.data});

  ItemCatalogUserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? hrCode;
  int? groupID;
  Group? group;
  bool? isSuperAdmin;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  Data(
      {this.id,
        this.hrCode,
        this.groupID,
        this.group,
        this.isSuperAdmin,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hrCode = json['hrCode'];
    groupID = json['group_ID'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    isSuperAdmin = json['isSuperAdmin'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hrCode'] = this.hrCode;
    data['group_ID'] = this.groupID;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    data['isSuperAdmin'] = this.isSuperAdmin;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    return data;
  }
}

class Group {
  int? id;
  String? groupName;
  String? inUser;
  String? inDate;
  String? upUser;
  String? upDate;

  Group(
      {this.id,
        this.groupName,
        this.inUser,
        this.inDate,
        this.upUser,
        this.upDate});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_Name'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_Name'] = this.groupName;
    data['in_User'] = this.inUser;
    data['in_Date'] = this.inDate;
    data['up_User'] = this.upUser;
    data['up_Date'] = this.upDate;
    return data;
  }
}