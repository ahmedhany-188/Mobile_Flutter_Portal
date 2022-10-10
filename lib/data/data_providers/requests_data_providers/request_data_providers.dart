import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../constants/url_links.dart';

class RequestDataProviders {
  Future<http.Response> postPermissionRequest(Map<String, String> header,String bodyString) async {
    http.Response permissionFeedbackRequest = await http
        .post(
          Uri.parse(addPermissionLink()),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(permissionFeedbackRequest.body);
    }
    if(permissionFeedbackRequest.statusCode == 200){
      return permissionFeedbackRequest;
    }else{
      throw RequestFailureApi(permissionFeedbackRequest.statusCode.toString());
    }

  }

  Future<http.Response> postAccessAccountAccessRequest(
      Map<String, String> header,String bodyString) async {
    return http
        .post(
          Uri.parse(addITAccessRightLink()),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postEmailUserAccount(Map<String, String> header,String bodyString) async {
    return http
        .post(
          Uri.parse(addITUserAccountLink()),
          headers:header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postBusinessCardRequest(Map<String, String> header,String bodyString) async {
    return http.post(Uri.parse(addBusinessCardLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postEmbassyLetterRequest(Map<String, String> header,String bodyString) async {
    return http.post(Uri.parse(addEmbassyLetterLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> getNewMobileNumberData(Map<String, String> header,String bodyString) async {
    return http.post(Uri.parse(addUserMobileLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> getDurationVacation(
  Map<String, String> header,int type, String dateFrom, String dateTo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getVacationDurationLink(type, dateFrom, dateTo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getVacationRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getVacationRequestLink(hrCode, requestNo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEquipmentRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getEquipmentLink(hrCode, requestNo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    return rawDurationData;
  }

  Future<http.Response> getBusinessCardRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getBusinessCardLink(hrCode, requestNo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getAccessRightRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getAccessRightLink(hrCode, requestNo)),
      headers: header,

    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetUserAccount?HRCode=$hrCode&requestno=$requestNo"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountData(Map<String, String> header,String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmbassyLetterRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetEmbassy?HRCode=$hrCode&requestno=$requestNo"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> postVacationRequest(Map<String, String> header,String bodyString) async {
    http.Response vacationFeedbackRequest = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/AddVacation"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(vacationFeedbackRequest.body);
    }
    return vacationFeedbackRequest;
  }

  Future<http.Response> postBusinessMissionRequest(Map<String, String> header,String bodyString) async {
    http.Response businessMissionFeedbackRequest = await http
        .post(
          Uri.parse(
              "https://api.hassanallam.com/api/SelfService/AddBusinessMission"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(businessMissionFeedbackRequest.body);
    }
    return businessMissionFeedbackRequest;
  }

  Future<http.Response> getBusinessMissionRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNo"),
      headers: header
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawData.body);
    }
    return rawData;
  }

  Future<http.Response> getPermissionRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrCode&requestno=$requestNo"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawData.body);
    }
    return rawData;
  }

  Future<http.Response> getMyRequestsData(Map<String, String> header,String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyRequests?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getMyNotificationData(Map<String, String> header,String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyNotification?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> postTakeActionOnRequest(Map<String, String> header,String bodyString) async {
    http.Response vacationFeedbackRequest = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/TakeAction"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(vacationFeedbackRequest.body);
    }
    return vacationFeedbackRequest;
  }

  Future<http.Response> postTakeEquipmentActionOnRequest(
      String bodyString,Map<String, String> header) async {
    http.Response equipmentFeedbackRequest = await http
        .post(
          Uri.parse(
              "https://api.hassanallam.com/api/SelfService/TakeActionEquipment"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10))
        .catchError((err) {
      EasyLoading.showError('Something went wrong');
      throw err;
    });
    return equipmentFeedbackRequest;
  }
}

class RequestFailureApi implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const RequestFailureApi([
    this.message = 'An Error has happened please try again',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory RequestFailureApi.fromCode(int code) {
    switch (code) {
      case 419:
        return const RequestFailureApi(
          "Token has expired",
        );

      default:
        return const RequestFailureApi();
    }
  }

  /// The associated error message.
  final String message;
}
