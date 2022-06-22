
import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';


import 'package:http/http.dart' as http;

class AttendanceRepository {
  final AttendanceDataProvider attendanceDataProvider = AttendanceDataProvider();

  Future<List<MyAttendanceModel>> getAttendanceData(String hrCode,int monthNumber) async {
    final http.Response rawAttendance = await attendanceDataProvider.getAttendanceList(hrCode,monthNumber);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    print("-------step2");
    // return attendanceData;
    final json = await jsonDecode(rawAttendance.body);
    print("-------step3");
    List<MyAttendanceModel> myAttendanceData = List<MyAttendanceModel>.from(
        json.map((model) => MyAttendanceModel.fromJson(model)));
    print("-------step4");
    return myAttendanceData;
  }

}