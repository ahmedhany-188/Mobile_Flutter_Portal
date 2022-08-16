import 'package:equatable/equatable.dart';

class EmployeeData extends Equatable {
 //TODO: change null data types
  final String? userHrCode;
  final Null? applications;
  final int? fingerPrintGroup;
  final String? departmentId;
  final String? locationId;
  final int? mainDepartmentID;
  final String? mainDepartment;
  final String? mainFunction;
  final String? projectName;
  final String? titleName;
  final String? gradeName;
  final String? companyName;
  final String? name;
  final String? arabicName;
  final String? stName;
  final String? middleName;
  final String? lastName;
  final String? managerCode;
  final String? managerEmail;
  final String? managerName;
  final String? titleId;
  final String? email;
  final String? deskPhone;
  final String? phone;
  final String? mobile;
  final String? mobile1;
  final String? hireDate;
  final Null? projectId;
  final String? status;
  final String? linkedIn;
  final String? skype;
  final String? imgProfile;
  final String? birthdate;
  final String? cv;
  final String? nationalId;
  final String? address;
  final String? country;
  final String? city;
  final String? area;
  final String? street;
  final bool? isActive;
  final int? interviewId;
  final String? inDate;
  final String? inUser;
  final bool? isTopManagement;
  final bool? isCEO;
  final bool? isLessonLearned;

  const EmployeeData(
      {this.userHrCode,
        this.applications,
        this.fingerPrintGroup,
        this.departmentId,
        this.locationId,
        this.mainDepartmentID,
        this.mainDepartment,
        this.mainFunction,
        this.projectName,
        this.titleName,
        this.gradeName,
        this.companyName,
        this.name,
        this.arabicName,
        this.stName,
        this.middleName,
        this.lastName,
        this.managerCode,
        this.managerEmail,
        this.managerName,
        this.titleId,
        this.email,
        this.deskPhone,
        this.phone,
        this.mobile,
        this.mobile1,
        this.hireDate,
        this.projectId,
        this.status,
        this.linkedIn,
        this.skype,
        this.imgProfile,
        this.birthdate,
        this.cv,
        this.nationalId,
        this.address,
        this.country,
        this.city,
        this.area,
        this.street,
        this.isActive,
        this.interviewId,
        this.inDate,
        this.inUser,
        this.isTopManagement,
        this.isCEO,
        this.isLessonLearned});

  EmployeeData.fromJson(Map<String, dynamic> json):
    userHrCode = json['userHrCode'],
    applications = json['applications'],
    fingerPrintGroup = json['fingerPrintGroup'],
    departmentId = json['departmentId'],
    locationId = json['locationId'],
    mainDepartmentID = json['mainDepartmentID'],
    mainDepartment = json['mainDepartment'],
    mainFunction = json['mainFunction'],
    projectName = json['projectName'],
    titleName = json['titleName'],
    gradeName = json['grade_Name'],
    companyName = json['companyName'],
    name = json['name'],
    arabicName = json['arabicName'],
    stName = json['stName'],
    middleName = json['middleName'],
    lastName = json['lastName'],
    managerCode = json['managerCode'],
        managerEmail = json['managerEmail'],
        managerName = json['managerName'],
    titleId = json['titleId'],
    email = json['email'],
    deskPhone = json['deskPhone'],
    phone = json['phone'],
    mobile = json['mobile'],
    mobile1 = json['mobile1'],
    hireDate = json['hireDate'],
    projectId = json['projectId'],
    status = json['status'],
    linkedIn = json['linkedIn'],
    skype = json['skype'],
    imgProfile = json['imgProfile'],
    birthdate = json['birthdate'],
    cv = json['cv'],
    nationalId = json['nationalId'],
    address = json['address'],
    country = json['country'],
    city = json['city'],
    area = json['area'],
    street = json['street'],
    isActive = json['isActive'],
    interviewId = json['interviewId'],
    inDate = json['inDate'],
    inUser = json['inUser'],
    isTopManagement = json['isTopManagement'],
    isCEO = json['isCEO'],
    isLessonLearned = json['isLessonLearned'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userHrCode'] = this.userHrCode;
    data['applications'] = this.applications;
    data['fingerPrintGroup'] = this.fingerPrintGroup;
    data['departmentId'] = this.departmentId;
    data['locationId'] = this.locationId;
    data['mainDepartmentID'] = this.mainDepartmentID;
    data['mainDepartment'] = this.mainDepartment;
    data['mainFunction'] = this.mainFunction;
    data['projectName'] = this.projectName;
    data['titleName'] = this.titleName;
    data['grade_Name'] = this.gradeName;
    data['companyName'] = this.companyName;
    data['name'] = this.name;
    data['arabicName'] = this.arabicName;
    data['stName'] = this.stName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['managerCode'] = this.managerCode;
    data['managerEmail'] = this.managerEmail;
    data['managerName'] = this.managerName;
    data['titleId'] = this.titleId;
    data['email'] = this.email;
    data['deskPhone'] = this.deskPhone;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['mobile1'] = this.mobile1;
    data['hireDate'] = this.hireDate;
    data['projectId'] = this.projectId;
    data['status'] = this.status;
    data['linkedIn'] = this.linkedIn;
    data['skype'] = this.skype;
    data['imgProfile'] = this.imgProfile;
    data['birthdate'] = this.birthdate;
    data['cv'] = this.cv;
    data['nationalId'] = this.nationalId;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['area'] = this.area;
    data['street'] = this.street;
    data['isActive'] = this.isActive;
    data['interviewId'] = this.interviewId;
    data['inDate'] = this.inDate;
    data['inUser'] = this.inUser;
    data['isTopManagement'] = this.isTopManagement;
    data['isCEO'] = this.isCEO;
    data['isLessonLearned'] = this.isLessonLearned;
    return data;
  }
  /// Empty user which represents an unauthenticated user.
  static const EmployeeData empty =
  // EmployeeData(email: "");
  // EmployeeData.empty1();
   const EmployeeData(email: "",address: "",applications: null,arabicName: "",area: "",birthdate: null,city: "",companyName: "",
      country: "",cv: null,departmentId: "",deskPhone: "",fingerPrintGroup: 0,gradeName: "",hireDate: "",imgProfile: "",
      inDate: "",interviewId: null,inUser: "",isActive: false,isCEO: false,isLessonLearned: false,isTopManagement: false,lastName: "",
      linkedIn: "",locationId: "",mainDepartment: "",mainDepartmentID: 0,mainFunction: "",managerCode: "",managerEmail:"",managerName:"",
      middleName: "",mobile1: "",mobile: "",name: "",nationalId: "",phone: "",projectId: null,projectName: "",skype: null,status: null,stName: "",
      street: "",titleId: "",titleName: "",userHrCode: "");

  @override
  // TODO: implement props
  List<Object?> get props => [email, userHrCode];

  // EmployeeData.empty1();

  /// Convenience getter to determine whether the current user is empty.
  // bool get isEmpty => this == EmployeeData.empty;
}