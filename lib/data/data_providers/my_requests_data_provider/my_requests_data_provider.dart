import 'package:http/http.dart' as http;

class MyRequestsDataProvider {

  MyRequestsDataProvider();

  Future<http.Response> getMyRequestsList(hrCode) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyRequests?HRCode=$hrCode"
      ),
    );

    return rawAttendanceData;
  }
}