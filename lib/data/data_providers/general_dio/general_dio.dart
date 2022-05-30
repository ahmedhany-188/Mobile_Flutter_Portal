import 'package:dio/dio.dart';

class GeneralDio {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/',
        // receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getContactListData(
      {String url = 'portal/UserData/GetContactList'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> getBenefitsData(
      {String url = 'Portal/GetBenefits'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> getGetDirectionData(
      {String url = 'Lookup/GetLocation'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> subsidiariesData(
      {String url = 'portal/Subsidiaries/GetAll'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> newsData({String url = 'portal/News/GetAll'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> latestNewsData(
      {String url = 'portal/News/GetLatest'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> appsData(String? hrCode) async {
    String url = 'portal/UserData/GetApplications?HRCode=$hrCode';

    if (hrCode!.isNotEmpty) {
      return await dio!
          .get(
            url,
          )
          .timeout(Duration(minutes:5))
          .catchError((err) {
        print(err);
      });
    } else {
      return dio!.delete(url);
    }
  }
}
