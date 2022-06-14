import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_business_mission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_permission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_vacation_form_model.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/benefits_screen/benefits_screen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contact_detail_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/my_requests_screen/my_requests_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/setting_screen/setting_screen.dart';
import 'package:hassanallamportalflutter/screens/splash_screen/splash_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';

import '../screens/apps_screen/apps_screen.dart';
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
      // case ContactDetailScreen.routeName:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => ContactDetailScreen(selectedContactDataAsMap: args,),
      //   );
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
          builder: (_) => PermissionScreen(permissionFormModelData: PermissionFormModelData(0,'','','',0,'',0,'','','','',''),objectValidation:false ),
        );

      case VacationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => VacationScreen(requestNo: settings.arguments),
        );

      case BusinessCardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BusinessCardScreen(businessCardFormModel:BusinessCardFormModel('','','','','','') ,objectValidation: false ),
        );

      case EmbassyLetterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EmbassyLetterScreen(embassyLetterFormModel:EmbassyLetterFormModel('','','','','','','','') ,objectValidation: false),
        );

      case EmailAndUserAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => EmailAndUserAccountScreen(emailUserAccount: EmailUserFormModel('',0,'',false),objectValidation: false),
        );

      case AccessUserAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AccessUserAccountScreen(accessRightModel: AccessRightModel(0,false,false,false,false,false,'','','','','',[]),objectValidation: false),
        );

      case MyRequestsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyRequestsScreen(),
        );


      case BusinessMissionScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BusinessMissionScreen(businessMissionFormModelData: BusinessMissionFormModelData(0,'','','',0,'','','','','','','',''),objectValidation: false),
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
            builder: (context) => const NotificationsScreen()
        );
      default:
        return null;
    }
  }
}
