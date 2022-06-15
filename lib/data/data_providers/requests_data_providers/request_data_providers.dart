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

  Future<http.Response> getAccessAccountAccessRequest(String bodyString) async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITAccessRight"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    );
  }

  Future<http.Response> getEmailUserAccount(String bodyString) async {

    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITUserAccount"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,

    );
  }
  Future<http.Response> getBusinessCardRequest(String bodyString) async {
    return http.post(
        Uri.parse("https://api.hassanallam.com/api/SelfService/AddBusinessCard"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString
    );
  }


  Future<http.Response> getEmbassyLetterRequest(String bodyString) async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddEmbassyLetter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:bodyString
    );
  }

  Future<http.Response> getMyRequestsList(String bodyString) async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(bodyString),
    );
    return rawAttendanceData;
  }


  Future<http.Response> getDurationVacation(int type,String dateFrom,String dateTo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetVacationDuration?VacationType=$type&FromDate=$dateFrom&ToDate=$dateTo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getVacationRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetVacation?HRCode=$hrCode&requestno=$requestNo"),
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
    ).timeout(const Duration(seconds: 10));
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

  Future<http.Response> getBusinessMissionRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }
}