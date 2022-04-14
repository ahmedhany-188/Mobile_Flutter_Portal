import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contact_detail_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/splash_screen/splash_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (_) => HomeScreen(
      //       title: "Home Screen",
      //       color: Colors.blueAccent,
      //     ),
      //   );
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      // case '/second':
      //   return MaterialPageRoute(
      //     builder: (_) => SecondScreen(
      //       title: "Second Screen",
      //       color: Colors.redAccent,
      //     ),
      //   );
      // case '/third':
      //   return MaterialPageRoute(
      //     builder: (_) => ThirdScreen(
      //       title: "Thirst Screen",
      //       color: Colors.greenAccent,
      //     ),
      //   );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case AuthScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case TapsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const TapsScreen(),
        );
      case ContactDetailScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
         builder: (_) =>  ContactDetailScreen(selectedContactDataAsMap: args,),
        );
      case GetDirectionScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => GetDirectionScreen(),
        );

      case attendance_screen.routeName:
        return MaterialPageRoute(
            builder: (_) => attendance_screen(),
        );
      case PayslipScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => PayslipScreen(),
        );
      default:
        return null;
    }
  }
}
