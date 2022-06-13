class MyAttendanceModel{

  String? id;
  String? date;
  bool? holiday;
  int? monthPeriod;
  String? fingerHRCode;
  String? timeIN;
  String? timeOUT;
  String? vacation;
  String? permission;
  String? businessMission;
  String? forget;
  String? deduction;

  MyAttendanceModel(
      this.id,
      this.date,
      this.holiday,
      this.monthPeriod,
      this.fingerHRCode,
      this.timeIN,
      this.timeOUT,
      this.vacation,
      this.permission,
      this.businessMission,
      this.forget,
      this.deduction);

  MyAttendanceModel.fromJson(Map<String, dynamic> json) {

     id=json['id'];
     date=json['date'];
     holiday=json['holiday'];
     monthPeriod=json['monthPeriod'];
     fingerHRCode=json['finger_HRCode'];
     timeIN=json['time_IN'];
     timeOUT=json['time_OUT'];
     vacation=json['vacation'];
     permission=json['permission'];
     businessMission=json['businessMission'];
     forget=json['forget'];
     deduction=json['deduction'];

  }

}