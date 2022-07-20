import 'package:http/http.dart' as http;
import '../../../constants/url_links.dart';

class PayslipDataProvider {
  Future<http.Response> getPayslipPdfLink(String email,String password) async {
    http.Response rawPayslipLink = await http.get(
      Uri.parse(
          getPayslipLink(email,password)),
    );
    return rawPayslipLink;
  }
}