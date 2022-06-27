class DepartmentsModel {
  int? id;
  String? departmentName;
  bool? isSupportive;
  String? inUser;
  String? inDate;

  DepartmentsModel(
      {this.id,
        this.departmentName,
        this.isSupportive,
        this.inUser,
        this.inDate});

  DepartmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['department_Name'];
    isSupportive = json['isSupportive'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['department_Name'] = departmentName;
    data['isSupportive'] = isSupportive;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    return data;
  }
}
