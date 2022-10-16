
import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/itemscatalog_dataptovider/itemscatalog_getall_dataproviders.dart';
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

  Future<ItemsCatalogModel> getItemsCatalog(String hrCode) async {
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawItemsCatalog= await itemsCatalogGetAllDataProvider.getItemsCatalogList(header);
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    final json = await jsonDecode(rawItemsCatalog.body);
    ItemsCatalogModel itemsCatalogModel=ItemsCatalogModel.fromJson(json);
    return itemsCatalogModel;
  }

}