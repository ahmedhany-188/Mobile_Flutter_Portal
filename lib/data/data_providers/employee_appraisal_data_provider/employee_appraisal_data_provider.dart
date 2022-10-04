
import 'package:http/http.dart' as http;


class EmployeeAppraisaleDataProvider {

  Future<http.Response> getEmployeeApraisalList(Map<String, String> header,String hrCode) async {
    http.Response rawEmployeeAppraisalData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Portal/GetAppraisalByHrcode?Hrcode=$hrCode"),
      headers: header,
    );

    return rawEmployeeAppraisalData;
  }


}