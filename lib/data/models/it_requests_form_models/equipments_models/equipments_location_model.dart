class EquipmentsLocationModel {
  int? projectId;
  String? unit;
  int? proTypId;
  String? projectName;
  String? city;
  String? departmentName;
  String? projectManager;
  String? projectManagerName;
  String? projectDirector;
  String? projectsDirector;
  String? projectAdmin;
  String? hrCoordinator;
  String? hrSectionHead;
  String? hrAssWages;
  int? subGroupId;
  int? groupPolicyId;
  int? areaId;
  String? workDays;
  double? latitude;
  double? longitude;
  int? status;
  String? startAt;
  String? endAt;

  EquipmentsLocationModel(
      {this.projectId,
        this.unit,
        this.proTypId,
        this.projectName,
        this.city,
        this.departmentName,
        this.projectManager,
        this.projectManagerName,
        this.projectDirector,
        this.projectsDirector,
        this.projectAdmin,
        this.hrCoordinator,
        this.hrSectionHead,
        this.hrAssWages,
        this.subGroupId,
        this.groupPolicyId,
        this.areaId,
        this.workDays,
        this.latitude,
        this.longitude,
        this.status,
        this.startAt,
        this.endAt});

  EquipmentsLocationModel.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    unit = json['unit'];
    proTypId = json['proTypId'];
    projectName = json['projectName'];
    city = json['city'];
    departmentName = json['departmentName'];
    projectManager = json['projectManager'];
    projectManagerName = json['projectManagerName'];
    projectDirector = json['projectDirector'];
    projectsDirector = json['projectsDirector'];
    projectAdmin = json['projectAdmin'];
    hrCoordinator = json['hrCoordinator'];
    hrSectionHead = json['hrSectionHead'];
    hrAssWages = json['hrAssWages'];
    subGroupId = json['subGroupId'];
    groupPolicyId = json['groupPolicyId'];
    areaId = json['areaId'];
    workDays = json['workDays'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    startAt = json['startAt'];
    endAt = json['endAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['unit'] = unit;
    data['proTypId'] = proTypId;
    data['projectName'] = projectName;
    data['city'] = city;
    data['departmentName'] = departmentName;
    data['projectManager'] = projectManager;
    data['projectManagerName'] = projectManagerName;
    data['projectDirector'] = projectDirector;
    data['projectsDirector'] = projectsDirector;
    data['projectAdmin'] = projectAdmin;
    data['hrCoordinator'] = hrCoordinator;
    data['hrSectionHead'] = hrSectionHead;
    data['hrAssWages'] = hrAssWages;
    data['subGroupId'] = subGroupId;
    data['groupPolicyId'] = groupPolicyId;
    data['areaId'] = areaId;
    data['workDays'] = workDays;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    return data;
  }
}