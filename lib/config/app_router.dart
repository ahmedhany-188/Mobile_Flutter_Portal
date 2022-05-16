import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contact_detail_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/splash_screen/splash_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/polls_screen/polls_screen.dart';
import '../screens/videos_screen/videos_screen.dart';

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

      case Attendance_Screen.routeName:
        return MaterialPageRoute(
            builder: (_) => Attendance_Screen(),
        );

      case EmployeeAppraisal_Screen.routeName:
        return MaterialPageRoute(
          builder: (_) => EmployeeAppraisal_Screen(),
        );

      case MedicalRequestScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => MedicalRequestScreen(),
        );

      case EconomyNewsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EconomyNewsScreen(),
        );

      case PayslipScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PayslipScreen(),
        );

      case SubsidiariesScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => SubsidiariesScreen(),
        );
      case ValueScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => ValueScreen(),
        );
      case AboutScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
        );
      case NewsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => NewsScreen(),
        );
      case PhotosScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => PhotosScreen(),
        );
      case PermissionScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => PermissionScreen(),
        );
      case PollsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => PollsScreen(),
        );
      case VideosScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => VideosScreen(),
        );
      default:
        return null;
    }
  }
}
