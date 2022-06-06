import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:http/http.dart' as http;


class ItUserAccountRequestDataProvider {


  EmailUserFormModel _emailUserFormModel;

  MainUserData _mainUserData;


  ItUserAccountRequestDataProvider(this._emailUserFormModel,
      this._mainUserData);


  Future<http.Response> getuserAccountAccessRequest() async {

    print("-----------"+_emailUserFormModel.requestDate.toString());



    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITUserAccount"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{

        // "RequestNo": 0,
        "ServiceId": "HAH-IT-FRM-04",
        "ProjectId": null,
        "RequestHrCode": _mainUserData.user!.userHRCode,
        "Date": _emailUserFormModel.requestDate!+"T10:43:37.994Z",
        "OwnerHrCode": _mainUserData.user!.userHRCode,
        "OwnerFullName": _mainUserData.employeeData!.name,
        "OwnerTitle": _mainUserData.employeeData!.titleName,
        "OwnerLocation": _mainUserData.employeeData!.companyName,
        "OwnerMobile": _emailUserFormModel.userMobile,
        "OwnerEmailDisabled": _mainUserData.user!.email,
        "FilePdf": null,
        "Comments": null,
        "Status": 0,
        "RejectedHrCode": null,
        "ClosedDate": null,
        "ReRequestCode": 0,
        "ReqType": _emailUserFormModel.requestType,
        "AnswerEmail": "string",
        "StartDate": null,
        "EndDate": null,
        "IsPermanent": null,
        "USBException": null,
        "VPNAccount": null,
        "IPPhone": null,
        "LocalAdmin": null,
        "LoginUserAccount": null,
        "EmailAccount": _emailUserFormModel.accountType,
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
      }),
    );
  }


}