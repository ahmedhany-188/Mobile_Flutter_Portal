import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:http/http.dart' as http;

class BusinessCardRequestDataProvider {


  BusinessCardFormModel businessCardFormModel;
  MainUserData mainUserData;

  BusinessCardRequestDataProvider(this.businessCardFormModel,
      this.mainUserData);


  Future<http.Response> getBusinessCardRequest() async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddBusinessCard"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, dynamic>{
        "serviceId": "HAH-HR-FRM-06",
        "requestHrCode": mainUserData.employeeData!.userHrCode,
        "ownerHrCode": mainUserData.employeeData!.userHrCode,
        "date": businessCardFormModel.requestDate,
        "comments": businessCardFormModel.employeeComments,
        "cardName": businessCardFormModel.employeeNameCard,
        "faxNo": businessCardFormModel.faxNo,
        "extNo": businessCardFormModel.employeeExt,
        "mobileNo": businessCardFormModel.employeeMobil
      }),
    );
  }

}