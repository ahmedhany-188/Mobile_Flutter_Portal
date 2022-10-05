import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider{

  Future<http.Response> loginApiAuthentication(String userName,String password) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Account/LoginToken?Email=$userName&Password=$password&Remember=true"),
    )
        // .timeout(Duration(seconds: 20))
    ;
    if (kDebugMode) {
      print(rawAttendanceData.body);
    }
    return rawAttendanceData;
  }

  Future<http.Response> getEmployeeData(String hrCode,String token) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
      headers: header
    );

    if (kDebugMode) {
      print(rawAttendanceData.body);
    }
    return rawAttendanceData;
  }
}