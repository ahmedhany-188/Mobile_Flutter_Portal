
import 'package:http/http.dart' as http;


class EconomyNewsDataProvider {

  String country = "eg";
  String type = "business";
  String apiKey = "addcbfb988014bcf9e6cc5ff8d7afbe1";

  EconomyNewsDataProvider();

  Future<http.Response> getEconomyNews() async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=$country&category=$type&apiKey=$apiKey"),
    );

    return rawAttendanceData;
  }

}



