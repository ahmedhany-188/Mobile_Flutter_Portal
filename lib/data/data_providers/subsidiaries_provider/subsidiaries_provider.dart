import 'package:dio/dio.dart';

class SubsidiariesProvider {
  static Dio? dio;

  static subsidiariesInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/portal/Subsidiaries/',
        // receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> subsidiariesData(
      {String url = 'GetAll'}) async {
    return await dio!.get(
      url,
    );
  }
}
