class ContactsDataFromApi {
  String? userHrCode;
  String? name;
  String? email;
  String? projectName;
  String? mainDepartment;
  String? mainFunction;
  String? titleName;
  String? companyName;
  String? imgProfile;

  ContactsDataFromApi({
    this.userHrCode,
    this.name,
    this.email,
    this.projectName,
    this.mainDepartment,
    this.mainFunction,
    this.titleName,
    this.companyName,
    this.imgProfile,
  });

  ContactsDataFromApi.fromJson(Map<String, dynamic> json) {
    userHrCode = json['userHrCode'];
    name = json['name'];
    email = json['email'];
    projectName = json['projectName'];
    mainDepartment = json['mainDepartment'];
    mainFunction = json['mainFunction'];
    titleName = json['titleName'];
    companyName = json['companyName'];
    imgProfile = json['imgProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userHrCode'] = userHrCode;
    data['name'] = name;
    data['email'] = email;
    data['projectName'] = projectName;
    data['mainDepartment'] = mainDepartment;
    data['mainFunction'] = mainFunction;
    data['titleName'] = titleName;
    data['companyName'] = companyName;
    data['imgProfile'] = imgProfile;
    return data;
  }
}
