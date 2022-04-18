import 'package:http/http.dart' as http;

class AttendanceDataProvider {

  String month = "02";
  String hrcode="10204738";


  AttendanceDataProvider();

  Future<http.Response> getAttendanceList() async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
        "https://api.hassanallam.com/api/SelfService/GetAttendance?HRCode=$hrcode&MonthNo=$month"),
    );

    return rawAttendanceData;
  }

}

