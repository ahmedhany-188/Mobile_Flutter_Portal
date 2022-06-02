class GetDirectionModel {
  String? projectName;
  String? city;
  double? latitude;
  double? longitude;

  GetDirectionModel({
    this.projectName,
    this.city,
    this.latitude,
    this.longitude,
  });

  GetDirectionModel.fromJson(Map<String, dynamic> json) {
    projectName = json['projectName'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['projectName'] = projectName;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
