import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class GeneralDio {
  static Dio? dio;
  MainUserData? userData;

  // GeneralDio(this.userData);

  static final GeneralDio _inst = GeneralDio._internal();

  GeneralDio._internal();

  factory GeneralDio(MainUserData userData) {
    _inst.userData = userData;
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userData.user?.token}',
        },
        // receiveDataWhenStatusError: true,
      ),
    );

    return _inst;
  }

  // static init() {
  //
  // }

  Future<Response> getContactListData(
      {String url = 'portal/UserData/GetContactList'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getBenefitsData({String url = 'Portal/GetBenefits'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getGetDirectionData(
      {String url = 'Lookup/GetLocation'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> subsidiariesData(
      {String url = 'portal/Subsidiaries/GetAll'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> newsData({String url = 'portal/News/GetAll'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> newsDataOld({int type = 2}) async {
    String url = 'Portal/GetNews?Type=$type';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getItemCatalogSearch(String searchText,{int? categoryId}) async{
    String url = 'InformationTechnology-ItemCatalog/ItmCat_Items/Search?cateory_ID=$categoryId&text=$searchText';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> latestNewsData(
      {String url = 'portal/News/GetLatest'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> appsData() async {
    String url =
        'portal/UserData/GetApplications?HRCode=${userData?.user?.userHRCode}';
    var userHRCode = userData?.user?.userHRCode ?? "";
    if (userHRCode.isNotEmpty) {
      return await dio!
          .get(
            url,
            options: Options(
              headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
            ),
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

  Future<Response> businessUnit() async {
    String url = 'Lookup/GetBusinessUnit';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> equipmentsLocation() async {
    String url = 'Lookup/GetLocation';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> equipmentsDepartment() async {
    String url = 'Portal/GetDepartments';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> getEquipmentsItems(String id) async {
    String url = 'Lookup/GetItemsByCategory?Cond=$id';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> getStatistics() async {
    String url =
        'SelfService/GetStatistics?HRCode=${userData?.user?.userHRCode}';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> getNextStepWorkFlow(
      {required String serviceId,
      required String userHrCode,
      required int reqNo}) async {
    String url =
        'SelfService/GetNextStepWorkFlow?ServiceID=$serviceId&RequestNo=$reqNo&HRCode=$userHrCode';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> getHistoryWorkFlow(
      {required String serviceId, required int reqNo}) async {
    String url =
        'SelfService/GetWorkflowhistory?requestno=$reqNo&ServiceID=$serviceId';

    return await dio!
        .get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> postMasterEquipmentsRequest(dynamic dataToPost) async {
    String url = 'SelfService/AddITEquipment_M';

    return await dio!
        .post(url,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json-patch+json",
              'Authorization': 'Bearer ${userData?.user?.token}',
            }),
            data: dataToPost)
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> postDetailEquipmentsRequest(dynamic dataToPost) async {
    String url = 'SelfService/AddITEquipment_D';

    return await dio!
        .post(url,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json-patch+json",
              'Authorization': 'Bearer ${userData?.user?.token}',
            }),
            data: dataToPost)
        .catchError((err) {
      throw err;
    });
  }

  // Future<Response> postEquipmentsRequestFile(dynamic dataToPost) async {
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

  Future<Response> uploadEquipmentImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'SelfService/UploadEquipmentFile';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(url,
            options: Options(
              headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
            ),
            data: formData)
        .catchError((onError) => throw onError);
  }

  Future<Response> uploadAccessRightImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'SelfService/UploadAccessRightFile';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(
          url,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
          ),
        )
        .catchError((onError) => throw onError);
  }

  Future<Response> uploadUserImage(
      FilePickerResult file, String fileName, String fileExtension) async {
    String url = 'Images/UploadImage';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.paths.single!,
          filename: "$fileName.$fileExtension"),
    });
    return await dio!
        .post(
          url,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
          ),
        )
        .catchError((onError) => throw onError);
  }
}
