import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/weather_bloc/weather_bloc.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/weather_screen/weather_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );

      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
// ---->>>> Weather screen for getting weather data
      // case '/':
      //   return MaterialPageRoute(
      //       builder: (_) => MaterialApp(home: WeatherScreen(),));
      default:
        return null;
    }
  }
}