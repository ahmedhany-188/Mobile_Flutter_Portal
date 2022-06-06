import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';

class EmbassyLetterRequestDataProvider {

  EmbassyLetterFormModel _embassyLetterFormModel;
  MainUserData user;

  EmbassyLetterRequestDataProvider(this._embassyLetterFormModel, this.user);


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
          "Date": _embassyLetterFormModel.requestDate!+"T11:20:14.519Z",
          // "NewComer": true,
          // "ApprovalPathId": 0,
          // "Status": 0,
          "Comments": _embassyLetterFormModel.comments,
          // "NplusEmail": "string",
          // "ClosedDate": "2022-06-02T11:20:14.519Z",
          "DateFrom": _embassyLetterFormModel.dateFrom!+"T11:20:14.519Z",
          "DateTo": _embassyLetterFormModel.dateTo!+"T11:20:14.519Z",
          "Purpose": _embassyLetterFormModel.purpose,
          "EmbassyId": _embassyLetterFormModel.embassy,
          "PassportNo": _embassyLetterFormModel.passportNo,
          "AddSalary": _embassyLetterFormModel.addSalary,
          // "SocialInsuranceNumber": "string",
          // "ProjectId": "string"

      }
      ),
    );
  }

}