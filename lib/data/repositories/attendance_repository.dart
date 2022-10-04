
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';


import 'package:http/http.dart' as http;

class AttendanceRepository {
  final AttendanceDataProvider attendanceDataProvider = AttendanceDataProvider();
  MainUserData? userData;

  static final AttendanceRepository _inst = AttendanceRepository._internal();

  AttendanceRepository._internal();

  factory AttendanceRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  Future<List<MyAttendanceModel>> getAttendanceData(String hrCode,int monthNumber) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };

    final http.Response rawAttendance = await attendanceDataProvider.getAttendanceList(header,hrCode,monthNumber);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    final json = await jsonDecode(rawAttendance.body);
    List<MyAttendanceModel> myAttendanceData = List<MyAttendanceModel>.from(
        json.map((model) => MyAttendanceModel.fromJson(model)));
    return myAttendanceData;
  }
}