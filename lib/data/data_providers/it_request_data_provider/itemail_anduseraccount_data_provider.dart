import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:http/http.dart' as http;


class ItUserAccountRequestDataProvider {


  EmailUserFormModel emailUserFormModel;

  MainUserData mainUserData;


  ItUserAccountRequestDataProvider(this.emailUserFormModel,
      this.mainUserData);


  Future<http.Response> getuserAccountAccessRequest() async {



    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddITUserAccount"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{

        // "RequestNo": 0,
        "ServiceId": "HAH-IT-FRM-04",
        "ProjectId": null,
        "RequestHrCode": mainUserData.user!.userHRCode,
        "Date": "${emailUserFormModel.requestDate!}T10:43:37.994Z",
        "OwnerHrCode": mainUserData.user!.userHRCode,
        "OwnerFullName": mainUserData.employeeData!.name,
        "OwnerTitle": mainUserData.employeeData!.titleName,
        "OwnerLocation": mainUserData.employeeData!.companyName,
        "OwnerMobile": emailUserFormModel.userMobile,
        "OwnerEmailDisabled": mainUserData.user!.email,
        "FilePdf": null,
        "Comments": null,
        "Status": 0,
        "RejectedHrCode": null,
        "ClosedDate": null,
        "ReRequestCode": 0,
        "ReqType": emailUserFormModel.requestType,
        "AnswerEmail": "string",
        "StartDate": null,
        "EndDate": null,
        "IsPermanent": null,
        "USBException": null,
        "VPNAccount": null,
        "IPPhone": null,
        "LocalAdmin": null,
        "LoginUserAccount": null,
        "EmailAccount": emailUserFormModel.accountType,

      }),
    );
  }


}