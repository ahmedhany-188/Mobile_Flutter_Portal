
import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:hassanallamportalflutter/data/data_providers/itemscatalog_dataptovider/itemscatalog_getall_dataproviders.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_image_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_attachs_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_new_request_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_requestCatalog_reponse.dart';
import 'package:http/http.dart' as http;

class ItemsCatalogGetAllRepository {

  static Dio? dio;


  final ItemsCatalogGetAllDataProvider itemsCatalogGetAllDataProvider = ItemsCatalogGetAllDataProvider();
  MainUserData? userData;
  static final ItemsCatalogGetAllRepository _inst = ItemsCatalogGetAllRepository._internal();
  ItemsCatalogGetAllRepository._internal();

  factory ItemsCatalogGetAllRepository(MainUserData userData) {

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
    _inst.userData = userData;
    return _inst;
  }

  Future<ItemsCatalogCategory> getItemsCatalogTreeRepository( hrCode) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawItemsCatalog= await itemsCatalogGetAllDataProvider.getItemsCatalogList(header);
    final json = await jsonDecode(rawItemsCatalog.body);
    ItemsCatalogCategory itemsCatalogModel=ItemsCatalogCategory.fromJson(json);
    return itemsCatalogModel;
  }

  Future<itemCategoryAttachs> getItemsCatalogAttachTreeRepository( hrCode) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawItemsCatalog= await itemsCatalogGetAllDataProvider.getItemsCatalogAttachList(header);
    final json = await jsonDecode(rawItemsCatalog.body);
    itemCategoryAttachs itemsCatalogAttachModel=itemCategoryAttachs.fromJson(json);
    return itemsCatalogAttachModel;
  }

  Future<ItemCategoryGetAll> getItemsCatalogListData( hrCode,id) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawItemsCatalog= await itemsCatalogGetAllDataProvider.getItemsCatalogListDataProvider(header,id);
    final json = await jsonDecode(rawItemsCatalog.body);
    ItemCategoryGetAll itemCategoryGetAll=ItemCategoryGetAll.fromJson(json);
    return itemCategoryGetAll;
  }


  Future<NewRequestCatalogModelResponse> postNewRequestCatalog(NewRequestCatalogModel newRequestCatalogModel) async {

    var bodyString = jsonEncode(<String, dynamic>{
      "cat_ID": newRequestCatalogModel.catID,
      "item_Name": newRequestCatalogModel.itemName,
      "item_Desc": newRequestCatalogModel.itemDesc,
      "in_User":newRequestCatalogModel.inUser
    });

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawPermission =
    await itemsCatalogGetAllDataProvider.postNewRequestCatalogDataProvider(header, bodyString);
    final json = await jsonDecode(rawPermission.body);
    final NewRequestCatalogModelResponse response = NewRequestCatalogModelResponse.fromJson(json);

    return response;
  }


  Future<ItemsCatalogCategory> postNewRequestImageCatalog(ItemImageCatalogModel itemImageCatalogModel,String hrCode,int reqId) async {
    bool isMain = itemImageCatalogModel.isMain;
    String url= 'https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/UploadAttach?HRCode=$hrCode&Req_ID=$reqId&isMain=$isMain';
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(itemImageCatalogModel.image.paths.single!,
          filename: itemImageCatalogModel.image.names.single.toString()),
    });
    final result= (await dio!
        .post(url,
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    ).catchError((onError) => throw onError));

    final json = await jsonDecode(result.toString());
    final ItemsCatalogCategory response = ItemsCatalogCategory.fromJson(json);

    print("the finaaal "+response.data.toString());
    print("the finaaal "+response.error.toString());
    print("the finaaal "+response.code.toString());
    print("the finaaal "+response.message.toString());

    return response;
  }

}