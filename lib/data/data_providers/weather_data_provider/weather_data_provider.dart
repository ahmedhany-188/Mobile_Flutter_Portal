import 'package:http/http.dart' as http;

// https://api.openweathermap.org/data/2.5/weather?q=Cairo&appid=de1f4c4a057ebe9ba56338bb4abef939&units=metric

class WeatherDataProvider {
  final String apiKey = "de1f4c4a057ebe9ba56338bb4abef939";

  Future<http.Response> getRawWeatherData() async {
    http.Response rawWeatherData = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=Cairo&appid=$apiKey&units=metric"),
    );
    print(rawWeatherData.body);
    return rawWeatherData;
  }
}