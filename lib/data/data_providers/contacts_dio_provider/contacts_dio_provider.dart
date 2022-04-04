import 'package:dio/dio.dart';

class ContactsDioProvider {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/portal/UserData/',
        // receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response> getContactListData({String url = 'GetContactList'}) async {
    return await dio!.get(
      url,
    );
  }

}
