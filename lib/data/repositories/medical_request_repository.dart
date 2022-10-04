import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:http/http.dart' as http;

class MedicalRepository {
  final MedicalRequestDataProvider medicalRequestDataProvider = MedicalRequestDataProvider();


  MainUserData? userData;


  static final MedicalRepository _inst = MedicalRepository._internal();

  MedicalRepository._internal();

  factory MedicalRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

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

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };

    final http.Response rawWeather = await medicalRequestDataProvider.getMedicalRequestMessage(header,bodyString);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    return rawWeather;
  }

}