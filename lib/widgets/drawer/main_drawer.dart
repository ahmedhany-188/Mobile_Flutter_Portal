import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';
import 'package:hassanallamportalflutter/screens/notification_screen/notifications_screen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_screen.dart';
import 'package:hassanallamportalflutter/screens/subsidiaries_screen/subsidiaries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/apps_screen_bloc/apps_cubit.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../constants/url_links.dart';
import '../../screens/about_value_screen/value_screen.dart';
import '../../screens/get_direction_screen/get_direction_screen.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../screens/payslip_screen/payslip_screen.dart';
import '../../screens/myprofile_screen/profile_screen.dart';
import '../../screens/about_value_screen/about_screen.dart';
import '../../screens/my_requests_screen/my_requests_screen.dart';
import '../../screens/myattendance_screen/attendance_screen.dart';
import '../../screens/employee_appraisal_screen/employee_appraisal_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

//   @override
//   State<MainDrawer> createState() => _MainDrawerState();
// }
//
// class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, tapHandler) {
    return InkWell(
      onTap: tapHandler,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ]),
    );
    // return ListTile(
    //   leading: Icon(
    //     icon,
    //     size: 15,
    //     color: Colors.white,
    //   ),
    //   title: Text(
    //     title,
    //     style: const TextStyle(
    //         fontFamily: 'RobotoCondensed',
    //         fontSize: 14,
    //         fontWeight: FontWeight.normal,
    //         color: Colors.white),
    //   ),
    //   onTap: tapHandler,
    // );
  }

  Widget buildNoIconTile(String title, tapHandler) {
    return InkWell(
      onTap: tapHandler,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ],
      ),
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

  Widget buildGrouping(String groupName) {
    return Container(
        margin: const EdgeInsets.only(left: 15.0),
        padding: const EdgeInsets.all(10.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              groupName,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )));
  }

  Widget buildExternalLinks(String name, String urlLink) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(urlLink), mode: LaunchMode.externalApplication);
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ],
      ),
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

    return CustomBackground(
      child: Drawer(
        elevation: 0,
        width: double.infinity,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            /// commented code below is for centered image and text
            Container(
              // clipBehavior: Clip.none,
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              // margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    // borderRadius: BorderRadius.circular(50),
                    backgroundImage: CachedNetworkImageProvider(
                      getUserProfilePicture(user!.imgProfile!),
                    ),
                    backgroundColor: Colors.transparent,
                    onBackgroundImageError: (_, __) {
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitHeight,
                        width: 65,
                        height: 65,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text(user.name!.split(' ').take(5).join(' '),
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.normal,
                              color: Colors.white))),
                  Flexible(
                      child: Text('${user.titleName}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.robotoCondensed,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500))),
                  Flexible(
                      child: Text('Grade: ${user.gradeName}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500))),
                ],
              ),
            ),

            /// code below is for new design
            // Container(
            //   // clipBehavior: Clip.none,
            //   height: 18.h,
            //   width: double.infinity,
            //   margin: EdgeInsets.only(bottom: 1.h),
            //   alignment: Alignment.bottomLeft,
            //   color: Colors.transparent,
            //   child: Stack(
            //     alignment: Alignment.bottomLeft,
            //     children: [
            //       Container(
            //         padding: EdgeInsets.only(left: 10.0.sp),
            //         child: CircleAvatar(
            //           backgroundColor: Colors.white,
            //           radius: 30,
            //           child: CircleAvatar(
            //             radius: 29,
            //             // borderRadius: BorderRadius.circular(50),
            //             backgroundImage: CachedNetworkImageProvider(
            //               'https://portal.hassanallam.com/Apps/images/Profile/${user!.imgProfile}',
            //             ),
            //             onBackgroundImageError: (_, __) {
            //               Image.asset(
            //                 'assets/images/logo.png',
            //                 fit: BoxFit.fitHeight,
            //                 width: 65,
            //                 height: 65,
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.only(left: 60.sp),
            //         alignment: Alignment.centerLeft,
            //         height: 8.0.h,
            //         width: 70.w,
            //         // color: Colors.yellow,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //                 user.name!
            //                     .split(' ')
            //                     .take(3)
            //                     .join(' '),
            //                 maxLines: 2,
            //                 style: const TextStyle(
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                     overflow: TextOverflow.fade,
            //                     color: Colors.white)),
            //             Text('${user.titleName}',
            //                 maxLines: 1,
            //                 overflow: TextOverflow.fade,
            //                 style: const TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.normal,
            //                     color: Colors.white)),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 12.h,
            //   child: BlocProvider.value(
            //       value: StatisticsCubit.get(context),
            //       child:
            //           BlocBuilder<StatisticsCubit, StatisticsInitial>(
            //         buildWhen: (pre, curr) {
            //           if (pre != curr) {
            //             return true;
            //           } else {
            //             return false;
            //           }
            //         },
            //         builder: (context, state) {
            //           return (state.statisticsStates ==
            //                   StatisticsEnumStates.success)
            //               ? Column(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.symmetric(
            //                         vertical: 0.5.h,
            //                         horizontal: 2.5.w,
            //                       ),
            //                       child: LinearPercentIndicator(
            //                         progressColor: Colors.red,
            //                         percent: double.parse(state
            //                                 .statisicsList[0]
            //                                 .consumed!) /
            //                             double.parse(state
            //                                 .statisicsList[0]
            //                                 .balance!),
            //                         lineHeight: 2.sp,
            //                         widgetIndicator: Padding(
            //                           padding:
            //                               const EdgeInsets.all(2.0),
            //                           child: Text(
            //                               '${state.statisicsList[0].consumed}',
            //                               style: const TextStyle(
            //                                   fontWeight:
            //                                       FontWeight.bold,
            //                                   color: Colors.red)),
            //                         ),
            //                         animation: true,
            //                         animationDuration: 1000,
            //                         trailing: Text(
            //                             '${state.statisicsList[0].balance} days',
            //                             style: const TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.red)),
            //                         leading: const Text('Vacations',
            //                             style: TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.red)),
            //                         barRadius:
            //                             const Radius.circular(25),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: EdgeInsets.symmetric(
            //                         vertical: 0.5.h,
            //                         horizontal: 2.5.w,
            //                       ),
            //                       child: LinearPercentIndicator(
            //                         progressColor: Colors.yellow,
            //                         percent: double.parse(
            //                                 '${state.statisicsList[2].consumed}') /
            //                             double.parse(
            //                                 '${state.statisicsList[2].balance}'),
            //                         lineHeight: 2.sp,
            //                         widgetIndicator: Text(
            //                             '${state.statisicsList[2].consumed}',
            //                             style: const TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 color: Colors.yellow)),
            //                         animation: true,
            //                         trailing: Text(
            //                             '${state.statisicsList[2].balance} hours',
            //                             style: const TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.yellow)),
            //                         leading: const Text('Permissions',
            //                             style: TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.yellow)),
            //                         barRadius:
            //                             const Radius.circular(25),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: EdgeInsets.symmetric(
            //                         vertical: 0.5.h,
            //                         horizontal: 2.5.w,
            //                       ),
            //                       child: LinearPercentIndicator(
            //                         progressColor: Colors.green,
            //                         percent: double.parse(state
            //                                 .statisicsList[1]
            //                                 .consumed!) /
            //                             30,
            //                         lineHeight: 2.sp,
            //                         widgetIndicator: Text(
            //                             state.statisicsList[1]
            //                                 .consumed!,
            //                             style: const TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 color: Colors.green)),
            //                         animation: true,
            //                         trailing: const Text('No Limits',
            //                             style: TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.green)),
            //                         leading: const Text(
            //                             'Business Mission',
            //                             style: TextStyle(
            //                                 fontWeight:
            //                                     FontWeight.bold,
            //                                 fontSize: 15,
            //                                 color: Colors.green)),
            //                         barRadius:
            //                             const Radius.circular(25),
            //                       ),
            //                     ),
            //                   ],
            //                 )
            //               : const Center(
            //                   child: CircularProgressIndicator(),
            //                 );
            //         },
            //       )),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.74,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildListTile(
                      'Home',
                      Icons.home,
                      () {
                        Navigator.of(context).pop();
                      },
                    ),
                    buildListTile(
                      'My Requests',
                      Icons.wallpaper,
                      () {
                        Navigator.of(context)
                            .popAndPushNamed(MyRequestsScreen.routeName);
                      },
                    ),
                    buildListTile(
                      'My Profile',
                      Icons.person,
                      () {
                        Navigator.popAndPushNamed(
                            context, UserProfileScreen.routeName);
                      },
                    ),
                    // buildDivider(),

                    buildListTile(
                      'My Attendance',
                      Icons.fingerprint,
                      () {

                        Navigator.popAndPushNamed(
                            context, AttendanceScreen.routeName);
                      },
                    ),
                    InkWell(
                      onTap: () => Navigator.popAndPushNamed(
                          context, NotificationsScreen.routeName),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildListTile(
                            'Notification',
                            Icons.notifications,
                            null,

                            /// to stop the navigation function to make the whole row navigate
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: BlocProvider.value(
                              value: BlocProvider.of<UserNotificationApiCubit>(
                                  context)
                                ..getNotifications(),
                              child: BlocBuilder<UserNotificationApiCubit,
                                  UserNotificationApiState>(
                                builder: (context, state) {
                                  return Badge(
                                    showBadge:
                                        state.userNotificationList.isNotEmpty
                                            ? true
                                            : false,
                                    toAnimate: false,
                                    animationDuration:
                                        const Duration(milliseconds: 1000),
                                    animationType: BadgeAnimationType.scale,
                                    badgeColor: Colors.red,
                                    badgeContent: Text(
                                      "${state.userNotificationList.length}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    position: const BadgePosition(
                                      start: 5,
                                      top: 4,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildListTile(
                      'My Payslip',
                      Icons.nature_people,
                      () {
                        Navigator.of(context)
                            .popAndPushNamed(PayslipScreen.routeName);
                      },
                    ),
                    buildListTile(
                      'My Appraisal',
                      Icons.quiz,
                      () {
                        Navigator.popAndPushNamed(
                            context, EmployeeAppraisalScreen.routeName);
                      },
                    ),

                    buildListTile(
                      'Staff Dashboard',
                      Icons.dashboard,
                      () {
                        Navigator.popAndPushNamed(
                            context, StaffDashBoardScreen.routeName);
                      },
                    ),

                    buildDivider(),

                    /// first Group
                    buildGrouping('OTHERS'),
                    buildNoIconTile(
                      'Get Direction',
                      () {
                        Navigator.of(context)
                            .popAndPushNamed(GetDirectionScreen.routeName);
                      },
                    ),
                    buildNoIconTile(
                      'Subsidiaries',
                      () {
                        Navigator.of(context)
                            .popAndPushNamed(SubsidiariesScreen.routeName);
                      },
                    ),
                    buildNoIconTile(
                      'Values',
                      () {
                        Navigator.of(context).popAndPushNamed(ValueScreen.routeName);
                      },
                    ),
                    buildNoIconTile(
                      'About',
                      () {
                        Navigator.of(context).popAndPushNamed(AboutScreen.routeName);
                      },
                    ),
                    buildNoIconTile(
                      'Sign Out',
                      () async {
                        // HydratedBloc.storage.clear();
                        // await BlocProvider.of<UserNotificationApiCubit>(context).clearState();
                        // if (!mounted) return;
                        // await BlocProvider.of<MyRequestsCubit>(context).clearState();
                        // if (!mounted) return;
                        context.read<AppBloc>().add(AppLogoutRequested());
                        context.read<LoginCubit>().clearCubit();
                      },
                    ),
                    buildDivider(),
                    buildGrouping('MAIN MENU'),
                    buildExternalLinks('HR Management', getHrManagment()),
                    buildExternalLinks('Quality ISO', getQualityIso()),
                    buildExternalLinks('Quality ASME', getQualityAsme()),
                    buildExternalLinks('HSE Management', getHSEManagment()),
                    buildExternalLinks('IT Management', getItManagment()),
                    buildExternalLinks('Appraisal', getAppraisal()),
                    buildExternalLinks('Compliance', getCompliance()),
                    buildExternalLinks('Code Of Conduct', getCodeOfConduct()),
                    buildExternalLinks('Training Plan', getTrainingPlan()),

                    buildDivider(),
                    buildGrouping('APPLICATIONS'),
                    BlocProvider<AppsCubit>.value(
                      value: AppsCubit.get(context),
                      child: BlocBuilder<AppsCubit, AppsState>(
                        buildWhen: (pre, curr) {
                          if (pre != curr) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          return (state is AppsSuccessState)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.appsList.length,
                                  itemBuilder: (ctx, index) {
                                    return buildExternalLinks(
                                        state.appsList[index].sysName!,
                                        state.appsList[index].sysLink
                                            .toString());
                                  })
                              : const Text(
                                  'You Have No Application To Be Shown',
                                  style: TextStyle(color: Colors.white),
                                );
                        },
                      ),
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
                    //         .popAndPushNamed(NewsLetterScreen.routeName);
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
