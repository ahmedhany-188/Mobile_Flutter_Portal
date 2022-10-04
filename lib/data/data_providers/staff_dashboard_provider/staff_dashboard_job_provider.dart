

import 'package:http/http.dart' as http;

class StaffDashBoardJobDataProvider{

  Future<http.Response> getJobByProjects(Map<String, String> header,String projectCode,String director,String jobTitle,String dateFrom,String dateTo) async {

    http.Response rawCompaniesData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Apps/Dashboard/GetJobByProjects?ProjectCode=$projectCode&Director=$director&JobTitle=$jobTitle&FromDay=$dateFrom&ToDay=$dateTo"),
    headers: header,);


    return rawCompaniesData;

  }

}