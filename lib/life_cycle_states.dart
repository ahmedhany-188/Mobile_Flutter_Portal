import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:hassanallamportalflutter/setup_firebase_messaging.dart';


import 'bloc/auth_app_status_bloc/app_bloc.dart';
import 'bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'constants/constants.dart';
import 'gen/assets.gen.dart';
import 'main.dart';

class LifeCycleState extends StatefulWidget  {
  final Widget child;
  const LifeCycleState({Key? key, required this.child}) : super(key: key);

  @override
  LifeCycleStateState createState() => LifeCycleStateState();
}

class LifeCycleStateState extends State<LifeCycleState> with WidgetsBindingObserver {

  late Image image1;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    image1 = Assets.images.mainBackground.image();
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    SetupFirebaseMessaging(context);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(image1.image, context);
    super.didChangeDependencies();

  }


  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("life cycle --> started");
    }

        return widget.child;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    if (kDebugMode) {
      print("life cycle --> closed");
    }
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    final status = context
        .read<AppBloc>().state.status;
    if(state == AppLifecycleState.resumed){
      precacheImage(image1.image, context);
      if (kDebugMode) {
        print("life cycle -->resumed");
        print(status== AppStatus.authenticated ? "life cycle --> authenticated":"life cycle -->unauthenticated");
      }
      UserNotificationApiCubit.get(context).getNotificationsWithoutLoading();
      updateFirebaseWithStatus(AppLifecycleStatus.online);
      // unityWidgetController.resume();
    }else if (state == AppLifecycleState.inactive){
      if (kDebugMode) {
        print("life cycle -->inactive");
        print(status== AppStatus.authenticated ? "life cycle inactive --> authenticated":"life cycle inactive-->unauthenticated");
      }
      updateFirebaseWithStatus(AppLifecycleStatus.offline);
    }else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached){
      if (kDebugMode) {
        print("life cycle -->paused");
        print(status== AppStatus.authenticated ? "life cycle paused --> authenticated":"life cycle paused-->unauthenticated");
      }
      updateFirebaseWithStatus(AppLifecycleStatus.offline);
    }
  }

  updateFirebaseWithStatus(AppLifecycleStatus appLifecycleStatus){
    FirebaseProvider(context
        .read<AppBloc>().state.userData).updateUserOnline(appLifecycleStatus);
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
      // print("New token: $token");
      FirebaseProvider(context
          .read<AppBloc>().state.userData).onFirebaseTokenRefreshed(token);
    });

  }
}

