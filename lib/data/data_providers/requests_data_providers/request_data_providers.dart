import 'package:http/http.dart' as http;

class RequestDataProviders {

  Future<http.Response> postPermissionRequest(String bodyString) async {
    http.Response permissionFeedbackRequest = await http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddPermission"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    );
    print(permissionFeedbackRequest.body);
    return permissionFeedbackRequest;
  }

  Future<http.Response> getDurationVacation(int type,String dateFrom,String dateTo) async{
    // http://api.hassanallam.com:3415/api/SelfService/GetVacationDuration?VacationType=
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetVacationDuration?VacationType=$type&FromDate=$dateFrom&ToDate=$dateTo"),
    );
    print(rawDurationData.body);
    return rawDurationData;

  }
}