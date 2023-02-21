class AppDrawerModel {
  int? id;
  String? sysName;
  String? sysIcon;
  String? sysLink;

  AppDrawerModel({this.id, this.sysName, this.sysIcon, this.sysLink});

  AppDrawerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sysName = json['sys_Name'];
    sysIcon = json['sys_Icon'];
    sysLink = json['sys_Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sys_Name'] = this.sysName;
    data['sys_Icon'] = this.sysIcon;
    data['sys_Link'] = this.sysLink;
    return data;
  }
}