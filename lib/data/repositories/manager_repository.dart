
import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:authentication_repository/src/authentication_provider.dart';

class GetManagerRepository {
  final AuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<EmployeeData> getManagerData(String hrCode) async {
    final http.Response rawAttendance = await authenticationProvider
        .getEmployeeData(hrCode);
    final json = await jsonDecode(rawAttendance.body);
   EmployeeData employeeData = EmployeeData.fromJson(json[0]);
    return employeeData;

  }

}