import 'package:hassanallamportalflutter/data/data_providers/economy_news_data_provider/economy_news_data_provider.dart';
import 'package:http/http.dart' as http;


class EconomyNewRepository {


  final EconomyNewsDataProvider economyNewsDataProvider = EconomyNewsDataProvider();


  Future<http.Response> getEconomyNewData() async {

    final http.Response rawWeather = await economyNewsDataProvider.getEconomyNews();
    // final attendanceData = rawWeather.body.toString();
    // final WeatherData weather = WeatherData.fromJson(json);
    // return attendanceData;
    return rawWeather;
  }

}