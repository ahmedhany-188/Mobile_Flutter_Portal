class NextStepModel {
  String? userHRCode;
  String? name;
  String? titleID;

  NextStepModel({this.userHRCode, this.name, this.titleID});

  NextStepModel.fromJson(Map<String, dynamic> json) {
    userHRCode = json['user_HR_Code'];
    name = json['name'];
    titleID = json['title_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_HR_Code'] = this.userHRCode;
    data['name'] = this.name;
    data['title_ID'] = this.titleID;
    return data;
  }
}