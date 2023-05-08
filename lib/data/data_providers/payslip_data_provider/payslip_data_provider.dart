import 'package:http/http.dart' as http;
import '../../../constants/url_links.dart';

class PayslipDataProvider {
  Future<http.Response> getPayslipPdfLink(Map<String, String> header,String email,String password) async {
    http.Response rawPayslipLink = await http.get(
      Uri.parse(
          getPayslipLink(email,password)),
      headers: header,
    );
    return rawPayslipLink;
  }

  Future<http.Response> getPayslipAvailableMonths(Map<String, String> header,String email,String password) async {
    http.Response rawPayslipMonths = await http.get(
      Uri.parse(
          getPayslipAvailableMonthsData(email,password)),
      headers: header,
    );
    return rawPayslipMonths;
  }

  Future<http.Response> getPayslipByMonth(Map<String, String> header,String email,String password, String month) async {
    http.Response rawPayslipLink = await http.get(
      Uri.parse(
          getPayslipByMonthsData(email,password,month)),
      headers: header,
    );
    return rawPayslipLink;
  }

  Future<http.Response> getPayslipResetPassword(Map<String, String> header,String password, String verificationCode) async {
    http.Response rawPayslipResetPassword = await http.get(
      Uri.parse(
          getPayslipResetPasswordLink(password,verificationCode)),
      headers: header,
    );
    return rawPayslipResetPassword;
  }

  Future<http.Response> getPayslipVerificationPassword(Map<String, String> header,String hrCode) async {
    http.Response rawPayslipVerificationPassword = await http.get(
      Uri.parse(
          getPayslipVerificationPasswordLink(hrCode)),
      headers: header,
    );
    return rawPayslipVerificationPassword;
  }

  Future<http.Response> getAccountValidation(Map<String, String> header,String hrCode) async {
    http.Response rawPayslipAccountValidation = await http.get(
      Uri.parse(
          getPayslipAccountValidation(hrCode)),
      headers: header,
    );
    return rawPayslipAccountValidation;
  }

}