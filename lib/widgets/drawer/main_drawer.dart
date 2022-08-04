import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../bloc/login_cubit/login_cubit.dart';
import '../../screens/news_screen/news_screen.dart';
import '../../screens/polls_screen/polls_screen.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/statistics_bloc/statistics_cubit.dart';
import '../../screens/payslip_screen/payslip_screen.dart';
import '../../screens/myprofile_screen/ProfileScreen.dart';
import '../../screens/about_value_screen/about_screen.dart';
import '../../screens/my_requests_screen/my_requests_screen.dart';
import '../../screens/my_requests_screen/add_request_screen.dart';
import '../../screens/myattendance_screen/attendance_screen.dart';
import '../../screens/economy_news_screen/economy_news_screen.dart';
import '../../screens/get_direction_screen/get_direction_screen.dart';
import '../../screens/employee_appraisal_screen/employee_appraisal_screen.dart';

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
    FocusManager.instance.primaryFocus
        ?.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
    FocusManager.instance.primaryFocus
        ?.unfocus(disposition: UnfocusDisposition.scope);
    final user =
        context.select((AppBloc bloc) => bloc.state.userData.employeeData);

    return Sizer(
      builder: (c, o, d) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            height: 100.h,
            width: 90.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_image_background.png'),
                  fit: BoxFit.cover),
            ),
            child: Drawer(
              elevation: 5.sp,
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
                        // clipBehavior: Clip.none,
                        height: 18.h,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 1.h),
                        alignment: Alignment.bottomLeft,
                        color: Colors.transparent,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0.sp),
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
                              margin: EdgeInsets.only(left: 60.sp),
                              alignment: Alignment.centerLeft,
                              height: 8.0.h,
                              width: 70.w,
                              // color: Colors.yellow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      user.name!
                                          .split(' ')
                                          .take(3)
                                          .join(' '),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.fade,
                                          color: Colors.white)),
                                  Text('${user.titleName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                        child: BlocProvider.value(
                            value: StatisticsCubit.get(context),
                            child:
                                BlocBuilder<StatisticsCubit, StatisticsInitial>(
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
                                            padding: EdgeInsets.symmetric(
                                              vertical: 0.5.h,
                                              horizontal: 2.5.w,
                                            ),
                                            child: LinearPercentIndicator(
                                              progressColor: Colors.red,
                                              percent: double.parse(state
                                                      .statisicsList[0]
                                                      .consumed!) /
                                                  double.parse(state
                                                      .statisicsList[0]
                                                      .balance!),
                                              lineHeight: 2.sp,
                                              widgetIndicator: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                    '${state.statisicsList[0].consumed}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                              ),
                                              animation: true,
                                              animationDuration: 1000,
                                              trailing: Text(
                                                  '${state.statisicsList[0].balance} days',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.red)),
                                              leading: const Text('Vacations',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.red)),
                                              barRadius:
                                                  const Radius.circular(25),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 0.5.h,
                                              horizontal: 2.5.w,
                                            ),
                                            child: LinearPercentIndicator(
                                              progressColor: Colors.yellow,
                                              percent: double.parse(
                                                      '${state.statisicsList[2].consumed}') /
                                                  double.parse(
                                                      '${state.statisicsList[2].balance}'),
                                              lineHeight: 2.sp,
                                              widgetIndicator: Text(
                                                  '${state.statisicsList[2].consumed}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.yellow)),
                                              animation: true,
                                              trailing: Text(
                                                  '${state.statisicsList[2].balance} hours',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.yellow)),
                                              leading: const Text('Permissions',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.yellow)),
                                              barRadius:
                                                  const Radius.circular(25),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 0.5.h,
                                              horizontal: 2.5.w,
                                            ),
                                            child: LinearPercentIndicator(
                                              progressColor: Colors.green,
                                              percent: double.parse(state
                                                      .statisicsList[1]
                                                      .consumed!) /
                                                  30,
                                              lineHeight: 2.sp,
                                              widgetIndicator: Text(
                                                  state.statisicsList[1]
                                                      .consumed!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green)),
                                              animation: true,
                                              trailing: const Text('No Limits',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.green)),
                                              leading: const Text(
                                                  'Business Mission',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.green)),
                                              barRadius:
                                                  const Radius.circular(25),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              },
                            )),
                      ),
                      SizedBox(
                        height: 70.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              buildListTile(
                                'My Profile',
                                Icons.person,
                                () {
                                  Navigator.popAndPushNamed(
                                      context, UserProfileScreen.routeName);
                                },
                              ),
                              // buildDivider(),
                              // buildListTile(
                              //   'Get Direction',
                              //   Icons.nature_people,
                              //   () {
                              //     Navigator.of(context).popAndPushNamed(
                              //         GetDirectionScreen.routeName);
                              //   },
                              // ),
                              buildDivider(),
                              buildListTile(
                                'My Attendance',
                                Icons.fingerprint,
                                () {
                                  Navigator.popAndPushNamed(
                                      context, AttendanceScreen.routeName);
                                },
                              ),
                              buildDivider(),
                              buildListTile(
                                'My Payslip',
                                Icons.nature_people,
                                () {
                                  Navigator.of(context)
                                      .popAndPushNamed(PayslipScreen.routeName);
                                },
                              ),
                              buildDivider(),
                              buildListTile(
                                'My Requests',
                                Icons.wallpaper,
                                () {
                                  Navigator.of(context).popAndPushNamed(
                                      MyRequestsScreen.routeName);
                                },
                              ),

                              buildDivider(),
                              buildListTile(
                                'My Appraisal',
                                Icons.quiz,
                                () {
                                  Navigator.popAndPushNamed(context,
                                      EmployeeAppraisalScreen.routeName);
                                },
                              ),
                              buildDivider(),
                              buildListTile(
                                'About',
                                Icons.details,
                                () {
                                  Navigator.of(context)
                                      .popAndPushNamed(AboutScreen.routeName);
                                },
                              ),
                              buildDivider(),
                              buildListTile(
                                'Polls',
                                Icons.add_a_photo,
                                () {
                                  Navigator.of(context)
                                      .popAndPushNamed(PollsScreen.routeName);
                                },
                              ),
                              // buildDivider(),
                              // buildListTile(
                              //   'News',
                              //   Icons.list,
                              //   () {
                              //     Navigator.of(context)
                              //         .popAndPushNamed(NewsScreen.routeName);
                              //   },
                              // ),
                              // buildDivider(),
                              // buildListTile(
                              //   'EconomyNews',
                              //   Icons.waterfall_chart,
                              //   () {
                              //     Navigator.popAndPushNamed(
                              //         context, EconomyNewsScreen.routeName);
                              //   },
                              // ),
                              // buildDivider(),
                              // buildExpansionTile(),

                              ///NewsLetter

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
                                  context
                                      .read<AppBloc>()
                                      .add(AppLogoutRequested());
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
                    padding: EdgeInsets.only(top: 35.sp, right: 10.sp),
                    child: SizedBox(
                      height: 4.h,
                      width: 30.w,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white30,
                            padding: EdgeInsets.zero),
                        onPressed: () {
                          Navigator.of(context)
                              .popAndPushNamed(AddRequestScreen.routeName);
                        },
                        child: const Text('Add Request',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
