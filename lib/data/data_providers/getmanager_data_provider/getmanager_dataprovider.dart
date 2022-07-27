import 'package:http/http.dart' as http;


class GetManagerDataProvider {

  Future<http.Response> getManagerData( String hrCode) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
    );
    return rawAttendanceData;
  }

}