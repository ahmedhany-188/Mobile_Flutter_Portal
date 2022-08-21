import 'package:flutter/material.dart';

import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/benefits_screen/benefits_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contact_detail_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contacts_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/equipments_request.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreenDirectManager.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/splash_screen/splash_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';

import '../data/models/contacts_related_models/contacts_data_from_api.dart';
import '../screens/apps_screen/apps_screen.dart';
import '../screens/my_requests_screen/add_request_screen.dart';
import '../screens/notification_screen/notifications_screen.dart';
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
        final args = settings.arguments as ContactsDataFromApi;
        return MaterialPageRoute(
          builder: (_) => ContactDetailScreen(
            selectedContactDataAsMap: args,
          ),
        );
      case GetDirectionScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const GetDirectionScreen(),
        );

      case AttendanceScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const AttendanceScreen(),
        );

      case EmployeeAppraisalScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const EmployeeAppraisalScreen(),
        );

      case MedicalRequestScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MedicalRequestScreen(),
        );

      case UserProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const UserProfileScreen(),
        );

      case DirectManagerProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) =>  DirectManagerProfileScreen(requestData: settings.arguments),
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
          builder: (_) => PermissionScreen(requestData: settings.arguments),
        );
      case VacationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => VacationScreen(requestData: settings.arguments),
        );

      case BusinessCardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BusinessCardScreen(requestNo: settings.arguments),
        );

      case EmbassyLetterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EmbassyLetterScreen(requestData: settings.arguments),
        );

      case EmailAndUserAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (_) =>  EmailAndUserAccountScreen(requestData: settings.arguments),
        );

      case AccessRightScreen.routeName:
        return MaterialPageRoute(
          builder: (_) =>
              AccessRightScreen(requestData: settings.arguments),
        );

      case MyRequestsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyRequestsScreen(),
        );

      case BusinessMissionScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BusinessMissionScreen(requestData: settings.arguments),
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
          builder: (_) => const AppsScreen(),
        );
      case NotificationsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const NotificationsScreen());

      case NewsLetterScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const NewsLetterScreen());

      case EquipmentsRequest.routeName:
        return MaterialPageRoute(
            builder: (_) => EquipmentsRequest(requestData: settings.arguments,));

      case AddRequestScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const AddRequestScreen());

      case ContactsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const ContactsScreen());

      default:
        return null;
    }
  }
}
