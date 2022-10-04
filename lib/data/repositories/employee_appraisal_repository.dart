

import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/employee_appraisal_data_provider/employee_appraisal_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:http/http.dart' as http;

class EmployeeAppraisalRepository {


  final EmployeeAppraisaleDataProvider employeeAppraisalDataProvider = EmployeeAppraisaleDataProvider();

  MainUserData? userData;


  static final EmployeeAppraisalRepository _inst = EmployeeAppraisalRepository._internal();

  EmployeeAppraisalRepository._internal();

  factory EmployeeAppraisalRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  Future<EmployeeAppraisalModel> getAppraisalData(String hrCode) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawAppraisal= await employeeAppraisalDataProvider.getEmployeeApraisalList(header,hrCode);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    final json = await jsonDecode(rawAppraisal.body);
    EmployeeAppraisalModel employeeAppraisalModel=EmployeeAppraisalModel.fromJson(json);
    return employeeAppraisalModel;
  }

}