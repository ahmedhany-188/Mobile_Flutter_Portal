import 'dart:convert';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:http/http.dart' as http;

class MedicalRequestDataProvider {

  Future<http.Response> getMedicalRequestMessage(String bodyString) async {
    return http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddMedicalRequest"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,

    );
  }
}