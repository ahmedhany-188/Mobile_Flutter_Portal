class ProjectDirectionDetails {
  String? projectName;
  String? city;
  double? latitude;
  double? longitude;

  ProjectDirectionDetails({
    this.projectName,
    this.city,
    this.latitude,
    this.longitude,
  });

  ProjectDirectionDetails.fromJson(Map<String, dynamic> json) {
    projectName = json['projectName'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['projectName'] = this.projectName;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
