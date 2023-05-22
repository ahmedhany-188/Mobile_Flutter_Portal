import 'dart:convert';

import 'package:hassanallamportalflutter/data/models/payslip_models/payslip_response_model.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/payslip_data_provider/payslip_data_provider.dart';
import 'package:http/http.dart' as http;

class PayslipRepository {
  final PayslipDataProvider payslipDataProvider = PayslipDataProvider();

  MainUserData? userData;


  static final PayslipRepository _inst = PayslipRepository._internal();

  PayslipRepository._internal();

  factory PayslipRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  Future<String> getPayslipPdf(String email,String password) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawWeather = await payslipDataProvider.getPayslipPdfLink(header,email, password);
    final pdfLink = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    return pdfLink;
  }

  Future<String> getPayslipAvailableMonths(String email,String password) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawWeather = await payslipDataProvider.getPayslipAvailableMonths(header,email, password);
    final monthsString = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    return monthsString;
  }

  Future<PayslipResponseModel> sentResetPassword(hrCode, email, password, verificationCode) async{

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawRequestData = await payslipDataProvider.getPayslipResetPassword(header,hrCode,email, password, verificationCode);
    final json = await jsonDecode(rawRequestData.body);
    final PayslipResponseModel payslipResponse = PayslipResponseModel.fromJson(json);
    return payslipResponse;
  }

  Future<PayslipResponseModel> sentVerificationPassword(hrCode) async{

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawRequestData = await payslipDataProvider.getPayslipVerificationPassword(header,hrCode);
    final json = await jsonDecode(rawRequestData.body);
    final PayslipResponseModel payslipResponse = PayslipResponseModel.fromJson(json);
    return payslipResponse;
  }

  Future<String> getPayslipByMonth(String email,String password, String month) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawWeather = await payslipDataProvider.getPayslipByMonth(header,email, password, month);
    final pdfLink = rawWeather.body;
    // final WeatherData weather = WeatherData.fromJson(json);
    return pdfLink;
  }

  Future<PayslipResponseModel> getAccountValidation(String hrCode) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawRequestData = await payslipDataProvider.getAccountValidation(header,hrCode);
    final json = await jsonDecode(rawRequestData.body);
    final PayslipResponseModel payslipResponse = PayslipResponseModel.fromJson(json);
    return payslipResponse;
  }

}