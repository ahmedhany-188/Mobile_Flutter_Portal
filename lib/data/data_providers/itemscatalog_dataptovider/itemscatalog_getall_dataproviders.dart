import 'package:flutter/foundation.dart';
import 'package:hassanallamportalflutter/data/data_providers/requests_data_providers/request_data_providers.dart';
import 'package:http/http.dart' as http;

class ItemsCatalogGetAllDataProvider {

  Future<http.Response> getItemsCatalogList(Map<String, String> header) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Category/Get-catgeory-tree"),
      headers: header,
    );
    return rawItemsCatalogData;
  }

  Future<http.Response> getRequestsCatalogList(Map<String, String> header,String hrCode) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/GetMyRequests?HRCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));

    return rawItemsCatalogData;
  }

  Future<http.Response> getRespondRequestsCatalogList(Map<String, String> header,int groupNumber) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/GetRequestHistory?groupID=$groupNumber"),
      headers: header,
    ).timeout(const Duration(seconds: 10));

    return rawItemsCatalogData;
  }

  Future<http.Response> getCatalogWorkFlowList(Map<String, String> header,String requestID) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/GetItemWorkflowTrackCycle?requestID=$requestID"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    return rawItemsCatalogData;
  }

  Future<http.Response> getRespondGetHrData(Map<String, String> header,String hrCode) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Admin/getByHrCode?hrCode=$hrCode"),
      headers: header,
    ).timeout(const Duration(seconds: 10));
    return rawItemsCatalogData;
  }

  Future<http.Response> getItemsCatalogAttachList(Map<String, String> header) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Category/GetAll"),
      headers: header,

    );
    return rawItemsCatalogData;
  }

  Future<http.Response> getItemsCatalogListDataProvider(Map<String, String> header, int id) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Items/GetByCategory?ID=$id"), headers: header,
    );
    return rawItemsCatalogData;
  }


  Future<http.Response> postNewRequestCatalogDataProvider(Map<String, String> header, String bodyString) async {
    http.Response rawItemsCatalogData = await http.post(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/Post"),
      headers: header,
      body: bodyString,
    ).timeout(const Duration(seconds: 10));

    if (kDebugMode) {
      print(rawItemsCatalogData.body);
    }
    if(rawItemsCatalogData.statusCode == 200){
      return rawItemsCatalogData;
    }else{
      throw RequestFailureApi.fromCode(rawItemsCatalogData.statusCode);
    }
  }

  Future<http.Response> postNewRequestImageCatalogDataProvider(header, bodyString,imageFile) async {
    http.Response rawItemsCatalogData = await http.post(
      Uri.parse("https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Item_Request/UploadAttach"),
      headers: header,
      body: bodyString,
    ).timeout(const Duration(seconds: 10));

    if (kDebugMode) {
      print(rawItemsCatalogData.body);
    }
    if(rawItemsCatalogData.statusCode == 200){
      return rawItemsCatalogData;
    }else{
      throw RequestFailureApi.fromCode(rawItemsCatalogData.statusCode);
    }
  }

}