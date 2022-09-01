class CompanyStaffDashBoard {
  int? id;
  String? departmentName;
  String? departmentImage;
  double? staffCount;
  double? staffAttend;
  double? laborCount;
  double? laborAttend;
  double? subContractor;

  CompanyStaffDashBoard(
      {this.id,
        this.departmentName,
        this.departmentImage,
        this.staffCount,
        this.staffAttend,
        this.laborCount,
        this.laborAttend,
        this.subContractor});

  CompanyStaffDashBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['department_Name'];
    departmentImage = json['department_Image'];
    staffCount = json['staff_Count'];
    staffAttend = json['staff_Attend'];
    laborCount = json['labor_Count'];
    laborAttend = json['labor_Attend'];
    subContractor = json['subContractor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_Name'] = this.departmentName;
    data['department_Image'] = this.departmentImage;
    data['staff_Count'] = this.staffCount;
    data['staff_Attend'] = this.staffAttend;
    data['labor_Count'] = this.laborCount;
    data['labor_Attend'] = this.laborAttend;
    data['subContractor'] = this.subContractor;
    return data;
  }
}