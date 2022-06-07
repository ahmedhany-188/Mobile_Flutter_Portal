import 'package:http/http.dart' as http;

class MyRequestsDetailDataProvider {

  MyRequestsDetailDataProvider();

  Future<http.Response> getBusinessMission(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );

    return rawAttendanceData;
  }

  Future<http.Response> getPermission(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );
    return rawAttendanceData;
  }

  Future<http.Response> getVacation(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetVacation?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );
    return rawAttendanceData;
  }

  Future<http.Response> getEmbassy(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetEmbassy?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );

    return rawAttendanceData;
  }

  Future<http.Response> getAccount(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetUserAccount?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );

    return rawAttendanceData;
  }

  Future<http.Response> getGetAccessRight(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetAccessRight?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );
    return rawAttendanceData;
  }

  Future<http.Response> getGetBusinessCard(hrcode, requestNumber) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessCard?HRCode=$hrcode&requestno=$requestNumber"
      ),
    );
    return rawAttendanceData;
  }

}