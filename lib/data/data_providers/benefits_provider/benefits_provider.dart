import 'package:dio/dio.dart';

class BenefitsProvider {
  static Dio? benefitsDio;

  static benefitsInit() {
    benefitsDio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/Portal/',
        // receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getBenefitsData({String url = 'GetBenefits'}) async {
    return await benefitsDio!.get(
      url,
    );
  }
}
