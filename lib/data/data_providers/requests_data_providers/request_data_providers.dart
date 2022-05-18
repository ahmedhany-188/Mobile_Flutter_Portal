import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/request_service_id.dart';

class RequestDataProviders {

  Future<http.Response> postPermissionRequest(String bodyString) async {
    http.Response permissionFeedbackRequest = await http.post(
      Uri.parse(
          "https://api.hassanallam.com/api/SelfService/AddPermission"
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyString,
    );
    print(permissionFeedbackRequest.body);
    return permissionFeedbackRequest;
  }
}