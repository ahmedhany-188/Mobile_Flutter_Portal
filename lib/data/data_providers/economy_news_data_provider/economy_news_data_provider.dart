import 'dart:convert';

import 'package:http/http.dart' as http;


class EconomyNewsDataProvider {

  String country="eg";
  String type="business";
  String api_key="addcbfb988014bcf9e6cc5ff8d7afbe1";

  EconomyNewsDataProvider();

  Future<http.Response> getEconomyNewsList() async {
    http.Response rawAttendanceData = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=$country&category=$type&apiKey=$api_key"),
    );

    return rawAttendanceData;
  }

  }



