

import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/employee_appraisal_data_provider/employee_appraisal_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:http/http.dart' as http;

class EmployeeAppraisalRepository {


  final EmployeeAppraisaleDataProvider employeeAppraisalDataProvider = EmployeeAppraisaleDataProvider();

  Future<EmployeeAppraisalModel> getAppraisalData(String hrCode) async {
    final http.Response rawAppraisal= await employeeAppraisalDataProvider.getEmployeeApraisalList(hrCode);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    final json = await jsonDecode(rawAppraisal.body);
    EmployeeAppraisalModel employeeAppraisalModel=EmployeeAppraisalModel.fromJson(json);
    return employeeAppraisalModel;
  }

}