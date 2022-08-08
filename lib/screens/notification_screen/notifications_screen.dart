
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

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
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
    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);
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
                        // return InkWell(
                        //   onTap: () {
                        //     // notification.
                        //     _pushForRequestDetail(notification);
                        //   },
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(20),
                        //     child: Card(
                        //       elevation: 4,
                        //       shadowColor: Colors.white,
                        //       margin: EdgeInsets.all(10),
                        //       child: ListTile(
                        //         //leading: Icon(Icons.music_note),
                        //         title: Text(notification.requestNo ?? "",
                        //             style: const TextStyle(color: Colors.black, fontSize: 16),textAlign: TextAlign.center),
                        //
                        //       ),
                        //     )// ListView.separated(
                        //     //
                        //     //   itemBuilder: (BuildContext context, int index) {
                        //     //     return
                        //     //   }, itemCount: null,
                        //       // child: Text("${notification.requestNo}"),
                        //       // FadeInImage(
                        //       //   placeholder: const AssetImage('assets/images/logo.png'),
                        //       //   image: NetworkImage(
                        //       //     'https://portal.hassanallam.com/images/imgs/${news.newsID}.jpg',
                        //       //   ),
                        //       //   fit: BoxFit.fill,
                        //       // ),
                        //       // footer: GridTileBar(
                        //       //   title:Text( notification.from ?? "Tap to see more details",
                        //       //               style: const TextStyle(
                        //       //                 fontWeight: FontWeight.bold,
                        //       //                 fontSize: 18,
                        //       //               ),
                        //       //             ),
                        //       //   backgroundColor: Colors.black54,
                        //       // ),
                        //     ),
                        //   );

                        return Padding(

                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1a4c78),
                                    Color(0xFF3772a6),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  tileMode: TileMode.clamp),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                _pushForRequestDetail(notification);
                                // _pushForRequestDetail(context, listFromRequestScreen[index]);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 22.0.h,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${notification.from}'.trim(),
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '${notification.requestType}'.trim(),
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '# ${notification.requestNo}'.trim(),
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Flexible(
                                          //   fit: FlexFit.loose,
                                          //   child: Center(
                                          //     child: Text(
                                          //       '${notification.requestType} ${notification.requestNo}'.trim(),
                                          //       style: const TextStyle(
                                          //         fontSize: 14.0,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.white,
                                          //       ),
                                          //       maxLines: 1,
                                          //       // overflow: TextOverflow.ellipsis,
                                          //     ),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                                            child: Container(
                                              width: double.infinity,
                                              height: 0.2.h,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                // Text(
                                                //   '${listFromRequestScreen[index].statusName}'
                                                //       .trim(),
                                                //   style: const TextStyle(
                                                //     fontSize: 14.0,
                                                //     color: Colors.white,
                                                //   ),
                                                //   maxLines: 2,
                                                //   overflow: TextOverflow.ellipsis,
                                                //   textAlign: TextAlign.center,
                                                // ),

                                            Text(
                                            '${notification.type}',
                                              style: const TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.white,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                                // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                                Text(
                                                  '${notification.requesterHRCode}',
                                                  style: const TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),

                                          if(notification.type!.contains("Pending") && notification.requesterHRCode != userMainData.employeeData?.userHrCode)Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () {},
                                                      style:  OutlinedButton.styleFrom(
                                                          backgroundColor: Colors.green),
                                                      child: const Text('Accept',style: TextStyle(color: Colors.white)),
                                                      // color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12,),
                                                  // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () {  },
                                                      style:  OutlinedButton.styleFrom(
                                                          backgroundColor: Colors.red[800]),
                                                      child: const Text('Reject',style: TextStyle(color: Colors.white)),

                                                      // color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
          .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey: notification.requestNo,VacationScreen.requesterHRCode:notification.requesterHRCode});
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
