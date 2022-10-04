import 'package:http/http.dart' as http;

class StaffDashBoardDataProvider {

  Future<http.Response> getUserAccessCompany(Map<String, String> header,String hrCode,String date) async {

    http.Response rawCompaniesData = await http.get(
      Uri.parse(
                "https://api.hassanallam.com/api/Apps/Dashboard/GetUserAccessCompany?UserHRCode=$hrCode&Day=$date"),
    headers: header);
      return rawCompaniesData;

  }

}