import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider{

  // old - get method
  // Future<http.Response> loginApiAuthentication(String userName,String password) async {
  //   var encodedPassword = Uri.encodeComponent(password);
  //   http.Response rawAttendanceData = await http.get(
  //     Uri.parse(
  //         "https://api.hassanallam.com/api/Account/LoginToken?Email=$userName&Password=$encodedPassword&Remember=true"),
  //   ).timeout(Duration(seconds: 20));
  //   if (kDebugMode) {
  //     print(rawAttendanceData.body);
  //   }
  //   return rawAttendanceData;
  // }

  // new - post method
  Future<http.Response> loginApiAuthentication(String userName,String password) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    // var encodedPassword = Uri.encodeComponent(password);
    String bodyString=jsonEncode(<String, dynamic>{
        "email": userName,
        "password": password,
        "remember": true
    });
    http.Response rawAttendanceData = await http.post(
      Uri.parse("https://api.hassanallam.com/api/Account/LoginToken"),
      headers: header,
      body:bodyString,
    ).timeout(const Duration(seconds: 20));
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