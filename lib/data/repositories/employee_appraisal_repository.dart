

import 'package:hassanallamportalflutter/data/data_providers/employee_appraisal_data_provider/employee_appraisal_data_provider.dart';
import 'package:http/http.dart' as http;

class EmployeeAppraisalRepository {


  final EmployeeAppraisaleDataProvider employeeAppraisalDataProvider = EmployeeAppraisaleDataProvider();

  Future<http.Response> getAppraisalData(String hrCode) async {
    final http.Response rawWeather = await employeeAppraisalDataProvider.getEmployeeApraisalList(hrCode);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    return rawWeather;
  }

}