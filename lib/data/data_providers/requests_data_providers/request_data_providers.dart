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
    ).timeout(const Duration(seconds: 10));
    print(permissionFeedbackRequest.body);
    return permissionFeedbackRequest;
  }

  Future<http.Response> postAccessAccountAccessRequest(String bodyString) async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITAccessRight"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    ).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postEmailUserAccount(String bodyString) async {

    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITUserAccount"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,

    ).timeout(const Duration(seconds: 10));
  }
  Future<http.Response> postBusinessCardRequest(String bodyString) async {
    return http.post(
        Uri.parse("https://api.hassanallam.com/api/SelfService/AddBusinessCard"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString
    );
  }




  Future<http.Response> postEmbassyLetterRequest(String bodyString) async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddEmbassyLetter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:bodyString
    );
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

  Future<http.Response> getBusinessCardRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessCard?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getEquipmentsRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetEquipments?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getAccessRightRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetAccessRight?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetUserAccount?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountData(String hrCode) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getEmbassyLetterRequestData(String hrCode,String requestNo) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetEmbassy?HRCode=$hrCode&requestno=$requestNo"),
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
    ).timeout(const Duration(seconds: 10));
    print(businessMissionFeedbackRequest.body);
    return businessMissionFeedbackRequest;
  }

  Future<http.Response> getBusinessMissionRequestData(String hrCode,String requestNo) async{
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawData.body);
    return rawData;
  }
  Future<http.Response> getPermissionRequestData(String hrCode,String requestNo) async{
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrCode&requestno=$requestNo"),
    );
    print(rawData.body);
    return rawData;
  }

  Future<http.Response> getMyRequestsData(String hrCode) async{
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyRequests?HRCode=$hrCode"),
    );
    print(rawDurationData.body);
    return rawDurationData;
  }


  Future<http.Response> postTakeActionOnRequest(String bodyString) async {
    http.Response vacationFeedbackRequest = await http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/TakeAction"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    ).timeout(const Duration(seconds: 10));
    print(vacationFeedbackRequest.body);
    return vacationFeedbackRequest;
  }


}