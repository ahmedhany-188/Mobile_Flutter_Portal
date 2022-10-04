import 'package:http/http.dart' as http;

class AttendanceDataProvider {

  Future<http.Response> getAttendanceList(Map<String, String> header,String hrCode, int monthNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
        "https://api.hassanallam.com/api/SelfService/GetAttendance?HRCode=$hrCode&MonthNo=$monthNumber"),
      headers: header,
    );
    return rawAttendanceData;
  }

}

