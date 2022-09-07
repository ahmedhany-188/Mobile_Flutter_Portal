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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['count'] = this.count;
    data['total'] = this.total;
    data['islabor'] = this.islabor;
    return data;
  }
}