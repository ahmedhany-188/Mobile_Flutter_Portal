import 'package:dio/dio.dart';

class GetDirectionProvider {
  static Dio? dio;

  static getDirectionInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/Lookup/',
        // receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getGetDirectionData(
      {String url = 'GetLocation'}) async {
    return await dio!.get(
      url,
    );
  }
}
