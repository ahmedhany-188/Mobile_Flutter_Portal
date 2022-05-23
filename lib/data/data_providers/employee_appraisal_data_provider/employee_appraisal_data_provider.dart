
import 'package:http/http.dart' as http;


class EmployeeAppraisaleDataProvider {

  String hrCode;

  EmployeeAppraisaleDataProvider(this.hrCode);


  Future<http.Response> getEmployeeApraisalList() async {
    http.Response rawEmployeeAppraisalData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Portal/GetAppraisalByHrcode?Hrcode=" +
              hrCode.toString()),
    );

    return rawEmployeeAppraisalData;
  }


}