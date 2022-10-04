import 'package:http/http.dart' as http;


class GetManagerDataProvider {

  Future<http.Response> getManagerData( Map<String, String> header,String hrCode) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com:9998/api/Employee/GetEmployee?HRCode=$hrCode"),
      headers: header,
    );
    return rawAttendanceData;
  }

}