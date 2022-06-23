import 'package:http/http.dart' as http;

class PayslipDataProvider {
  Future<http.Response> getPayslipPdfLink(String email,String password) async {
    http.Response rawPayslipLink = await http.get(
      Uri.parse(
          "http://api.hassanallam.com:3415/api/Portal/Payslip?Email=$email&Password=$password"),
    );
    // print(rawPayslipLink.body);
    return rawPayslipLink;
  }
}