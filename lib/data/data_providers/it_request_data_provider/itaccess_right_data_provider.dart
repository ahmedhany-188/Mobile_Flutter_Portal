import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:http/http.dart' as http;

class ItAccessccountRequestDataProvide {

  AccessRightModel _accessRightModel;
  MainUserData _mainUserData;

  ItAccessccountRequestDataProvide(this._accessRightModel,
      this._mainUserData);

  Future<http.Response> getAccessAccountAccessRequest() async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITAccessRight"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        // "RequestNo": null,
        "ServiceId": "HAH-IT-FRM-07",
        "ProjectId": null,
        "RequestHrCode": _mainUserData.employeeData!.userHrCode,
        "Date": _accessRightModel.requestDate+"T10:43:37.994Z",
        "OwnerHrCode": null,
        "OwnerFullName": null,
        "OwnerTitle": null,
        "OwnerLocation": null,
        "OwnerMobile": null,
        "OwnerEmailDisabled": null,
        "FilePdf": (_accessRightModel.filePDF != null)? _accessRightModel.filePDF : null,
        "Comments": _accessRightModel.comments,
        "Status": null,
        "RejectedHrCode": null,
        "ClosedDate": null,
        "ReRequestCode": null,
        "ReqType": _accessRightModel.requestType,
        "AnswerEmail": null,
        "StartDate": _accessRightModel.fromDate,
        "EndDate": _accessRightModel.toDate,
        "IsPermanent": _accessRightModel.permanent,
        "USBException": (_accessRightModel.items.contains("USB Exception") ? true :false),
        "VPNAccount": (_accessRightModel.items.contains("VPN Account") ? true :false),
        "IPPhone": (_accessRightModel.items.contains("IP Phone") ? true :false),
        "LocalAdmin": (_accessRightModel.items.contains("Local Admin") ? true :false),
        "LoginUserAccount":null,
        "EmailAccount": null,
        // "TwebwfItrequestAccessRightD": [
        //   {
        //     "Id": 0,
        //     "RequestNo": 0,
        //     "AccessId": 0,
        //     "Access": {
        //       "AccessId": 0,
        //       "AccessName": "string",
        //       "IsUserAccount": true,
        //       "TwebwfItrequestAccessRightD": [
        //         null
        //       ]
        //     }
        //   }
        // ]
      }
      ),
    );
  }


}