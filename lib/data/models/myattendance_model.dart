class MyAttendance_Model{

  String? id;
  String? date;
  bool? holiday;
  int? monthPeriod;
  String? finger_HRCode;
  String? time_IN;
  String? time_OUT;
  String? vacation;
  String? permission;
  String? businessMission;
  String? forget;
  String? deduction;

  MyAttendance_Model(
      this.id,
      this.date,
      this.holiday,
      this.monthPeriod,
      this.finger_HRCode,
      this.time_IN,
      this.time_OUT,
      this.vacation,
      this.permission,
      this.businessMission,
      this.forget,
      this.deduction);

  MyAttendance_Model.fromJson(Map<String, dynamic> json) {

     id=json['id'];
     date=json['date'];
     holiday=json['holiday'];
     monthPeriod=json['monthPeriod'];
     finger_HRCode=json['finger_HRCode'];
     time_IN=json['time_IN'];
     time_OUT=json['time_OUT'];
     vacation=json['vacation'];
     permission=json['permission'];
     businessMission=json['businessMission'];
     forget=json['forget'];
     deduction=json['deduction'];

  }

}