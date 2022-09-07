import 'package:http/http.dart' as http;

class StaffDashBoardProjectDataProvider{

  Future<http.Response> getProjectsBySubs(String company,String project,String director,String date) async {

    https://api.hassanallam.com/api/Apps/Dashboard/GetProjectsBySubs?Company=15&Project=0&Director=0&Day=2022-08-31
    https://api.hassanallam.com/api/Apps/Dashboard/GetProjectsBySubs?Company=0&Project=0&Director=0&Day=2022-09-05

    print("https://api.hassanallam.com/api/Apps/Dashboard/GetProjectsBySubs?Company=$company&Project=$project&Director=$director&Day=$date");
    http.Response rawCompaniesData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Apps/Dashboard/GetProjectsBySubs?Company=$company&Project=$project&Director=$director&Day=$date"),);
    return rawCompaniesData;

  }

}