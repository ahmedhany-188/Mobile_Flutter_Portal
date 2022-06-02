import 'package:http/http.dart' as http;

class AuthenticationProvider{

  Future<http.Response> loginApiAuthentication(String userName,String password) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Account/LoginToken?Email=$userName&Password=$password&Remember=true"),
    )
        // .timeout(Duration(seconds: 20))
    ;
    print(rawAttendanceData.body);
    return rawAttendanceData;
  }

  Future<http.Response> getEmployeeData(String hrCode) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
    );

    print(rawAttendanceData.body);
    return rawAttendanceData;
  }
}