
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/bloc/user_notification_bloc.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../data/helpers/convert_from_html.dart';
import '../../data/models/response_news.dart';


class NotificationsScreen extends StatefulWidget {
  static const routeName = 'notifications-screen';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: MainDrawer(),
        appBar:AppBar(title: const Text("Your Notification"),),/// basicAppBar(context, 'News'),
        backgroundColor: Colors.white,

        body: BlocBuilder<UserNotificationBloc, UserNotificationState>(
          builder: (context, state) {
            return Sizer(builder: (ctx, ori, dt) {
              return ConditionalBuilder(
                condition: state.notifications.isNotEmpty,
                builder: (context) {
                  // List<Data> newsList = newsAllData;
                  return Padding(
                    padding: EdgeInsets.all(5.0.sp),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.notifications.length,
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 1,
                      //   childAspectRatio: 2.sp,
                      //   crossAxisSpacing: 9.sp,
                      //   mainAxisSpacing: 9.sp,
                      // ),
                      itemBuilder: (ctx, index) {
                        FirebaseUserNotification notification = state.notifications[index];
                        return InkWell(
                          onTap: () {
                            // notification.

                            _pushForRequestDetail(notification);

                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       backgroundColor:
                            //           Theme.of(context).colorScheme.background,
                            //       title: Text(notification.from ?? ""),
                            //       elevation: 20,
                            //       contentPadding: const EdgeInsets.all(10.0),
                            //       content: SingleChildScrollView(
                            //         child: Column(
                            //           children: [
                            //             Text(notification.requestNo ?? ""),
                            //             Text(notification.type ?? ""),
                            //             Text(notification.requestType ?? ""),
                            //
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              elevation: 4,
                              shadowColor: Colors.white,
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                //leading: Icon(Icons.music_note),
                                title: Text(notification.requestNo ?? "",
                                    style: const TextStyle(color: Colors.black, fontSize: 16),textAlign: TextAlign.center),

                              ),
                            )// ListView.separated(
                            //
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return
                            //   }, itemCount: null,
                              // child: Text("${notification.requestNo}"),
                              // FadeInImage(
                              //   placeholder: const AssetImage('assets/images/logo.png'),
                              //   image: NetworkImage(
                              //     'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg',
                              //   ),
                              //   fit: BoxFit.fill,
                              // ),
                              // footer: GridTileBar(
                              //   title:Text( notification.from ?? "Tap to see more details",
                              //               style: const TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 18,
                              //               ),
                              //             ),
                              //   backgroundColor: Colors.black54,
                              // ),
                            ),
                          );

                      },
                    ),
                  );
                },
                fallback: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    Center(child: Text('Loading...')),
                  ],
                ),
              );
            });
          },
        ),
      );
  }

  _pushForRequestDetail(FirebaseUserNotification notification){
    if(notification.requestType!.contains("Vacation")){
      Navigator.of(context)
          .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey: notification.requestNo});
    }else if(notification.requestType!.contains("Business Mission")){
      Navigator.of(context)
          .pushNamed(BusinessMissionScreen.routeName,arguments: {BusinessMissionScreen.requestNoKey: notification.requestNo});
    }else if (notification.requestType!.contains("Permission")){
      Navigator.of(context)
          .pushNamed(PermissionScreen.routeName,arguments: {PermissionScreen.requestNoKey: notification.requestNo});
    }else if (notification.requestType!.contains("Embassy")){
      Navigator.of(context)
          .pushNamed(EmbassyLetterScreen.routeName,arguments: {EmbassyLetterScreen.requestNoKey: notification.requestNo});
    }
  }
}
