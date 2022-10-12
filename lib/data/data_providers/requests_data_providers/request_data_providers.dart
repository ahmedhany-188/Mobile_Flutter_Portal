import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../constants/url_links.dart';
import '../../../main.dart';

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
      throw RequestFailureApi.fromCode(permissionFeedbackRequest.statusCode);
    }

  }

  Future<http.Response> postAccessAccountAccessRequest(
      Map<String, String> header,String bodyString) async {
    http.Response response =  await http
        .post(
          Uri.parse(addITAccessRightLink()),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
  }

  Future<http.Response> postEmailUserAccount(Map<String, String> header,String bodyString) async {
   http.Response response = await http
        .post(
          Uri.parse(addITUserAccountLink()),
          headers:header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
  }

  Future<http.Response> postBusinessCardRequest(Map<String, String> header,String bodyString) async {
    http.Response response = await http.post(Uri.parse(addBusinessCardLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
  }

  Future<http.Response> postEmbassyLetterRequest(Map<String, String> header,String bodyString) async {
    http.Response response = await http.post(Uri.parse(addEmbassyLetterLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
  }

  Future<http.Response> getNewMobileNumberData(Map<String, String> header,String bodyString) async {
    http.Response response = await http.post(Uri.parse(addUserMobileLink()),
        headers: header,
        body: bodyString).timeout(const Duration(seconds: 10));
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
  }

  Future<http.Response> getDurationVacation(
  Map<String, String> header,int type, String dateFrom, String dateTo) async {
    http.Response response = await http.get(
      Uri.parse(getVacationDurationLink(type, dateFrom, dateTo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawDurationData;
  }

  Future<http.Response> getVacationRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response response = await http.get(
      Uri.parse(getVacationRequestLink(hrCode, requestNo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawDurationData;
  }

  Future<http.Response> getEquipmentRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response rawDurationData = await http.get(
      Uri.parse(getEquipmentLink(hrCode, requestNo)),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
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
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
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
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
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
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
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
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
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
    if(rawDurationData.statusCode == 200){
      return rawDurationData;
    }else{
      throw RequestFailureApi.fromCode(rawDurationData.statusCode);
    }
    // return rawDurationData;
  }

  Future<http.Response> postVacationRequest(Map<String, String> header,String bodyString) async {
    http.Response response = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/AddVacation"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return vacationFeedbackRequest;
  }

  Future<http.Response> postBusinessMissionRequest(Map<String, String> header,String bodyString) async {
    http.Response response = await http
        .post(
          Uri.parse(
              "https://api.hassanallam.com/api/SelfService/AddBusinessMission"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return businessMissionFeedbackRequest;
  }

  Future<http.Response> getBusinessMissionRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetBusinessMission?HRCode=$hrCode&requestno=$requestNo"),
      headers: header
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawData;
  }

  Future<http.Response> getPermissionRequestData(
  Map<String, String> header,String hrCode, String requestNo) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetPermission?HRCode=$hrCode&requestno=$requestNo"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawData;
  }

  Future<http.Response> getMyRequestsData(Map<String, String> header,String hrCode) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyRequests?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawDurationData;
  }

  Future<http.Response> getMyNotificationData(Map<String, String> header,String hrCode) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/GetMyNotification?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return rawDurationData;
  }

  Future<http.Response> postTakeActionOnRequest(Map<String, String> header,String bodyString) async {
    http.Response response = await http
        .post(
          Uri.parse("https://api.hassanallam.com/api/SelfService/TakeAction"),
          headers: header,
          body: bodyString,
        )
        .timeout(const Duration(seconds: 10));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return vacationFeedbackRequest;
  }

  Future<http.Response> postTakeEquipmentActionOnRequest(
      String bodyString,Map<String, String> header) async {
    http.Response response = await http
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
    if(response.statusCode == 200){
      return response;
    }else{
      throw RequestFailureApi.fromCode(response.statusCode);
    }
    // return equipmentFeedbackRequest;
  }
}
class RequestFailureApi implements Exception {
  /// The associated error message.
  final String message;

  /// {@macro log_in_with_email_and_password_failure}
  const RequestFailureApi([
    this.message = 'An Error has happened please try again',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory RequestFailureApi.fromCode(int code) {
    switch (code) {
      case 419:
        timedOut();
        return const RequestFailureApi(
          "Token has expired",
        );

      default:
        return const RequestFailureApi();
    }
  }



}
