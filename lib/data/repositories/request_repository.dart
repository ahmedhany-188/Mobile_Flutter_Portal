import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/data/data_providers/requests_data_providers/request_data_providers.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/equipments_models/next_step_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_duration_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_vacation_data_model.dart';
import 'package:hassanallamportalflutter/data/models/user_notification_api/user_notification_api.dart';
import 'package:hassanallamportalflutter/data/repositories/employee_repository.dart';
import 'package:http/http.dart' as http;

import '../../constants/request_service_id.dart';
import '../models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../models/it_requests_form_models/equipments_models/departments_model.dart';
import '../models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../models/it_requests_form_models/equipments_models/equipments_requested_model.dart';
import '../models/it_requests_form_models/equipments_models/selected_equipments_model.dart';
import '../models/requests_form_models/request_business_mission_data_model.dart';
import '../models/requests_form_models/request_permission_data_model.dart';
import '../models/response_take_action.dart';

class RequestRepository {
  final RequestDataProviders requestDataProviders = RequestDataProviders();
  MainUserData? userData;

  // RequestRepository(this.userData?);

  static final RequestRepository _inst = RequestRepository._internal();

  RequestRepository._internal();

  factory RequestRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }
  
  Future<RequestResponse> postPermissionRequest(
      {required String requestDate,
      required String comments,
      required String dateFromAmpm,
      required String dateTo,
      required int type,
      required String dateFrom,
      required String dateToAmpm,
      required String permissionDate}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "date": requestDate,
      "comments": comments,
      "dateFromAmpm": dateFromAmpm,
      "requestHrCode": userData?.user?.userHRCode!,
      "dateTo": dateTo,
      "serviceId": RequestServiceID.permissionServiceID,
      "type": type,
      "dateFrom": dateFrom,
      "dateToAmpm": dateToAmpm,
      "permissionDate": permissionDate,
    });
    final http.Response rawPermission =
        await requestDataProviders.postPermissionRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryPermissionActivity, "Submit");
    }
    return response;
  }

  Future<RequestResponse> postAccessRightRequest(
      {required AccessRightModel accessRightModel}) async {

    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": RequestServiceID.accessRightServiceID,
      "requestHrCode": userData?.employeeData!.userHrCode,
      "date": accessRightModel.requestDate,
      "filePdf":
          (accessRightModel.filePDF != null) ? accessRightModel.filePDF : null,
      "comments": accessRightModel.comments,
      //"requestHrCode": userData?.user?.userHRCode!,

      "reqType": accessRightModel.requestType,
      "startDate": accessRightModel.fromDate,
      "endDate": accessRightModel.toDate,
      "isPermanent": accessRightModel.permanent,
      "usbException": accessRightModel.usbException,
      "vpnAccount": accessRightModel.vpnAccount,
      "ipPhone": accessRightModel.ipPhone,
      "localAdmin": accessRightModel.localAdmin,
      "printing":accessRightModel.printing,
    });

    final http.Response rawAccess =
        await requestDataProviders.postAccessAccountAccessRequest(bodyString);
    final json = await jsonDecode(rawAccess.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryAccessRight, "Submit");
    }
    return response;
  }

  Future<DurationResponse> getDurationVacation(
      int type, String dateFrom, String dateTo) async {
    final http.Response rawPermission =
        await requestDataProviders.getDurationVacation(type, dateFrom, dateTo);
    final json = await jsonDecode(rawPermission.body);
    final DurationResponse response = DurationResponse.fromJson(json);
    return response;
  }

  Future<BusinessCardFormModel> getBusinessCard(
      String requestNo, String requesterHRCode) async {
    final http.Response rawPermission =
        await requestDataProviders.getBusinessCardRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawPermission.body);
    final BusinessCardFormModel response =
        BusinessCardFormModel.fromJson(json[0]);

    return response;
  }

  Future<AccessRightModel> getAccessRight(
      String requestNo, String requesterHRCode) async {
    final http.Response rawPermission =
        await requestDataProviders.getAccessRightRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawPermission.body);
    final AccessRightModel response = AccessRightModel.fromJson(json[0]);

    return response;
  }

  Future<EmailUserFormModel> getEmailAccount(
      String requestNo, String requesterHRCode) async {
    final http.Response rawPermission =
        await requestDataProviders.getEmailAccountRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawPermission.body);
    final EmailUserFormModel response = EmailUserFormModel.fromJson(json[0]);

    return response;
  }

  Future<dynamic> getEmailData(String hrCode) async {
    final http.Response rawPermission =
        await requestDataProviders.getEmailAccountData(hrCode);
    final json = await jsonDecode(rawPermission.body);
    final EmployeeData response;
    try {
      response = EmployeeData.fromJson(json[0]);
    } catch (e) {
      return "error";
    }
    return response;
  }

  Future<dynamic> setNewUserMobileNumber(String mobile, String hrCode) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "hrCode": hrCode,
      "mobile": mobile,
    });
    final http.Response rawPermission =
        await requestDataProviders.getNewMobileNumberData(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }

  Future<EmbassyLetterFormModel> getEmbassyLetter(
      String requestNo, String requesterHRCode) async {
    final http.Response rawPermission =
        await requestDataProviders.getEmbassyLetterRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawPermission.body);
    final EmbassyLetterFormModel response =
        EmbassyLetterFormModel.fromJson(json[0]);
    return response;
  }

  Future<RequestResponse> postBusinessCard(
      {required BusinessCardFormModel businessCardFormModel}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": RequestServiceID.businessCardServiceID,
      "requestHrCode": userData?.employeeData!.userHrCode,
      "ownerHrCode": userData?.employeeData!.userHrCode,
      "date": businessCardFormModel.requestDate,
      "comments": businessCardFormModel.employeeComments,
      "cardName": businessCardFormModel.employeeNameCard,
      "faxNo": businessCardFormModel.faxNo,
      "extNo": businessCardFormModel.employeeExt,
      "mobileNo": businessCardFormModel.employeeMobil
    });

    final http.Response rawBusinessCard =
        await requestDataProviders.postBusinessCardRequest(bodyString);
    final json = await jsonDecode(rawBusinessCard.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryBusniessCardActivity, "Submit");
    }
    return response;
  }

  Future<List<MyRequestsModelData>> getMyRequestsData() async {
    http.Response rawMyRequests = await requestDataProviders
        .getMyRequestsData(userData?.user?.userHRCode ?? "");
    final json = await jsonDecode(rawMyRequests.body);

    List<MyRequestsModelData> myRequestsData = List<MyRequestsModelData>.from(
        json.map((model) => MyRequestsModelData.fromJson(model)));
    return myRequestsData;
  }

  Future<List<UserNotificationApi>> getMyNotificationData() async {
    http.Response rawMyRequests = await requestDataProviders
        .getMyNotificationData(userData?.user?.userHRCode ?? "");
    final json = await jsonDecode(rawMyRequests.body);

    if (kDebugMode) {
      print(json);
    }

    List<UserNotificationApi> myRequestsData = List<UserNotificationApi>.from(
        json.map((model) => UserNotificationApi.fromJson(model)));
    return myRequestsData;
  }

  Future<RequestResponse> postEmailUserAccount(
      {required EmailUserFormModel emailUserFormModel}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "ServiceId": RequestServiceID.emailUserAccountServiceID,
      "RequestHrCode": userData?.user!.userHRCode,
      "Date": emailUserFormModel.requestDate,
      "OwnerHrCode": emailUserFormModel.ownerHrCode,
      "OwnerFullName": emailUserFormModel.fullName,
      "OwnerTitle": emailUserFormModel.title,
      "OwnerLocation": emailUserFormModel.location,
      "OwnerMobile": emailUserFormModel.userMobile,
      "OwnerEmailDisabled": emailUserFormModel.fullName,
      "Status": 0,
      "ReRequestCode": 0,
      "ReqType": emailUserFormModel.requestType,
      "AnswerEmail": "string",
      "EmailAccount": emailUserFormModel.accountType,
    });

    final http.Response rawEmailUserAccount =
        await requestDataProviders.postEmailUserAccount(bodyString);
    final json = await jsonDecode(rawEmailUserAccount.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryUserAccount, "Submit");
    }
    return response;
  }

  Future<RequestResponse> postEmbassyLetter(
      {required EmbassyLetterFormModel embassyLetterFormModel}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "ServiceId": RequestServiceID.embassyServiceID,
      "RequestHrCode": userData?.employeeData!.userHrCode,
      "OwnerHrCode": userData?.employeeData!.userHrCode,
      "date": GlobalConstants.dateFormatServer.format(GlobalConstants
          .dateFormatViewed
          .parse(embassyLetterFormModel.requestDate!)),
      "comments": embassyLetterFormModel.comments.toString(),
      "dateFrom": GlobalConstants.dateFormatServer.format(GlobalConstants
          .dateFormatViewed
          .parse(embassyLetterFormModel.dateFrom!)),
      "dateTo": GlobalConstants.dateFormatServer.format(GlobalConstants
          .dateFormatViewed
          .parse(embassyLetterFormModel.dateTo!)),
      "purpose": embassyLetterFormModel.purpose.toString(),
      "embassyId": embassyLetterFormModel.embassy,
      "passportNo": embassyLetterFormModel.passportNo.toString(),
      "addSalary": embassyLetterFormModel.addSalary.toString(),
    });

    final http.Response rawEmbassyLetter =
        await requestDataProviders.postEmbassyLetterRequest(bodyString);
    final json = await jsonDecode(rawEmbassyLetter.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryEmbassyActivity, "Submit");
    }
    return response;
  }

  Future<RequestResponse> postVacationRequest(
      {required String requestDate,
      required String comments,
      required String dateTo,
      required String type,
      required String responsibleHRCode,
      required int noOfDays,
      required String dateFrom}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "date": requestDate,
      "comments": comments,
      "requestHrCode": userData?.user?.userHRCode!,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "serviceId": RequestServiceID.vacationServiceID,
      "vacationType": type,
      "responsible": responsibleHRCode,
      "noOfDays": noOfDays,
      "replacedWith": "",
      "replacedWithTo": "",
      // data.put("replacedWith",selectedReplaceFrom);
      // data.put("replacedWithTo",selectedReplaceTo);
    });
    final http.Response rawPermission =
    await requestDataProviders.postVacationRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);

    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryVacationActivity, "Submit");
    }
    return response;
  }

  Future<RequestResponse> postBusinessMission(
      {required String requestDate,
      required String comments,
      required String dateTo,
      required String type,
      required String dateFromAmpm,
      required String dateToAmpm,
      required String dateFrom,
      required String hourFrom,
      required String hourTo,
      required LocationData locationData}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": RequestServiceID.businessMissionServiceID,
      "requestHrCode": userData?.user?.userHRCode!,
      "date": requestDate,
      "comments": comments,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "dateFromAmpm": dateFromAmpm,
      "dateToAmpm": dateToAmpm,
      "hourFrom": hourFrom,
      "hourTo": hourTo,
      "missionLocation": type,
      "projectId": locationData.projectId == 0 ? null : locationData.projectId.toString()
    });
    final http.Response rawRequest =
        await requestDataProviders.postBusinessMissionRequest(bodyString);
    final json = await jsonDecode(rawRequest.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    if (response.id == 1) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addSubmitFirebaseNotification(
          response.requestNo.toString(), GlobalConstants.requestCategoryBusinessMissionActivity, "Submit");
    }
    return response;
  }

  Future<RequestResponse> postEquipmentRequest({
  required DepartmentsModel departmentObject,
  required BusinessUnitModel businessUnitObject,
  required EquipmentsLocationModel locationObject,
  required String userHrCode,
  required List<SelectedEquipmentsModel> selectedItem,
  String? comment,
    required FilePickerResult fileResult,
    required String extension,
  }) async {
    var masterDataPost = {
      "requestNo": 0,
      "serviceId": RequestServiceID.equipmentServiceID,
      "departmentId": businessUnitObject.departmentId,
      "projectId": '',
      "locationId": locationObject.projectId.toString(),
      "requestHrCode": userHrCode,
      "date": DateTime.now().toString(),
      "comments": comment ?? "No Comment",
      "newComer": true,
      "approvalPathId": 0,
      "status": 0,
      "nplusEmail": "",
      "closedDate": DateTime.now().toString(),
      "reRequestCode": 0
    };

    var value = await GeneralDio.postMasterEquipmentsRequest(masterDataPost);
    if(value.toString().isNotEmpty) {
      final json = await jsonDecode(value.toString());
      final RequestResponse response = RequestResponse.fromJson(json);

      var requestNo = response.requestNo ?? "";
      if (requestNo.isNotEmpty) {
        if (fileResult.isSinglePick) {
          await GeneralDio.uploadEquipmentImage(
              fileResult, requestNo, extension)
              .whenComplete(
                  () => EasyLoading.showSuccess('File uploaded successfully'))
              .catchError((err) {
            EasyLoading.showError('File failed');
            throw err;
          });
        }
        if (response.id == 1) {
          await FirebaseProvider(userData ?? MainUserData.empty)
              .addSubmitFirebaseNotification(
              response.requestNo.toString(),
              GlobalConstants.requestCategoryEquipment, "Submit");
        }
        for (int i = 0; i < selectedItem.length; i++) {
          int type = 1;
          switch (selectedItem[i].requestFor) {
            case 'New Hire':
              type = 1;
              break;
            case 'Replacement / New Item':
              type = 2;
              break;
            case 'Training':
              type = 3;
              break;
            case 'Mobilization':
              type = 4;
              break;
          }
          Map<String, dynamic> detailedDataPost = {
            "requestNo": int.parse(value.data['requestNo']),
            "hardWareItemId":
            selectedItem[i].selectedItem!.hardWareItemId.toString(),
            "ownerHrCode": selectedItem[i].selectedContact!.userHrCode
                .toString(),
            "type": type,
            "qty": selectedItem[i].quantity,
            "chk": true,
            "estimatePrice": 0,
            "approved": true,
            "rejectedHrCode": ""
          };
          await GeneralDio.postDetailEquipmentsRequest(detailedDataPost)
              .catchError((e) {
            // return response;
            // EasyLoading.showError('Something went wrong');
            throw e;
          });
        }
        return response;
      }
      else {
        return RequestResponse.empty;
      }
    }else {
      return RequestResponse.empty;
    }
    // await GeneralDio.postMasterEquipmentsRequest(masterDataPost).then((value) async {
    //
    //
    // }).catchError((e) {
    //   // return RequestResponse.empty;
    //   // EasyLoading.showError('Something went wrong');
    //   throw e;
    // });

  }

  Future<VacationRequestData> getVacationRequestData(
      String requestNo, String requesterHRCode) async {
    final http.Response rawRequestData =
        await requestDataProviders.getVacationRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final VacationRequestData response = VacationRequestData.fromJson(json[0]);

    return response;
  }

  Future<EquipmentsRequestedModel> getEquipmentData(
      String requestNo, String requesterHRCode) async {
    final http.Response rawRequestData = await requestDataProviders
        .getEquipmentRequestData(requesterHRCode, requestNo);

    final json = await jsonDecode(rawRequestData.body);
    final EquipmentsRequestedModel response =
        EquipmentsRequestedModel.fromJson(json);

    return response;
  }

  Future<BusinessMissionRequestData> getBusinessMissionRequestData(
      String requestNo, String requesterHRCode) async {
    final http.Response rawRequestData =
        await requestDataProviders.getBusinessMissionRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final BusinessMissionRequestData response =
        BusinessMissionRequestData.fromJson(json[0]);

    return response;
  }

  Future<PermissionRequestData> getPermissionRequestData(
      String requestNo, String requesterHRCode) async {
    final http.Response rawRequestData =
        await requestDataProviders.getPermissionRequestData(
            requesterHRCode.isNotEmpty
                ? requesterHRCode
                : userData?.user?.userHRCode ?? "",
            requestNo);
    final json = await jsonDecode(rawRequestData.body);
    final PermissionRequestData response =
        PermissionRequestData.fromJson(json[0]);
    return response;
  }

  Future<ResponseTakeAction> postTakeActionRequest(
      {required ActionValueStatus valueStatus,
        required String serviceID,
        required String serviceName,
        required String requestNo,
        required String requesterHRCode,
        required String requesterEmail,
        required String actionComment}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": serviceID,
      "reqno": int.parse(requestNo),
      "Approve": valueStatus == ActionValueStatus.accept ? 1 : 2,
      "requesterhrcode": requesterHRCode,
      "mangerHrCode": userData?.user?.userHRCode ?? "0",
      "comment": actionComment
    });
    final http.Response rawResponse =
    await requestDataProviders.postTakeActionOnRequest(bodyString);
    final json = await jsonDecode(rawResponse.body);
    final ResponseTakeAction response = ResponseTakeAction.fromJson(json);
    final result = response.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addTakeActionFirebaseNotification(requesterEmail,
          response.requestNo.toString(), serviceName,
          valueStatus == ActionValueStatus.accept ? "Accept" : "Reject");
    }

    return response;
  }

  Future<ResponseTakeAction> postEquipmentTakeActionRequest({
    required ActionValueStatus valueStatus,
    required String serviceID,
    required String requestNo,
    required String requesterHRCode,
    required String actionComment,
    required String requesterEmail,
    required String serviceName,
  }) async {
    dynamic nextObject;
    if(valueStatus == ActionValueStatus.accept){
      await GeneralDio.getNextStepWorkFlow(
              serviceId: serviceID,
              userHrCode: requesterHRCode,
              reqNo: int.parse(requestNo))
          .then((value) {
            nextObject = value.data;



          });
    }

    var bodyString = jsonEncode(<String, dynamic>{
      "serviceId": serviceID,
      "reqno": int.parse(requestNo),
      "Approve": valueStatus == ActionValueStatus.accept ? 1 : 2,
      "requesterhrcode": requesterHRCode,
      "mangerHrCode": userData?.user?.userHRCode ?? "0",
      "comment": actionComment,
      "nextStep": nextObject ?? [],
    });
    final http.Response rawResponse =
        await requestDataProviders.postTakeEquipmentActionOnRequest(bodyString);
    final json = await jsonDecode(rawResponse.body);
    final ResponseTakeAction response = ResponseTakeAction.fromJson(json);
    List<NextStepModel> nextStepList = List<NextStepModel>.from(
        nextObject.map((model) => NextStepModel.fromJson(model)));
    final result = response.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      if(valueStatus == ActionValueStatus.accept){
        for(int i = 0; i < nextStepList.length;i++){
          var nextStepUserHRCode = nextStepList[i].userHRCode ?? "";
          var nextStepContact =await GetEmployeeRepository().getEmployeeData(nextStepUserHRCode);
          await FirebaseProvider(userData ?? MainUserData.empty)
              .addEquipmentTakeActionFirebaseNotification(nextStepContact.email ?? "",requesterEmail,
              response.requestNo.toString(), serviceName,
              "Submit");
        }
      }
      await FirebaseProvider(userData ?? MainUserData.empty)
          .addTakeActionFirebaseNotification(requesterEmail,
          response.requestNo.toString(), serviceName,
          valueStatus == ActionValueStatus.accept ? "Accept" : "Reject");
    }



    return response;
  }
}
