import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/requests_data_providers/request_data_providers.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_duration_response.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_response.dart';
import 'package:http/http.dart' as http;

import '../../constants/request_service_id.dart';

class RequestRepository {
  final RequestDataProviders requestDataProviders = RequestDataProviders();

  Future<RequestResponse> postPermissionRequest(
      {required String hrCode, required String requestDate, required String comments,
        required String dateFromAmpm, required String dateTo, required int type,
        required String dateFrom, required String dateToAmpm, required String permissionDate}) async {
    var bodyString = jsonEncode(<String, dynamic>{
      "date": requestDate,
      "comments": comments,
      "dateFromAmpm": dateFromAmpm,
      "requestHrCode": hrCode,
      "dateTo": dateTo,
      "serviceId": RequestServiceID.PermissionServiceID,
      "type": type,
      "dateFrom": dateFrom,
      "dateToAmpm": dateToAmpm,
      "permissionDate": permissionDate,
    });
    final http.Response rawPermission = await requestDataProviders
        .postPermissionRequest(bodyString);
    final json = await jsonDecode(rawPermission.body);
    final RequestResponse response = RequestResponse.fromJson(json);
    return response;
  }
  Future<DurationResponse> getDurationVacation(int type,String dateFrom,String dateTo) async{
    final http.Response rawPermission = await requestDataProviders
        .getDurationVacation(type,dateFrom,dateTo);
    final json = await jsonDecode(rawPermission.body);
    final DurationResponse response = DurationResponse.fromJson(json);
    return response;
  }
}