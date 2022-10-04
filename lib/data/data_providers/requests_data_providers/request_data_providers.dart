import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

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
    return permissionFeedbackRequest;
  }

  Future<http.Response> postAccessAccountAccessRequest(
      String bodyString) async {
    return http
        .post(
          Uri.parse(addITAccessRightLink()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postEmailUserAccount(String bodyString) async {
    return http
        .post(
          Uri.parse(addITUserAccountLink()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postBusinessCardRequest(String bodyString) async {
    return http.post(Uri.parse(addBusinessCardLink()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> postEmbassyLetterRequest(String bodyString) async {
    return http.post(Uri.parse(addEmbassyLetterLink()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> getNewMobileNumberData(String bodyString) async {
    return http.post(Uri.parse(addUserMobileLink()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString).timeout(const Duration(seconds: 10));
  }

  Future<http.Response> getDurationVacation(
      int type, String dateFrom, String dateTo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getVacationDurationLink(type, dateFrom, dateTo)),
    ).timeout(const Duration(seconds: 10));
    print(rawDurationData.body);
    return rawDurationData;
  }

  Future<http.Response> getVacationRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getVacationRequestLink(hrCode, requestNo)),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEquipmentRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getEquipmentLink(hrCode, requestNo)),
    ).timeout(const Duration(seconds: 10));
    return rawDurationData;
  }

  Future<http.Response> getBusinessCardRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getBusinessCardLink(hrCode, requestNo)),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getAccessRightRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getAccessRightLink(hrCode, requestNo)),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetUserAccount?HRCode=$hrCode&requestno=$requestNo"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmailAccountData(String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/Employee/GetEmployee?HRCode=$hrCode"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getEmbassyLetterRequestData(
      String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetEmbassy?HRCode=$hrCode&requestno=$requestNo"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> postVacationRequest(String bodyString) async {
    http.Response vacationFeedbackRequest = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/AddVacation"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(vacationFeedbackRequest.body);
    }
    return vacationFeedbackRequest;
  }

  Future<http.Response> postBusinessMissionRequest(String bodyString) async {
    http.Response businessMissionFeedbackRequest = await http
        .post(
          Uri.parse(
              "https://api.hassanallam.com/api/SelfService/AddBusinessMission"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(businessMissionFeedbackRequest.body);
    }
    return businessMissionFeedbackRequest;
  }

  Future<http.Response> getBusinessMissionRequestData(
      String hrCode, String requestNo) async {
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNo"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawData.body);
    }
    return rawData;
  }

  Future<http.Response> getPermissionRequestData(
      String hrCode, String requestNo) async {
    http.Response rawData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrCode&requestno=$requestNo"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawData.body);
    }
    return rawData;
  }

  Future<http.Response> getMyRequestsData(String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyRequests?HRCode=$hrCode"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> getMyNotificationData(String hrCode) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyNotification?HRCode=$hrCode"),
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(rawDurationData.body);
    }
    return rawDurationData;
  }

  Future<http.Response> postTakeActionOnRequest(String bodyString) async {
    http.Response vacationFeedbackRequest = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/TakeAction"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(vacationFeedbackRequest.body);
    }
    return vacationFeedbackRequest;
  }

  Future<http.Response> postTakeEquipmentActionOnRequest(
      String bodyString) async {
    http.Response equipmentFeedbackRequest = await http
        .post(
          Uri.parse(
              "https://api.hassanallam.com/api/SelfService/TakeActionEquipment"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
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
