
import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/itemscatalog_dataptovider/itemscatalog_getall_dataproviders.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_attachs_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_getall_model.dart';
import 'package:http/http.dart' as http;

class ItemsCatalogGetAllRepository {

  final ItemsCatalogGetAllDataProvider itemsCatalogGetAllDataProvider = ItemsCatalogGetAllDataProvider();
  MainUserData? userData;
  static final ItemsCatalogGetAllRepository _inst = ItemsCatalogGetAllRepository._internal();
  ItemsCatalogGetAllRepository._internal();

  factory ItemsCatalogGetAllRepository(MainUserData userData) {
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

}