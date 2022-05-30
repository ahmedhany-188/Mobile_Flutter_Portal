import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/benefits_screen/benefits_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contact_detail_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/splash_screen/splash_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';

import '../screens/apps_screen/apps_screen.dart';
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
          builder: (_) => const SplashScreen(),
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
          builder: (_) => const GetDirectionScreen(),
        );

      case Attendance_Screen.routeName:
        return MaterialPageRoute(
            builder: (_) => const Attendance_Screen(),
        );

      case EmployeeAppraisal_Screen.routeName:
        return MaterialPageRoute(
          builder: (_) => const EmployeeAppraisal_Screen(),
        );

      case MedicalRequestScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MedicalRequestScreen(),
        );

      case ProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case EconomyNewsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const EconomyNewsScreen(),
        );

      case PayslipScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PayslipScreen(),
        );

      case SubsidiariesScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const SubsidiariesScreen(),
        );
      case ValueScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const ValueScreen(),
        );
      case AboutScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      case NewsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const NewsScreen(),
        );
      case PhotosScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const PhotosScreen(),
        );
      case PermissionScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const PermissionScreen(),
        );
      case VacationScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => VacationScreen(),
        );
      case BusinessMissionScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => BusinessMissionScreen(),
        );
      case PollsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const PollsScreen(),
        );
      case VideosScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const VideosScreen(),
        );
      case BenefitsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => const BenefitsScreen(),
        );

      case AppsScreen.routeName:

        return MaterialPageRoute(
          builder: (_) => AppsScreen(),
        );
      default:
        return null;
    }
  }
}
