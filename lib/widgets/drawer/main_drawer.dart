import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/login_cubit/login_cubit.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/travel_request_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/polls_screen/polls_screen.dart';
import 'package:provider/src/provider.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';

import '../../screens/apps_screen/apps_screen.dart';
import '../../screens/videos_screen/videos_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Colors.white),
      ),
      onTap: tapHandler,
    );
  }

  Divider buildDivider() {
    return const Divider(
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user =
        context.select((AppBloc bloc) => bloc.state.userData.employeeData);
    final deviceHeight = MediaQuery.of(context).size.height;
    final double deviceTopPadding =
        MediaQueryData.fromWindow(window).padding.bottom;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_image_background.png'),
              fit: BoxFit.cover),
        ),
        child: Drawer(
          elevation: 5,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.none,
                height: deviceHeight * 0.24,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://portal.hassanallam.com/Apps/images/Profile/${user!.userHrCode}.jpg',
                          width: 55,
                          height: 55,
                          fit: BoxFit.fill,
                          errorBuilder: (ctx, obj, st) {
                            return Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.fitHeight,
                              width: 65,
                              height: 65,
                            );
                          },
                        ),
                      ),
                    ),
                    // const Text(
                    //   'welcome',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w900,
                    //     fontSize: 25,
                    //     color: Colors.white,
                    //     // Theme.of(context).primaryColor,
                    //   ),
                    // ),
                    Flexible(
                        child: Text(
                            user.name!.split(' ').take(3).join(' '),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    Flexible(
                        child: Text('${user.titleName}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white))),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.76 - deviceTopPadding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildListTile(
                        'Home',
                        Icons.home,
                        () {
                          Navigator
                              .pushReplacementNamed(context,TapsScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'My Profile',
                        Icons.person,
                        () {
                          Navigator.of(context)
                              .pushNamed(ProfileScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Get Direction',
                        Icons.nature_people,
                        () {
                          Navigator.of(context)
                              .pushNamed(GetDirectionScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Attendance',
                        Icons.fingerprint,
                        () {
                          Navigator.of(context)
                              .pushNamed(Attendance_Screen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile('Medical Request', Icons.medical_services,
                          () {
                        Navigator.of(context)
                            .pushNamed(MedicalRequestScreen.routeName);
                      }),
                      buildDivider(),
                      buildListTile(
                        'Payslip',
                        Icons.nature_people,
                        () {
                          Navigator.of(context)
                              .pushNamed(PayslipScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Subsidiaries',
                        Icons.add_business_sharp,
                        () {
                          Navigator.of(context)
                              .pushNamed(SubsidiariesScreen.routeName);
                        },
                      ),
                      buildDivider(),

                      buildListTile(
                        'it request user account',
                        Icons.format_align_justify_outlined,
                            () {
                          Navigator.of(context)
                              .pushNamed(EmailAndUserAccountScreen.routeName);
                        },
                      ),

                      buildDivider(),
                      buildListTile(
                        'it request access account',
                        Icons.format_align_justify_outlined,
                            () {
                          Navigator.of(context)
                              .pushNamed(AccessUserAccountScreen.routeName);
                        },
                      ),

                      buildDivider(),
                      buildListTile(
                        'EconomyNews',
                        Icons.waterfall_chart,
                        () {
                          Navigator.of(context)
                              .pushNamed(EconomyNewsScreen.routeName);
                        },
                      ),
                      buildDivider(),

                      buildListTile(
                        'Business Card',
                        Icons.credit_card,
                            () {
                          Navigator.of(context).pushNamed(BusinessCardScreen
                              .routeName);
                        },
                      ),

                      buildDivider(),
                      buildListTile(
                        'Embassy Letter',
                        Icons.airplanemode_active,
                            () {
                          Navigator.of(context).pushNamed(EmbassyLetterScreen
                              .routeName);
                        },
                      ),

                      // buildDivider(),
                      // buildListTile(
                      //   'Travel Request',
                      //   Icons.airplanemode_active,
                      //       () {
                      //     Navigator.of(context)
                      //         .pushNamed(TravelRequestScreen.routeName);
                      //   },
                      // ),

                      buildDivider(),
                      buildListTile(
                        'Appraisal',
                        Icons.quiz,
                        () {
                          Navigator.of(context)
                              .pushNamed(EmployeeAppraisal_Screen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Value',
                        Icons.agriculture_sharp,
                        () {
                          Navigator.of(context)
                              .pushNamed(ValueScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'About',
                        Icons.details,
                        () {
                          Navigator.of(context)
                              .pushNamed(AboutScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'News',
                        Icons.list,
                        () {
                          Navigator.of(context).pushNamed(NewsScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Photos',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(PhotosScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'HR Permission',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(PermissionScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'HR Vacation',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(VacationScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'HR Business Mission',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(BusinessMissionScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Polls',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(PollsScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Videos',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context)
                              .pushNamed(VideosScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Apps',
                        Icons.apps,
                        () {
                          Navigator.of(context)
                              .pushNamed(AppsScreen.routeName);
                        },
                      ),
                      buildDivider(),
                      buildListTile(
                        'Logout',
                        Icons.logout,
                            () {
                          context.read<AppBloc>().add(AppLogoutRequested());
                          context.read<LoginCubit>().clearCubit();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
