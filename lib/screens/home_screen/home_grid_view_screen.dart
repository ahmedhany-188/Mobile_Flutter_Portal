import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/benefits_screen/benefits_screen.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/equipments_request.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/screens/photos_screen/photos_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:popover/popover.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/drawer/main_drawer.dart';
import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../admin_request_screen/business_card_screen.dart';
import '../news_screen/news_screen.dart';
import '../notification_screen/notifications_screen.dart';
import '../../screens/contacts_screen/contacts_screen.dart';
import '../../screens/myattendance_screen/attendance_screen.dart';
import '../../bloc/notification_bloc/bloc/user_notification_bloc.dart';
import '../videos_screen/videos_screen.dart';

class HomeGridViewScreen extends StatelessWidget {
  const HomeGridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(builder: (context) {
              return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image.asset(Assets.images.logo.path, scale: 30));
            }),
            centerTitle: true,
            title: const Text('Hassan Allam Holding'),
            actions: [
              BlocProvider.value(
                value: BlocProvider.of<UserNotificationApiCubit>(context),
                child: BlocBuilder<UserNotificationApiCubit, UserNotificationApiState>(
                  builder: (context, state) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Navigator.of(context)
                          .pushNamed(NotificationsScreen.routeName),
                      child: Badge(
                        showBadge: state.userNotificationList.isNotEmpty ? true : false,
                        toAnimate: true,
                        animationDuration: const Duration(milliseconds: 1000),
                        animationType: BadgeAnimationType.scale,
                        badgeColor: Colors.red,
                        badgeContent: Text(
                          "${state.userNotificationList.length}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                        position: const BadgePosition(
                          start: 5,
                          top: 5,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(NotificationsScreen.routeName),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          drawer: const MainDrawer(),
          body: Stack(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocProvider<NewsCubit>.value(
                    value: NewsCubit.get(context),
                    child: BlocBuilder<NewsCubit, NewsState>(
                      builder: (context, state) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 25),
                          height: 100,
                          child: ListView(
                            physics:const NeverScrollableScrollPhysics(),
                            reverse: false,
                            shrinkWrap: true,
                            children: [
                              AnimatedTextKit(
                                isRepeatingAnimation: true,
                                pause: const Duration(milliseconds: 1000),
                                repeatForever: true,
                                displayFullTextOnTap: false,
                                animatedTexts: NewsCubit.get(context)
                                        .announcment
                                        .isEmpty
                                    ? [
                                        TyperAnimatedText(
                                          'Checking for Announcement... ',
                                          speed:
                                              const Duration(milliseconds: 100),
                                          textAlign: TextAlign.center,
                                          curve: Curves.ease,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.clip,
                                              fontFamily: 'RobotoFlex',
                                              fontSize: 14),
                                        )
                                      ]
                                    : NewsCubit.get(context).announcment,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      padding: EdgeInsets.zero,
                      addRepaintBoundaries: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    Assets.images.homepage.attendanceIcon.path,
                                    scale: 3),
                                const Text(
                                  'Attendance',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(ContactsScreen.routeName),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    Assets.images.homepage.contactListIcon.path,
                                    scale: 3),
                                const Text(
                                  'Contact List',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )),
                        MenuPopupWidget(
                          benefitsMenuItems(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  Assets.images.homepage.benefitsIcon.path,
                                  scale: 3),
                              const Text(
                                'Benefits',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        MenuPopupWidget(
                          hrRequestMenuItems(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  Assets.images.homepage.hrRequestsIcon.path,
                                  scale: 3),
                              const Text(
                                'HR Request',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        MenuPopupWidget(
                          itRequestMenuItems(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  Assets.images.homepage.itRequestIcon.path,
                                  scale: 3),
                              const Text(
                                'IT Request',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        MenuPopupWidget(
                          mediaCenterMenuItems(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  Assets.images.homepage.mediaCenterIcon.path,
                                  scale: 3),
                              const Text(
                                'Media Center',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(NewsScreen.routeName),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    Assets.images.homepage.newsIcon.path,
                                    scale: 3),
                                const Text(
                                  'News',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )),
                        MenuPopupWidget(
                          newsLetterMenuItems(context),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  Assets.images.homepage.haNewsLetterIcon.path,
                                  scale: 3),
                              const Text(
                                'HA NewsLetter',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(EconomyNewsScreen.routeName),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    Assets.images.homepage.economyNewsIcon.path,
                                    scale: 3),
                                const Text(
                                  'Economy News',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey.shade700,
                        period: const Duration(milliseconds: 3000),
                        child: const Text(
                          '\u00a9 2021 IT Department All Rights Reserved',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                        // Container(
                        //   color: Colors.red,
                        //   height: 20,
                        //   width: MediaQuery.of(context).size.width,
                        // ),
                        ),
                  ),
                ),
              ])),
    );
  }
}

Widget benefitsMenuItems(BuildContext context) {
  return Scrollbar(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () =>
              Navigator.of(context).pushNamed(MedicalRequestScreen.routeName),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Medical Request',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () =>
              Navigator.of(context).pushNamed(BenefitsScreen.routeName),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'HAH Benefits',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget hrRequestMenuItems(BuildContext context) {
  return Scrollbar(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              BusinessMissionScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Business Mission',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              PermissionScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Permission',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(VacationScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Vacation',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              EmbassyLetterScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Embassy Letter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              BusinessCardScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Business Card',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget itRequestMenuItems(BuildContext context) {
  return Scrollbar(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              EmailAndUserAccountScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Email Account',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              AccessRightScreen.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Access Right',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(
              EquipmentsRequest.routeName,
              arguments: {'request-No': '0'}),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Equipment',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget mediaCenterMenuItems(BuildContext context) {
  return Scrollbar(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(PhotosScreen.routeName),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Photos',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.of(context).pushNamed(VideosScreen.routeName),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Videos',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget newsLetterMenuItems(BuildContext context) {
  return Scrollbar(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => launchUrl(
              Uri.parse(
                  'https://portal.hassanallam.com/NewsLatter/index-ar.html'),
              mode: LaunchMode.platformDefault),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Arabic',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => launchUrl(
              Uri.parse('https://portal.hassanallam.com/NewsLatter/index.html'),
              mode: LaunchMode.platformDefault),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'English',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

class MenuPopupWidget extends StatelessWidget {
  const MenuPopupWidget(
    this.widgetFunction,
    this.childWidget, {
    Key? key,
  }) : super(key: key);

  final Widget widgetFunction;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: childWidget,
      onTap: () {
        showPopover(
          context: context,
          transitionDuration: const Duration(milliseconds: 150),
          bodyBuilder: (context) => widgetFunction,
          direction: PopoverDirection.top,
          width: 150,
          backgroundColor: Colors.grey.shade500,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
    );
  }
}