import 'package:http/http.dart' as http;

class AttendanceDataProvider {

  String month = "";
  String hrcode="";


  AttendanceDataProvider(this.month, this.hrcode);

  Future<http.Response> getAttendanceList() async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
        "https://api.hassanallam.com/api/SelfService/GetAttendance?HRCode=$hrcode&MonthNo=$month"),
    );
    print(rawAttendanceData.body);
    return rawAttendanceData;
  }
}

