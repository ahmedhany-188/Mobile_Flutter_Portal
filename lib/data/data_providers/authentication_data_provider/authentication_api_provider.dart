import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationApiProvider {

  // String userName;
  // String password;
  //
  //
  // AuthenticationApiProvider(this.userName, this.password);

  Future<http.Response> loginApiAuthentication(String userName,String password) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Account/LoginToken?Email=$userName&Password=$password&Remember=true"),
    );
    if (kDebugMode) {
      print(rawAttendanceData.body);
    }
    return rawAttendanceData;
  }


}

