import 'dart:convert';
import 'package:hassanallamportalflutter/data/data_providers/weather_data_provider/weather_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {

  final WeatherDataProvider weatherDataProvider = WeatherDataProvider();


  Future<WeatherData> getWeather() async {

    final http.Response rawWeather =
    await weatherDataProvider.getRawWeatherData();
    final json = await jsonDecode(rawWeather.body);
    final WeatherData weather = WeatherData.fromJson(json);
    return weather;
  }

}