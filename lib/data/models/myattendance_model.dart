class MyAttendanceModel{

  int? id;
  String? date;
  bool? holiday;
  int? monthPeriod;
  String? fingerHRCode;
  String? timeIN;
  String? timeOUT;
  int? vacation;
  int? permission;
  int? businessMission;
  int? forget;
  String? deduction;

  MyAttendanceModel(
      {this.id,
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
        this.deduction});

  MyAttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    holiday = json['holiday'];
    monthPeriod = json['monthPeriod'];
    fingerHRCode = json['finger_HRCode'];
    timeIN = json['time_IN'];
    timeOUT = json['time_OUT'];
    vacation = json['vacation'];
    permission = json['permission'];
    businessMission = json['businessMission'];
    forget = json['forget'];
    deduction = json['deduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['holiday'] = this.holiday;
    data['monthPeriod'] = this.monthPeriod;
    data['finger_HRCode'] = this.fingerHRCode;
    data['time_IN'] = this.timeIN;
    data['time_OUT'] = this.timeOUT;
    data['vacation'] = this.vacation;
    data['permission'] = this.permission;
    data['businessMission'] = this.businessMission;
    data['forget'] = this.forget;
    data['deduction'] = this.deduction;
    return data;
  }
}