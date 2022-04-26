import 'package:http/http.dart' as http;

class AuthenticationProvider{

  Future<http.Response> loginApiAuthentication(String userName,String password) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "http://api.hassanallam.com:3415/api/Account/LoginToken?Email=$userName&Password=$password&Remember=true"),
    );
    print(rawAttendanceData.body);
    return rawAttendanceData;
  }
}