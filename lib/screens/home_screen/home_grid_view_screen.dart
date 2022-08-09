import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contacts_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

import '../../bloc/news_screen_bloc/news_cubit.dart';
import '../../bloc/notification_bloc/bloc/user_notification_bloc.dart';
import '../notification_screen/notifications_screen.dart';

class HomeGridViewScreen extends StatelessWidget {
  const HomeGridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Assets.images.defaultBg.image().image,
        fit: BoxFit.cover,
      )),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            // key: UniqueKey(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // leading: Image(image: Asset.),
              centerTitle: true,
              title: const Text('Hassan Allam Holding'),
              actions: [
                BlocProvider.value(
                  value: BlocProvider.of<UserNotificationBloc>(context),
                  child:
                      BlocBuilder<UserNotificationBloc, UserNotificationState>(
                    builder: (context, state) {
                      return Badge(
                        toAnimate: true,
                        animationDuration: const Duration(milliseconds: 1000),
                        animationType: BadgeAnimationType.scale,
                        badgeColor: Colors.red,
                        badgeContent: Text(
                          "${state.notifications.length}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        position: const BadgePosition(
                          start: 5,
                          top: 4,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NotificationsScreen.routeName);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            drawer: const MainDrawer(),
            extendBodyBehindAppBar: true,
            // extendBody: true,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocProvider<NewsCubit>.value(
                    value: NewsCubit.get(context),
                    child: BlocBuilder<NewsCubit, NewsState>(
                      builder: (context, state) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 70),
                          height: 100,
                          child: ListView(
                            reverse: true,
                            shrinkWrap: true,
                            itemExtent: 80,
                            // physics: const NeverScrollableScrollPhysics(),
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
                  Container(
                    color: Colors.red,
                    margin: const EdgeInsets.all(10.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      children: [
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
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
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            child: Column(
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
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            child: Column(
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
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            child: Column(
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
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            child: Column(
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
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
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
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    Assets
                                        .images.homepage.haNewsLetterIcon.path,
                                    scale: 3),
                                const Text(
                                  'HA NewsLetter',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AttendanceScreen.routeName),
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
                ])),
      ),
    );
  }
}
