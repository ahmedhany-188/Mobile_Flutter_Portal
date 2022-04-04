import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/payslip_data_provider/payslip_data_provider.dart';
import 'package:http/http.dart' as http;

class PayslipRepository {
  final PayslipDataProvider payslipDataProvider = PayslipDataProvider();

  Future<String> getPayslipPdf(String email,String password) async {
    final http.Response rawWeather = await payslipDataProvider.getPayslipPdfLink(email, password);
    final pdfLink = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    return pdfLink;
  }
}