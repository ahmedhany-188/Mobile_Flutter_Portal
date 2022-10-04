import 'package:http/http.dart' as http;

class MedicalRequestDataProvider {

  Future<http.Response> getMedicalRequestMessage(Map<String, String> header,String bodyString) async {
    return http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddMedicalRequest"
      ),
      headers: header,
      body: bodyString,

    );
  }
}