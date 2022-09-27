class EquipmentsRequestedModel {
  int? code;
  bool? error;
  String? message;
  List<EquipmentsRequestedModelData>? data;

  EquipmentsRequestedModel({this.code, this.error, this.message, this.data});

  EquipmentsRequestedModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EquipmentsRequestedModelData>[];
      json['data'].forEach((v) {
        data!.add(EquipmentsRequestedModelData.fromJson(v));
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

class EquipmentsRequestedModelData {
  String? requestHRCode;
  String? name;
  String? departmentName;
  String? projectName;
  String? comments;
  int? type;
  int? status;
  String? groupName;
  String? hardWareItemName;
  String? estimatePrice;
  String? ownerHRCode;
  String? ownerName;
  int? qty;
  double? max;
  String? approved;
  String? mainDepartmentName;
  String? equipmentFile;
  String? date;
  String? closedDate;
  String? mainDepartment;
  String? requestNo;

  EquipmentsRequestedModelData(
      {this.requestHRCode,
      this.name,
      this.departmentName,
      this.projectName,
      this.comments,
      this.type,
      this.status,
      this.groupName,
      this.hardWareItemName,
      this.estimatePrice,
      this.ownerHRCode,
      this.ownerName,
      this.qty,
      this.max,
      this.approved,
      this.mainDepartmentName,
      this.equipmentFile,
      this.date,
      this.closedDate,
      this.mainDepartment,
      this.requestNo});

  EquipmentsRequestedModelData.fromJson(Map<String, dynamic> json) {
    requestHRCode = json['request_HR_Code'];
    name = json['name'];
    departmentName = json['department_Name'];
    projectName = json['projectName'];
    comments = json['comments'];
    type = json['type'];
    status = json['status'];
    groupName = json['group_Name'];
    hardWareItemName = json['hardWareItem_Name'];
    estimatePrice = json['estimatePrice'];
    ownerHRCode = json['owner_HR_Code'];
    ownerName = json['owner_Name'];
    qty = json['qty'];
    max = json['max'];
    approved = json['approved'];
    mainDepartmentName = json['mainDepartmentName'];
    equipmentFile = json['equipment_File'];
    date = json['date'];
    closedDate = json['closedDate'];
    mainDepartment = json['mainDepartment'];
    requestNo = json['requestNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_HR_Code'] = requestHRCode;
    data['name'] = name;
    data['department_Name'] = departmentName;
    data['projectName'] = projectName;
    data['comments'] = comments;
    data['type'] = type;
    data['status'] = status;
    data['group_Name'] = groupName;
    data['hardWareItem_Name'] = hardWareItemName;
    data['estimatePrice'] = estimatePrice;
    data['owner_HR_Code'] = ownerHRCode;
    data['owner_Name'] = ownerName;
    data['qty'] = qty;
    data['max'] = max;
    data['approved'] = approved;
    data['mainDepartmentName'] = mainDepartmentName;
    data['equipment_File'] = equipmentFile;
    data['date'] = date;
    data['closedDate'] = closedDate;
    data['mainDepartment'] = mainDepartment;
    data['requestNo'] = requestNo;
    return data;
  }
}
