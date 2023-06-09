import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_cart_model.dart';

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

  Future<Response> getItemCatalogSearch(String searchText) async {
    // String url =
    //     'InformationTechnology-ItemCatalog/ItmCat_Items/Search?text=$searchText';

    String url = 'InformationTechnology-ItemCatalog/ItmCat_Items/GetItemsSearch?searchValue=$searchText';

    print("the url is "+url);
    // if (categoryId == null) {
    //   url =
    //       'InformationTechnology-ItemCatalog/ItmCat_Items/Search?text=$searchText';
    // } else {
    //   url =
    //       'InformationTechnology-ItemCatalog/ItmCat_Items/Search?cateory_ID=$categoryId&text=$searchText';
    // }
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getItemCatalogFavorite(String hrCode) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Favorites/GetAll?hrCode=$hrCode';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }
  Future<Response> getItemCatalogCart(String hrCode) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/GetCart?HRCode=$hrCode';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getItemCatalogAllData(
    String itemCode,
  ) async {
    String url =
        'https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Items/GetbyItemCodeOrSystemItemCode?itemCode=$itemCode';
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
        'portal/GetUserApps?HRCode=${userData?.user?.userHRCode}&Email=${userData?.user?.email}';
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

  Future<Response> postItemCatalogFavorite(dynamic dataToPost) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Favorites/Post';
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

  Future<Response> postItemCatalogCart(dynamic dataToPost) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/AddToCart';
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

  Future<Response> putCartOrder(List<CartModelData> dataToPost) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/UpdateOrderID';
    return await dio!
        .put(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json-patch+json",
          'Authorization': 'Bearer ${userData?.user?.token}',
        }),
        data: dataToPost)
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> getItemCatalogById(int id) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Items/GetByID?ID=$id';
    return await dio!
        .get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json-patch+json",
          'Authorization': 'Bearer ${userData?.user?.token}',
        }),
        )
        .catchError((err) {
      throw err;
    });
  }


  Future<Response> getOrderHistory(String hrCode) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/OrderHistory?HRCode=$hrCode';
    return await dio!
        .get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json-patch+json",
          'Authorization': 'Bearer ${userData?.user?.token}',
        },
        ),).catchError((err) {
      throw err;
    });
  }

  Future<Response> getOrderData(String hrCode,orderCode) async {
    String url =
    'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/OrderData?OrderId=$orderCode&HRCode=$hrCode';
    return await dio!
        .get(url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json-patch+json",
        'Authorization': 'Bearer ${userData?.user?.token}',
      },
      ),).catchError((err) {
      throw err;
    });
  }


  Future<Response> removeItemCatalogFavorite(int itemId) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Favorites/RemoveItem?hrCode=${userData?.user?.userHRCode}&itemID=$itemId';
    return await dio!
        .delete(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer ${userData?.user?.token}',
      }),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> removeItemCatalogCart(int itemId) async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/DeleteItemCart?ID=$itemId';
    // 'InformationTechnology-ItemCatalog/ItmCat_Users_Cart/DeleteItemCart?HRCode=${userData?.user?.userHRCode}&ItemCode=$itemId';
    return await dio!
        .delete(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer ${userData?.user?.token}',
      }),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> removeAllFavorite() async {
    String url =
        'InformationTechnology-ItemCatalog/ItmCat_Users_Favorites/RemoveAll?hrCode=${userData?.user?.userHRCode}';
    return await dio!
        .delete(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer ${userData?.user?.token}',
      }),
    )
        .catchError((err) {
      throw err;
    });
  }

  Future<Response> removeAllCart() async {
    String url =
        'https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Users_Cart/DeleteAllCarts?HRCode=${userData?.user?.userHRCode}';
    return await dio!
        .delete(
      url,
      options: Options(headers: {
        'Authorization': 'Bearer ${userData?.user?.token}',
      }),
    )
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
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);

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
        .catchError((onError) {
      EasyLoading.showError('Something went wrong');
      throw onError;
    });
  }
}
