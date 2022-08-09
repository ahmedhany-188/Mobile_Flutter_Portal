import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/contacts_screen/contacts_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

import '../../bloc/notification_bloc/bloc/user_notification_bloc.dart';
import '../notification_screen/notifications_screen.dart';

class HomeGridViewScreen extends StatelessWidget {
  const HomeGridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // leading: Image(image: Asset.),
          centerTitle: true,
          title: Text('Hassan Allam Holding'),
          actions: [
            BlocProvider.value(
              value: BlocProvider.of<UserNotificationBloc>(context),
              child: BlocBuilder<UserNotificationBloc, UserNotificationState>(
                builder: (context, state) {
                  return Badge(
                    toAnimate: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    animationType: BadgeAnimationType.scale,
                    badgeColor: Colors.red,
                    badgeContent: Text(
                      "${state.notifications.length}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.only(
                    //   top: 150,
                    // ),
                    color: Colors.black87,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    key: UniqueKey(),
                    shrinkWrap: true,
                    children: [
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('Attendance')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(ContactsScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('Contact List')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('Benefits')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('HR Request')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('IT Request')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('Media Center')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('News')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('HA NewsLetter')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),
                      InkWell(onTap: ()=> Navigator.of(context).pushNamed(AttendanceScreen.routeName),child: Column(children: [Icon(Icons.access_time_filled),Text('Economy News')],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,)),

                    ],
                  ),
                ]),
          ),
        ));
  }
}
