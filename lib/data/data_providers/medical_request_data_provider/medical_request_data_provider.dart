import 'dart:convert';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:http/http.dart' as http;

class MedicalRequestDataProvider {

  RequestMedicalBenefit requestMedicalBenefit;

  MedicalRequestDataProvider(this.requestMedicalBenefit);

  Future<http.Response> getMedicalRequestMessage() async {
    return http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddMedicalRequest"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": "1",
        "hrCode": requestMedicalBenefit.hrCode,
        "serviceDate": requestMedicalBenefit.requestedDate,
        "beneficiaryname": requestMedicalBenefit.patientName,
        "servicetype": requestMedicalBenefit.serviceType,
        "labType": requestMedicalBenefit.lapType,
        "inDate": requestMedicalBenefit.requestedDate
      }),
    );
  }
}