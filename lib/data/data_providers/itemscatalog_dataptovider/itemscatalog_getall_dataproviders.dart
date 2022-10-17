import 'package:http/http.dart' as http;

class ItemsCatalogGetAllDataProvider{

  Future<http.Response> getItemsCatalogList(Map<String, String> header) async {
    http.Response rawItemsCatalogData = await http.get(
      Uri.parse(
          "https://api.hassanallam.com/api/InformationTechnology-ItemCatalog/ItmCat_Category/Get-catgeory-tree"),
      headers: header,
    );
    return rawItemsCatalogData;
  }

}