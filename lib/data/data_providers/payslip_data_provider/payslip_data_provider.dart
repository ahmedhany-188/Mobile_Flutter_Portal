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

}