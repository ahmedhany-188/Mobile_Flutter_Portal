// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/requests_data_providers/request_data_providers.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_vacation_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_duration_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_vacation_data_model.dart';
import 'package:http/http.dart' as http;

import '../../constants/request_service_id.dart';

class RequestRepository {
  final RequestDataProviders requestDataProviders = RequestDataProviders();
  final MainUserData userData;

  RequestRepository(this.userData);



  Future<RequestResponse> postPermissionRequest(
      {required String requestDate, required String comments,
        required String dateFromAmpm, required String dateTo, required int type,
        required String dateFrom, required String dateToAmpm, required String permissionDate}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "date": requestDate,
      "comments": comments,
      "dateFromAmpm": dateFromAmpm,
      "requestHrCode": userData.user?.userHRCode!,
      "dateTo": dateTo,
      "serviceId": RequestServiceID.PermissionServiceID,
      "type": type,
      "dateFrom": dateFrom,
      "dateToAmpm": dateToAmpm,
      "permissionDate": permissionDate,
    });
    final http.Response rawPermission = await requestDataProviders
        .postPermissionRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }

  Future<RequestResponse> postAccessRightRequest(
      {required AccessRightModel accessRightModel}) async {
    var bodyString = jsonEncode(<String, dynamic>
    {
      "ServiceId": "HAH-IT-FRM-07",
      "RequestHrCode": userData.employeeData!.userHrCode,
      "Date": "${accessRightModel.requestDate}T10:43:37.994Z",
      "FilePdf": (accessRightModel.filePDF != null)
          ? accessRightModel.filePDF
          : null,
      "Comments": accessRightModel.comments,
      "ReqType": accessRightModel.requestType,
      "StartDate": accessRightModel.fromDate,
      "EndDate": accessRightModel.toDate,
      "IsPermanent": accessRightModel.permanent,
      "USBException": (accessRightModel.items.contains("USB Exception")
          ? true
          : false),
      "VPNAccount": (accessRightModel.items.contains("VPN Account")
          ? true
          : false),
      "IPPhone": (accessRightModel.items.contains("IP Phone") ? true : false),
      "LocalAdmin": (accessRightModel.items.contains("Local Admin")
          ? true
          : false),
    });
    final http.Response rawAccess = await requestDataProviders
        .getAccessAccountAccessRequest(bodyString);
    final json = await jsonDecode(rawAccess.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }



  Future<DurationResponse> getDurationVacation(int type,String dateFrom,String dateTo) async{
    final http.Response rawPermission = await requestDataProviders
        .getDurationVacation(type,dateFrom,dateTo);
    final json = await jsonDecode(rawPermission.body);
    final DurationResponse response = DurationResponse.fromJson(json);
    return response;
  }

  Future<RequestResponse> postVacationRequest(
      { required String requestDate, required String comments,
        required String dateTo, required String type,required String responsibleHRCode,required int noOfDays,
        required String dateFrom}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "date": requestDate,
      "comments": comments,
      "requestHrCode": userData.user?.userHRCode!,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "serviceId": RequestServiceID.VacationServiceID,
      "vacationType": type,
      "responsible": responsibleHRCode,
      "noOfDays": noOfDays,
      "replacedWith": "",
      "replacedWithTo": "",
      // data.put("replacedWith",selectedReplaceFrom);
      // data.put("replacedWithTo",selectedReplaceTo);
    });
    final http.Response rawPermission = await requestDataProviders
        .postVacationRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }

  Future<RequestResponse> postBusinessMission(
      { required String requestDate, required String comments,
        required String dateTo, required String type, required String dateFromAmpm,required String dateToAmpm,
        required String dateFrom,required String hourFrom,required String hourTo}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": RequestServiceID.BusinessMissionServiceID,
      "requestHrCode": userData.user?.userHRCode!,
      "date": requestDate,
      "comments": comments,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "dateFromAmpm": dateFromAmpm,
      "dateToAmpm": dateToAmpm,
      "hourFrom": hourFrom,
      "hourTo": hourTo,
      "missionLocation": type,

    });
    final http.Response rawRequest = await requestDataProviders
        .postBusinessMissionRequest(bodyString);
    final json = await jsonDecode(rawRequest.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }

  Future<VacationRequestData> getVacationRequestData(String requestNo) async{
    final http.Response rawRequestData = await requestDataProviders
        .getVacationRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final VacationRequestData response = VacationRequestData.fromJson(json[0]);

    return response;
  }




}