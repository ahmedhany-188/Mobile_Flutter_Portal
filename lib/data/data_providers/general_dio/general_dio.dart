import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

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

  static Future<Response> getEquipmentsItems(String id) async {
    String url = 'Lookup/GetItemsByCategory?Cond=$id';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  Future<Response> getStatistics() async {
    String url =
        'SelfService/GetStatistics?HRCode=${userData.user!.userHRCode}';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> getNextStepWorkFlow(
      {required String serviceId,
      required String userHrCode,
      required int reqNo}) async {
    String url =
        'SelfService/GetNextStepWorkFlow?ServiceID=$serviceId&RequestNo=$reqNo&HRCode=$userHrCode';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> getHistoryWorkFlow(
      {required String serviceId, required int reqNo}) async {
    String url =
        'SelfService/GetWorkflowhistory?requestno=$reqNo&ServiceID=$serviceId';

    return await dio!.get(url).catchError((err) {
      throw err;
    });
  }

  static Future<Response> postMasterEquipmentsRequest(
      dynamic dataToPost) async {
    String url = 'SelfService/AddITEquipment_M';

    return await dio!
        .post(url,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json-patch+json",
            }),
            data: dataToPost)
        .catchError((err) {
      throw err;
    });
  }

  static Future<Response> postDetailEquipmentsRequest(
      dynamic dataToPost) async {
    String url = 'SelfService/AddITEquipment_D';

    return await dio!
        .post(url,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json-patch+json",
            }),
            data: dataToPost)
        .catchError((err) {
      throw err;
    });
  }

  // static Future<Response> postEquipmentsRequestFile(dynamic dataToPost) async {
  //   String url = 'SelfService/UploadEquipmentFile';
  //
  //   return await dio!
  //       .post(
  //     url,
  //     options: Options(headers: {
  //       HttpHeaders.contentTypeHeader: "multipart/form-data",
  //     }),
  //     data: dataToPost,
  //   )
  //       .catchError((err) {
  //     throw err;
  //   });
  // }

  static Future<Response> uploadEquipmentImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'SelfService/UploadEquipmentFile';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(url, data: formData)
        .catchError((onError) => throw onError);
  }

  static Future<Response> uploadAccessRightImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'SelfService/UploadAccessRightFile';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(url, data: formData)
        .catchError((onError) => throw onError);
  }

  static Future<Response> uploadUserImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'Images/UploadImage';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(url, data: formData)
        .catchError((onError) => throw onError);
  }
}
