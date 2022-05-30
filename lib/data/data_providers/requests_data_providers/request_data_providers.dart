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
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetVacationDuration?VacationType=$type&FromDate=$dateFrom&ToDate=$dateTo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> postVacationRequest(String bodyString) async {
    http.Response vacationFeedbackRequest = await http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddVacation"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    );
    print(vacationFeedbackRequest.body);
    return vacationFeedbackRequest;
  }
  Future<http.Response> postBusinessMissionRequest(String bodyString) async {
    http.Response businessMissionFeedbackRequest = await http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddBusinessMission"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    );
    print(businessMissionFeedbackRequest.body);
    return businessMissionFeedbackRequest;
  }
}