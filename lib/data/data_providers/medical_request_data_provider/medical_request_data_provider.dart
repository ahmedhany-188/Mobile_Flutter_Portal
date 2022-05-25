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
        "ID": "1",
        "HrCode": requestMedicalBenefit.hrCode,
        "ServiceDate": requestMedicalBenefit.requestedDate,
        "Beneficiaryname": requestMedicalBenefit.patientName,
        "Servicetype": requestMedicalBenefit.serviceType,
        "LabType": requestMedicalBenefit.lapType,
        "InDate": requestMedicalBenefit.requestedDate
      }),
    );
  }
}