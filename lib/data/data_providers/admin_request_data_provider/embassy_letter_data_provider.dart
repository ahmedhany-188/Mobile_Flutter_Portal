import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';

class EmbassyLetterRequestDataProvider {

  EmbassyLetterFormModel embassyLetterFormModel;
  MainUserData user;

  EmbassyLetterRequestDataProvider(this.embassyLetterFormModel, this.user);


  Future<http.Response> getEmbassyLetterRequest() async {
    return http.post(
      Uri.parse("https://api.hassanallam.com/api/SelfService/AddEmbassyLetter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {

          // "RequestNo": 0,
          "ServiceId": "HAH-HR-FRM-07",
          "RequestHrCode": user.employeeData!.userHrCode,
          "OwnerHrCode": user.employeeData!.userHrCode,
          "Date": "${embassyLetterFormModel.requestDate!}T11:20:14.519Z",
          // "NewComer": true,
          // "ApprovalPathId": 0,
          // "Status": 0,
          "Comments": embassyLetterFormModel.comments,
          // "NplusEmail": "string",
          // "ClosedDate": "2022-06-02T11:20:14.519Z",
          "DateFrom": "${embassyLetterFormModel.dateFrom!}T11:20:14.519Z",
          "DateTo": "${embassyLetterFormModel.dateTo!}T11:20:14.519Z",
          "Purpose": embassyLetterFormModel.purpose,
          "EmbassyId": embassyLetterFormModel.embassy,
          "PassportNo": embassyLetterFormModel.passportNo,
          "AddSalary": embassyLetterFormModel.addSalary,
          // "SocialInsuranceNumber": "string",
          // "ProjectId": "string"

      }
      ),
    );
  }

}