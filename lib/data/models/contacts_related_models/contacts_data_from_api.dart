import 'package:equatable/equatable.dart';

class ContactsDataFromApi extends Equatable{
  final String? userHrCode;
  final String? name;
  final String? email;
  final String? projectName;
  final String? mainDepartment;
  final String? mainFunction;
  final String? titleName;
  final String? companyName;
  final String? imgProfile;
  final String? extenstion;
  final String? phoneNumber;
  final String? managerCode;

  const ContactsDataFromApi({
    this.userHrCode,
    this.name,
    this.email,
    this.projectName,
    this.mainDepartment,
    this.mainFunction,
    this.titleName,
    this.companyName,
    this.imgProfile,
    this.extenstion,
    this.phoneNumber,
    this.managerCode,
  });


  ContactsDataFromApi.fromJson(Map<String, dynamic> json): userHrCode = json['userHrCode'],
  name = json['name'],
  email = json['email'],
  projectName = json['projectName'],
  mainDepartment = json['mainDepartment'],
  mainFunction = json['mainFunction'],
  titleName = json['titleName'],
  companyName = json['companyName'],
  imgProfile = json['imgProfile'],
  extenstion = json['extenstion'],
  phoneNumber = json['phoneNumber'],
  managerCode = json['managerCode'];
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
    data['extenstion']=extenstion;
    data['phoneNumber']=phoneNumber;
    data['managerCode']=managerCode;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userHrCode, email];

  static const ContactsDataFromApi empty = ContactsDataFromApi(name: "",userHrCode: "",email: "");
}
