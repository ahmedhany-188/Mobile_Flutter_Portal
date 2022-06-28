import 'package:http/http.dart' as http;

class AttendanceDataProvider {

  Future<http.Response> getAttendanceList( String hrCode, int monthNumber) async {
    print("-------step1");
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
        "https://api.hassanallam.com/api/SelfService/GetAttendance?HRCode=$hrCode&MonthNo=$monthNumber"),
    );
    return rawAttendanceData;
  }

}

