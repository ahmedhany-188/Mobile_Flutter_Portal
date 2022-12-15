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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['error'] = error;
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
    group = json['group'] != null ?  Group.fromJson(json['group']) : null;
    isSuperAdmin = json['isSuperAdmin'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
    upUser = json['up_User'];
    upDate = json['up_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['hrCode'] = hrCode;
    data['group_ID'] = groupID;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    data['isSuperAdmin'] = isSuperAdmin;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
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
    data['id'] = id;
    data['group_Name'] = groupName;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    data['up_User'] = upUser;
    data['up_Date'] = upDate;
    return data;
  }
}