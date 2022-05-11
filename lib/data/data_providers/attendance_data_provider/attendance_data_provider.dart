import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AttendanceDataProvider {


  AttendanceDataProvider();

  Future<http.Response> getAttendanceList(hrcode,monthNumber) async {

    http.Response rawAttendanceData = await http.get(
      Uri.parse(
        "https://api.hassanallam.com/api/SelfService/GetAttendance?HRCode=$hrcode&MonthNo=$monthNumber"),
    );

    return rawAttendanceData;
  }

}

