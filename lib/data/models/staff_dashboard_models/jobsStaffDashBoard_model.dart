class JobStaffDashboardModel {
  int? id;
  String? status;
  int? count;
  int? total;
  bool? islabor;

  JobStaffDashboardModel(
      {this.id, this.status, this.count, this.total, this.islabor});

  JobStaffDashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    count = json['count'];
    total = json['total'];
    islabor = json['islabor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['count'] = count;
    data['total'] = total;
    data['islabor'] = islabor;
    return data;
  }
}