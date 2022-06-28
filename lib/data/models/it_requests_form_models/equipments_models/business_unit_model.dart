class BusinessUnitModel {
  String? departmentId;
  String? departmentName;
  String? departmentDirector;
  String? shortcut;
  String? isproject;
  int? departmentIndex;

  BusinessUnitModel(
      {this.departmentId,
        this.departmentName,
        this.departmentDirector,
        this.shortcut,
        this.isproject,
        this.departmentIndex});

  BusinessUnitModel.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    departmentDirector = json['department_Director'];
    shortcut = json['shortcut'];
    isproject = json['isproject'];
    departmentIndex = json['department_Index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentId'] = departmentId;
    data['departmentName'] = departmentName;
    data['department_Director'] = departmentDirector;
    data['shortcut'] = shortcut;
    data['isproject'] = isproject;
    data['department_Index'] = departmentIndex;
    return data;
  }
}