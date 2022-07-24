import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/statistics_bloc/statistics_cubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../screens/about_value_screen/about_screen.dart';
import '../../screens/about_value_screen/value_screen.dart';
import '../../screens/economy_news_screen/economy_news_screen.dart';
import '../../screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import '../../screens/get_direction_screen/get_direction_screen.dart';
import '../../screens/home_screen/taps_screen.dart';
import '../../screens/medicalrequest_screen/medical_request_screen.dart';
import '../../screens/my_requests_screen/add_request_screen.dart';
import '../../screens/my_requests_screen/my_requests_screen.dart';
import '../../screens/myattendance_screen/attendance_screen.dart';
import '../../screens/myprofile_screen/ProfileScreen.dart';
import '../../screens/news_screen/news_screen.dart';
import '../../screens/payslip_screen/payslip_screen.dart';
import '../../screens/photos_screen/photos_screen.dart';
import '../../screens/polls_screen/polls_screen.dart';
import '../../screens/subsidiaries_screen/subsidiaries_screen.dart';
import '../../screens/apps_screen/apps_screen.dart';
import '../../screens/videos_screen/videos_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

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

  Widget buildExpansionTile() {
    return ExpansionTile(
      leading: const Icon(
        Icons.abc,
        size: 25,
        color: Colors.white,
      ),
      title: const Text(
        'News Letter',
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Colors.white),
      ),
      children: [
        TextButton(
          onPressed: () {
            launchUrl(
                Uri.parse(
                    'https://portal.hassanallam.com/NewsLatter/index-ar.html'),
                mode: LaunchMode.platformDefault);
          },
          child: const Text(
            'عربي',
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            launchUrl(
                Uri.parse(
                    'https://portal.hassanallam.com/NewsLatter/index.html'),
                mode: LaunchMode.platformDefault);
          },
          child: const Text(
            'English',
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ],
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
          child: Stack(
            children: [
              Column(
                children: [
                  ///commented code below is for centered image and text
                  // Container(
                  //   clipBehavior: Clip.none,
                  //   height: deviceHeight * 0.18,
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.only(bottom: 15),
                  //   alignment: Alignment.center,
                  //   color: Colors.transparent,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         radius: 30,
                  //         child: CircleAvatar(
                  //           radius: 29,
                  //           // borderRadius: BorderRadius.circular(50),
                  //           backgroundImage: NetworkImage(
                  //             'https://portal.hassanallam.com/Apps/images/Profile/${user!.imgProfile}',
                  //           ),
                  //           onBackgroundImageError: (_, __) {
                  //             Image.asset(
                  //               'assets/images/logo.png',
                  //               fit: BoxFit.fitHeight,
                  //               width: 65,
                  //               height: 65,
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //       Flexible(
                  //           child: Text(user.name!.split(' ').take(3).join(' '),
                  //               style: const TextStyle(
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.white))),
                  //       Flexible(
                  //           child: Text('${user.titleName}',
                  //               style: const TextStyle(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.normal,
                  //                   color: Colors.white))),
                  //     ],
                  //   ),
                  // ),
                  /// code below is for new design
                  Container(
                    clipBehavior: Clip.none,
                    height: deviceHeight * 0.18,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    // alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: CircleAvatar(
                              radius: 29,
                              // borderRadius: BorderRadius.circular(50),
                              backgroundImage: NetworkImage(
                                'https://portal.hassanallam.com/Apps/images/Profile/${user!.imgProfile}',
                              ),
                              onBackgroundImageError: (_, __) {
                                Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.fitHeight,
                                  width: 65,
                                  height: 65,
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 80),
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                      ],
                    ),
                  ),
                  BlocProvider.value(
                      value: StatisticsCubit.get(context),
                      child: BlocBuilder<StatisticsCubit, StatisticsInitial>(
                        buildWhen: (pre, curr) {
                          if (pre != curr) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          return (state.statisticsStates ==
                                  StatisticsEnumStates.success)
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0, left: 10.0, right: 8.0),
                                      child: LinearPercentIndicator(
                                        progressColor: Colors.red,
                                        percent: double.parse(state
                                                .statisicsList[0].consumed!) /
                                            double.parse(state
                                                .statisicsList[0].balance!),
                                        lineHeight: 2,
                                        widgetIndicator: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                              '${state.statisicsList[0].consumed}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red)),
                                        ),
                                        animation: true,
                                        animationDuration: 1000,
                                        trailing: Text(
                                            '${state.statisicsList[0].balance} days',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.red)),
                                        leading: const Text('Vacations',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.red)),
                                        barRadius: const Radius.circular(25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0, left: 10.0, right: 8.0),
                                      child: LinearPercentIndicator(
                                        progressColor: Colors.yellow,
                                        percent: double.parse(
                                                '${state.statisicsList[2].consumed}') /
                                            double.parse(
                                                '${state.statisicsList[2].balance}'),
                                        lineHeight: 2,
                                        widgetIndicator: Text(
                                            '${state.statisicsList[2].consumed}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellow)),
                                        animation: true,
                                        trailing: Text(
                                            '${state.statisicsList[2].balance} hours',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.yellow)),
                                        leading: const Text('Permissions',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.yellow)),
                                        barRadius: const Radius.circular(25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0, left: 10.0, right: 8.0),
                                      child: LinearPercentIndicator(
                                        progressColor: Colors.green,
                                        percent: double.parse(state
                                                .statisicsList[1].consumed!) /
                                            30,
                                        lineHeight: 2,
                                        widgetIndicator: Text(
                                            state.statisicsList[1].consumed!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                        animation: true,
                                        trailing: const Text('No Limits',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.green)),
                                        leading: const Text('Business Mission',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.green)),
                                        barRadius: const Radius.circular(25),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      )),
                  SizedBox(
                    height: deviceHeight * 0.70 - deviceTopPadding,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildListTile(
                            'Home',
                            Icons.home,
                            () {
                              Navigator.pushNamed(
                                  context, TapsScreen.routeName);
                            },
                          ),
                          buildDivider(),
                          buildListTile(
                            'My Profile',
                            Icons.person,
                            () {
                              Navigator.pushNamed(
                                  context, UserProfileScreen.routeName);
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
                              Navigator.pushNamed(
                                  context, AttendanceScreen.routeName);
                            },
                          ),
                          buildDivider(),
                          buildListTile(
                              'Medical Request', Icons.medical_services, () {
                            Navigator.pushNamed(
                                context, MedicalRequestScreen.routeName);
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
                          // buildDivider(),
                          //
                          // buildListTile(
                          //   'it request email account',
                          //   Icons.format_align_justify_outlined,
                          //   () {
                          //     Navigator.pushNamed(
                          //         context, EmailAndUserAccountScreen.routeName);
                          //   },
                          // ),
                          //
                          // buildDivider(),
                          // buildListTile(
                          //   'it request access right',
                          //   Icons.format_align_justify_outlined,
                          //   () {
                          //     Navigator.pushNamed(
                          //         context, AccessRightScreen.routeName);
                          //   },
                          // ),
                          //
                          // buildDivider(),
                          // buildListTile(
                          //   'IT Equipments Request',
                          //   Icons.format_align_justify_outlined,
                          //   () {
                          //     Navigator.of(context)
                          //         .pushNamed(EquipmentsRequest.routeName);
                          //
                          //     // Navigator
                          //     //     .pushNamed(context,AccessRightScreen.routeName);
                          //   },
                          // ),

                          buildDivider(),
                          buildListTile(
                            'EconomyNews',
                            Icons.waterfall_chart,
                            () {
                              Navigator.pushNamed(
                                  context, EconomyNewsScreen.routeName);
                            },
                          ),
                          buildDivider(),

                          // buildListTile(
                          //   'Business Card',
                          //   Icons.credit_card,
                          //   () {
                          //     Navigator.pushNamed(
                          //         context, BusinessCardScreen.routeName);
                          //   },
                          // ),
                          //
                          // buildDivider(),
                          // buildListTile(
                          //   'Embassy Letter',
                          //   Icons.airplanemode_active,
                          //   () {
                          //     Navigator.pushNamed(
                          //         context, EmbassyLetterScreen.routeName);
                          //   },
                          // ),
                          //
                          // buildDivider(),
                          buildListTile(
                            'My Requests',
                            Icons.wallpaper,
                            () {
                              Navigator.of(context)
                                  .pushNamed(MyRequestsScreen.routeName);
                              // Navigator
                              //     .pushNamed(context,MyRequestsScreen.routeName);
                            },
                          ),

                          buildDivider(),
                          buildListTile(
                            'Appraisal',
                            Icons.quiz,
                            () {
                              Navigator.pushNamed(
                                  context, EmployeeAppraisalScreen.routeName);
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
                              Navigator.of(context)
                                  .pushNamed(NewsScreen.routeName);
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
                          // buildListTile(
                          //   'HR Permission',
                          //   Icons.add_a_photo,
                          //   () {
                          //     Navigator.of(context)
                          //         .pushNamed(PermissionScreen.routeName);
                          //   },
                          // ),
                          // buildDivider(),
                          // buildListTile(
                          //   'HR Vacation',
                          //   Icons.add_a_photo,
                          //   () {
                          //     Navigator.of(context)
                          //         .pushNamed(VacationScreen.routeName);
                          //   },
                          // ),
                          // buildDivider(),
                          // buildListTile(
                          //   'HR Business Mission',
                          //   Icons.add_a_photo,
                          //   () {
                          //     Navigator.of(context)
                          //         .pushNamed(BusinessMissionScreen.routeName);
                          //   },
                          // ),
                          // buildDivider(),
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
                          buildExpansionTile(),
                          // buildListTile(
                          //   'News Letter',
                          //   Icons.apps,
                          //       () {
                          //     Navigator.of(context)
                          //         .pushNamed(NewsLetterScreen.routeName);
                          //   },
                          // ),

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
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(top: 50,right: 10),
                child: SizedBox(
                  height: 27,
                  width: 100,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white30,padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(AddRequestScreen.routeName);
                    },
                    child: const Text('Add Request',
                        style: TextStyle(color: Colors.white,)),
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
