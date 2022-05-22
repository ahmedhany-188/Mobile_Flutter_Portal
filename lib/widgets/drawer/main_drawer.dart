import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/about_screen.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/myprofile_screen.dart';
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/screens/polls_screen/polls_screen.dart';
import 'package:provider/src/provider.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';

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
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final double deviceTopPadding =
        MediaQueryData.fromWindow(window).padding.bottom;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Drawer(
          elevation: 5,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.none,
                height: deviceHeight * 0.4,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                color: Theme.of(context).colorScheme.primary,
                // decoration: BoxDecoration(), use it if you will set another decoration apart from color
                child: const Text(
                  'welcome!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black,
                    // Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                height: deviceHeight * 0.6 - deviceTopPadding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildListTile(
                        'Home',
                        Icons.home,
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(TapsScreen.routeName);
                        },
                      ),

                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'My Profile',
                        Icons.person,
                            () {
                          Navigator.of(context).pushReplacementNamed(
                              myProfile_Screen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Get Direction',
                        Icons.nature_people,
                        () {
                          Navigator.of(context).pushReplacementNamed(
                              GetDirectionScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Attendance',
                        Icons.fingerprint,
                        () {
                          Navigator.of(context).pushReplacementNamed(
                              Attendance_Screen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile('Medical Request', Icons.medical_services,
                          () {
                        Navigator.of(context)
                            .pushNamed(MedicalRequestScreen.routeName);
                      }),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Payslip',
                        Icons.nature_people,
                        () {
                          Navigator.of(context)
                              .pushNamed(PayslipScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Subsidiaries',
                        Icons.add_business_sharp,
                        () {
                          Navigator.of(context)
                              .pushNamed(SubsidiariesScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'EconomyNews',
                        Icons.waterfall_chart,
                            () {
                          Navigator.of(context).pushNamed(EconomyNewsScreen
                              .routeName);
                        },
                      ),

                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Appraisal',
                        Icons.quiz,
                            () {
                          Navigator.of(context).pushNamed(EmployeeAppraisal_Screen
                              .routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Value',
                        Icons.agriculture_sharp,
                        () {
                          Navigator.of(context)
                              .pushNamed(ValueScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'About',
                        Icons.details,
                        () {
                          Navigator.of(context)
                              .pushNamed(AboutScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'News',
                        Icons.list,
                        () {
                          Navigator.of(context).pushNamed(NewsScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Photos',
                        Icons.add_a_photo,
                        () {
                          Navigator.of(context).pushNamed(PhotosScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'HR Permission',
                        Icons.add_a_photo,
                            () {
                          Navigator.of(context).pushNamed(PermissionScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Polls',
                        Icons.add_a_photo,
                            () {
                          Navigator.of(context).pushNamed(PollsScreen.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      buildListTile(
                        'Videos',
                        Icons.add_a_photo,
                            () {
                          Navigator.of(context).pushNamed(VideosScreen.routeName);
                        },
                      ),
                      buildListTile(
                        'Logout',
                        Icons.logout,
                        () => context.read<AppBloc>().add(AppLogoutRequested()),
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
