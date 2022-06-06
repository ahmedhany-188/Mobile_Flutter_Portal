import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:http/http.dart' as http;

class BusinessCardRequestDataProvider {


  BusinessCardFormModel _businessCardFormModel;
  MainUserData _mainUserData;

  BusinessCardRequestDataProvider(this._businessCardFormModel,
      this._mainUserData);


  Future<http.Response> getBusinessCardRequest() async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddBusinessCard"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, dynamic>{

        // "requestNo": 0,
        "serviceId": "HAH-HR-FRM-06",
        "requestHrCode": _mainUserData.employeeData!.userHrCode,
        "ownerHrCode": _mainUserData.employeeData!.userHrCode,
        "date": _businessCardFormModel.requestDate,
        // "newComer": true,
        // "approvalPathId": 0,
        // "status": 0,
        "comments": _businessCardFormModel.employeeComeents,
        // "nplusEmail": "string",
        // "closedDate": "2022-06-01T16:13:53.995Z",
        // "cardNo": "string",
        // "costCenter": "string",
        "cardName": _businessCardFormModel.employeeNameCard,
        "faxNo": _businessCardFormModel.faxNo,
        "extNo": _businessCardFormModel.employeeExt,
        "mobileNo": _businessCardFormModel.employeeMobil
        // "projectId": "string"

      }),

    );
  }

}