import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:http/http.dart' as http;

class MedicalRepository {
  final MedicalRequestDataProvider medicalRequestDataProvider = MedicalRequestDataProvider();

  Future<http.Response> getMedicalData(RequestMedicalBenefit requestMedicalBenefit) async {

    String bodyString=jsonEncode(<String, String>{
      "id": "1",
      "hrCode": requestMedicalBenefit.hrCode,
      "serviceDate": requestMedicalBenefit.requestedDate,
      "beneficiaryname": requestMedicalBenefit.patientName,
      "servicetype": requestMedicalBenefit.serviceType,
      "labType": requestMedicalBenefit.lapType,
      "inDate": requestMedicalBenefit.requestedDate
    });

    final http.Response rawWeather = await medicalRequestDataProvider.getMedicalRequestMessage(bodyString);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    return rawWeather;
  }

}