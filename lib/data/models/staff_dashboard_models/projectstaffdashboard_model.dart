class ProjectStaffDashboardModel {
  int? id;
  String? projectName;
  String? projectsDirector;
  String? name;
  String? shortcut;
  int? cEmployees;
  int? employees;
  int? percEmp;
  int? cLabors;
  int? labors;
  int? percLabor;
  int? totalSignin;
  int? totalPerc;
  int? subContractor;

  ProjectStaffDashboardModel(
      {this.id,
        this.projectName,
        this.projectsDirector,
        this.name,
        this.shortcut,
        this.cEmployees,
        this.employees,
        this.percEmp,
        this.cLabors,
        this.labors,
        this.percLabor,
        this.totalSignin,
        this.totalPerc,
        this.subContractor});

  ProjectStaffDashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['projectName'];
    projectsDirector = json['projects_Director'];
    name = json['name'];
    shortcut = json['shortcut'];
    cEmployees = json['cEmployees'];
    employees = json['employees'];
    percEmp = json['percEmp'];
    cLabors = json['cLabors'];
    labors = json['labors'];
    percLabor = json['percLabor'];
    totalSignin = json['totalSignin'];
    totalPerc = json['totalPerc'];
    subContractor = json['subContractor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectName'] = this.projectName;
    data['projects_Director'] = this.projectsDirector;
    data['name'] = this.name;
    data['shortcut'] = this.shortcut;
    data['cEmployees'] = this.cEmployees;
    data['employees'] = this.employees;
    data['percEmp'] = this.percEmp;
    data['cLabors'] = this.cLabors;
    data['labors'] = this.labors;
    data['percLabor'] = this.percLabor;
    data['totalSignin'] = this.totalSignin;
    data['totalPerc'] = this.totalPerc;
    data['subContractor'] = this.subContractor;
    return data;
  }
}