// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/data_providers/requests_data_providers/request_data_providers.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_account_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_business_card_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_business_mission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_embassy_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_vacation_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_duration_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_vacation_data_model.dart';
import 'package:http/http.dart' as http;

import '../../constants/request_service_id.dart';
import '../models/requests_form_models/request_business_mission_data_model.dart';
import '../models/requests_form_models/request_permission_data_model.dart';

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
      "ServiceId": RequestServiceID.AccessRightServiceID,
      "RequestHrCode": userData.employeeData!.userHrCode,
      "Date": accessRightModel.requestDate,
      "FilePdf": (accessRightModel.filePDF != null)
          ? accessRightModel.filePDF
          : null,
      "Comments": accessRightModel.comments,
      "requestHrCode": userData.user?.userHRCode!,

      "ReqType": accessRightModel.requestType,
      "StartDate": accessRightModel.fromDate,
      "EndDate": accessRightModel.toDate,
      "IsPermanent": accessRightModel.permanent,
      "USBException": accessRightModel.usbException,
      "VPNAccount": accessRightModel.vpnAccount,
      "IPPhone": accessRightModel.ipPhone,
      "LocalAdmin": accessRightModel.localAdmin,
    });

    final http.Response rawAccess = await requestDataProviders
        .postAccessAccountAccessRequest(bodyString);
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

  Future<BusinessCardFormModel> geBusinessCard(String requestNo) async{
    final http.Response rawPermission = await requestDataProviders
        .getBusinessCardRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawPermission.body);
    final BusinessCardFormModel response = BusinessCardFormModel.fromJson(json[0]);
    return response;
  }

  Future<AccessRightModel> getAccessRight(String requestNo) async{
    final http.Response rawPermission = await requestDataProviders
        .getAccessRightRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawPermission.body);
    final AccessRightModel response = AccessRightModel.fromJson(json[0]);

    print("-.-.-."+json.toString());
    return response;

  }

  Future<EmailUserFormModel> getEmailAccount(String requestNo) async{
    final http.Response rawPermission = await requestDataProviders
        .getEmailAccountRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawPermission.body);
    final EmailUserFormModel response = EmailUserFormModel.fromJson(json[0]);

    return response;
  }

  Future<EmployeeData> getEmailData(String hrCode) async{
    final http.Response rawPermission = await requestDataProviders
        .getEmailAccountData(hrCode);
    final json = await jsonDecode(rawPermission.body);
    final EmployeeData response = EmployeeData.fromJson(json[0]);
    return response;
  }

  Future<EmbassyLetterFormModel> getEmbassyLetter(String requestNo) async{
    final http.Response rawPermission = await requestDataProviders
        .getEmbassyLetterRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawPermission.body);
    final EmbassyLetterFormModel response = EmbassyLetterFormModel.fromJson(json[0]);
    return response;
  }


  Future<RequestResponse> postBusinessCard(
        {required BusinessCardFormModel businessCardFormModel}) async {

    var bodyString=jsonEncode(<String, dynamic>{
      "serviceId": RequestServiceID.BusinessCardServiceID,
      "requestHrCode": userData.employeeData!.userHrCode,
      "ownerHrCode": userData.employeeData!.userHrCode,
      "date": businessCardFormModel.requestDate,
      "comments": businessCardFormModel.employeeComments,
      "cardName": businessCardFormModel.employeeNameCard,
      "faxNo": businessCardFormModel.faxNo,
      "extNo": businessCardFormModel.employeeExt,
      "mobileNo": businessCardFormModel.employeeMobil
    });
    print("ohhh herer");
    final http.Response rawBusinessCard = await requestDataProviders
        .postBusinessCardRequest(bodyString);
    final json = await jsonDecode(rawBusinessCard.body);
    print("ohhh herer"+json.toString());
    final RequestResponse response = RequestResponse.fromJson(json);
    print("ohhh herer"+response.toString());

    return response;
  }

  Future<List<MyRequestsModelData>> getMyRequestsData() async {
     http.Response rawMyRequests = await requestDataProviders
        .getMyRequestsData(userData.user?.userHRCode ?? "");
     final json = await jsonDecode(rawMyRequests.body);

     List<MyRequestsModelData> myRequestsData = List<MyRequestsModelData>.from(
         json.map((model) => MyRequestsModelData.fromJson(model)));
    return myRequestsData;

  }


  Future<RequestResponse> postEmailUserAccount({required EmailUserFormModel emailUserFormModel}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "ServiceId": RequestServiceID.EmailUserAccountServiceID,
      "RequestHrCode": userData.user!.userHRCode,
      "Date": emailUserFormModel.requestDate,
      "OwnerHrCode": emailUserFormModel.requestHrCode,
      "OwnerFullName": emailUserFormModel.fullName,
      "OwnerTitle": emailUserFormModel.title,
      "OwnerLocation": emailUserFormModel.location,
      "OwnerMobile": emailUserFormModel.userMobile,
      "OwnerEmailDisabled": userData.user!.email,
      "Status": 0,
      "ReRequestCode": 0,
      "ReqType": emailUserFormModel.requestType,
      "AnswerEmail": "string",
      "EmailAccount": emailUserFormModel.accountType,
    });

    final http.Response rawEmailUserAccount = await requestDataProviders
        .postEmailUserAccount(bodyString);
    final json = await jsonDecode(rawEmailUserAccount.body);
    final RequestResponse response = RequestResponse.fromJson(json);

    return response;
  }


  Future<RequestResponse> postEmbassyLetter({required EmbassyLetterFormModel embassyLetterFormModel}) async {
    var bodyString = jsonEncode(<String, dynamic>
    {
      "serviceId": RequestServiceID.EmbassyServiceID,
      "requestHrCode": userData.employeeData!.userHrCode,
      "ownerHrCode": userData.employeeData!.userHrCode,
      "date": GlobalConstants.dateFormatServer.format(
          GlobalConstants.dateFormatViewed.parse(
              embassyLetterFormModel.requestDate!)),
      "comments": embassyLetterFormModel.comments,
      "dateFrom": GlobalConstants.dateFormatServer.format(
          GlobalConstants.dateFormatViewed.parse(
              embassyLetterFormModel.dateFrom!)),
      "dateTo": GlobalConstants.dateFormatServer.format(
          GlobalConstants.dateFormatViewed.parse(
              embassyLetterFormModel.dateTo!)),
      "purpose": embassyLetterFormModel.purpose,
      "embassyId": embassyLetterFormModel.embassy,
      "passportNo": embassyLetterFormModel.passportNo,
      "addSalary": embassyLetterFormModel.addSalary,
    });

    final http.Response rawEmbassyLetter = await requestDataProviders
        .postEmbassyLetterRequest(bodyString);
    final json = await jsonDecode(rawEmbassyLetter.body);
    final RequestResponse response = RequestResponse.fromJson(json);
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

  Future<VacationRequestData> getVacationRequestData(String requestNo,String requesterHRCode) async{
    final http.Response rawRequestData = await requestDataProviders
        .getVacationRequestData(requesterHRCode,requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final VacationRequestData response = VacationRequestData.fromJson(json[0]);

    return response;
  }
  Future<BusinessMissionRequestData> getBusinessMissionRequestData(String requestNo) async{
    final http.Response rawRequestData = await requestDataProviders
        .getBusinessMissionRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final BusinessMissionRequestData response = BusinessMissionRequestData.fromJson(json[0]);

    return response;
  }
  Future<PermissionRequestData> getPermissionRequestData(String requestNo) async{
    final http.Response rawRequestData = await requestDataProviders
        .getPermissionRequestData(userData.user?.userHRCode ?? "",requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final PermissionRequestData response = PermissionRequestData.fromJson(json[0]);
    return response;
  }


  Future<RequestResponse> postTakeActionRequest(bool takeAction) async{
    var bodyString = jsonEncode(<String, dynamic>{
      // "serviceId": serviceID,
      // "reqno": requestNo,
      // "Approve": takeAction? 1 : 2,
      // "requesterhrcode": requesterHRCode ,
      "mangerHrCode": userData.user?.userHRCode ?? "0",
      "comment" :""
    });
    final http.Response rawPermission = await requestDataProviders
        .postTakeActionOnRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }







}