import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';

class GeneralDio {
  static Dio? dio;
  MainUserData userData;

  GeneralDio(this.userData);

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

  Future<Response> appsData() async {
    String url =
        'portal/UserData/GetApplications?HRCode=${userData.user!.userHRCode}';

    if (userData.user!.userHRCode!.isNotEmpty) {
      return await dio!
          .get(
            url,
          )
          .timeout(const Duration(minutes: 5))
          .catchError((err) {
        throw err;
      });
    } else {
      throw Exception;
      // return dio!.delete(url);
    }
  }

  static Future<Response> businessUnit() async {
    String url = 'Lookup/GetBusinessUnit';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> equipmentsLocation() async {
    String url = 'Lookup/GetLocation';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> equipmentsDepartment() async {
    String url = 'Portal/GetDepartments';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> postEquipmentsRequest() async {
    String url = 'SelfService/AddITEquipment_M';

    return await dio!.post(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> getEquipmentsItems(String id) async {
    String url = 'Lookup/GetItemsByCategory?Cond=$id';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }
}
