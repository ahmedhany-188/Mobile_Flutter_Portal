import 'dart:convert';

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
import 'package:hassanallamportalflutter/screens/news_screen/news_screen.dart';
import 'package:hassanallamportalflutter/screens/videos_screen/videos_screen.dart';

import 'bloc/auth_app_status_bloc/app_bloc.dart';
import 'constants/constants.dart';
import 'main.dart';

class SetupFirebaseMessaging{
  final BuildContext context;
  SetupFirebaseMessaging(this.context){
    setupFirebaseMessaging();
  }
  Future<void> setupFirebaseMessaging() async {

    // final messaging = FirebaseMessaging.instance;
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();


    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);


    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   description: 'This channel is used for important notifications.', // description
    //   importance: Importance.max,
    // );
    //
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   RemoteNotification? notification = message.notification;
      //   AndroidNotification? android = message.notification?.android;
      //
      //   // If `onMessage` is triggered with a notification, construct our own
      //   // local notification to show to users using the created channel.
      //   // if (android != null) {
      //   //   FlutterLocalNotificationsPlugin.show(
      //   //       notification.hashCode,
      //   //       notification?.title,
      //   //       notification?.body,
      //   //       NotificationDetails(
      //   //         android: AndroidNotificationDetails(
      //   //           channel.id,
      //   //           channel.name,
      //   //           channelDescription: channel.description,
      //   //           icon: android.smallIcon,
      //   //           // other properties...
      //   //         ),
      //   //       ));
      //   // }
      // });
    } else {
      print('User declined or has not accepted permission');
    }

    // //open notif content from terminated state of the app
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //
    //     // print('TERMINATED');
    //     // final redirectRoute = message.data['route'];
    //     // print('redirectRoute $redirectRoute');
    //     // // bottomnavbarController.updateIndex(int.parse(redirectRoute));
    //     // //remove redirect route here, so the unknownRoute will trigger the default route
    //   }
    // });
    //
    // //only works if app in foreground
    // FirebaseMessaging.onMessage.listen((message) {
    //   // LocalNotificationService.display(message);
    // });
    //
    // //onclick notif system tray only works if app in background but not termi
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   // final redirectRoute = message.data['route'];
    //   // if (redirectRoute != null) {
    //   //   print('BACKGROUND');
    //   //   print('redirectRoute $redirectRoute');
    //   //
    //   //   // bottomnavbarController.updateIndex(int.parse(redirectRoute));
    //   //   // Get.offAllNamed(Routes.PAGEWRAPPER);
    //   // }
    // });
  }
  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      print("_handleMessage");
    }
    _onSelectNotificationMessage(jsonEncode(message.data));
    // if (message.data.containsKey("requestType")) {
    //   if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryPermissionActivity)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               PermissionScreen(requestData: {
    //                 PermissionScreen.requestNoKey: message.data['requestNo'],
    //                 PermissionScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   } else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryBusinessMissionActivity)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               BusinessMissionScreen(requestData: {
    //                 BusinessMissionScreen.requestNoKey: message
    //                     .data['requestNo'],
    //                 BusinessMissionScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    //   else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryVacationActivity)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               VacationScreen(requestData: {
    //                 VacationScreen.requestNoKey: message.data['requestNo'],
    //                 VacationScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    //   else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryEmbassyActivity)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               EmbassyLetterScreen(requestData: {
    //                 EmbassyLetterScreen.requestNoKey: message.data['requestNo'],
    //                 EmbassyLetterScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    //   else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryBusniessCardActivity)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               BusinessCardScreen(requestData: {
    //                 BusinessCardScreen.requestNoKey: message.data['requestNo'],
    //                 BusinessCardScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    //   else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryUserAccount)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               EmailAndUserAccountScreen(requestData: {
    //                 EmailAndUserAccountScreen.requestNoKey: message
    //                     .data['requestNo'],
    //                 EmailAndUserAccountScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    //   else if (message.data['requestType'].toString()
    //       .contains(GlobalConstants.requestCategoryAccessRight)) {
    //     Future.delayed(Duration.zero).then((_) {
    //       Navigator.push(
    //           NavigationService.navigatorKey.currentContext ?? context,
    //           MaterialPageRoute(builder:
    //               (context) =>
    //               AccessRightScreen(requestData: {
    //                 AccessRightScreen.requestNoKey: message.data['requestNo'],
    //                 AccessRightScreen.requesterHRCode: message
    //                     .data['requesterHRCode']
    //               },)));
    //     });
    //   }
    // }
  }
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<void> setupFlutterNotifications() async {
    if (kDebugMode) {
      print("setupFlutterNotifications");
    }
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }
  void showFlutterNotification(RemoteMessage message) {
    if (kDebugMode) {
      print("show flutter notification");
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    setupFlutterNotifications();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,

        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,

            //  add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'favicon',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@drawable/logo');
    var initializationSettingsIOs = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (_)=> _onSelectNotificationMessage);
  }
  void _onSelectNotificationMessage(String? json) async {

    final messageData = jsonDecode(json!);
    if (kDebugMode) {
      print("_handleMessage");
    }
    if (messageData.containsKey("requestType")) {
      if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryPermissionActivity)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  PermissionScreen(requestData: {
                    PermissionScreen.requestNoKey: messageData['requestNo'],
                    PermissionScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryBusinessMissionActivity)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  BusinessMissionScreen(requestData: {
                    BusinessMissionScreen
                        .requestNoKey: messageData['requestNo'],
                    BusinessMissionScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"?
                    messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryVacationActivity)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  VacationScreen(requestData: {
                    VacationScreen.requestNoKey: messageData['requestNo'],
                    VacationScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryEmbassyActivity)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  EmbassyLetterScreen(requestData: {
                    EmbassyLetterScreen.requestNoKey: messageData['requestNo'],
                    EmbassyLetterScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryBusniessCardActivity)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  BusinessCardScreen(requestData: {
                    BusinessCardScreen.requestNoKey: messageData['requestNo'],
                    BusinessCardScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryUserAccount)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  EmailAndUserAccountScreen(requestData: {
                    EmailAndUserAccountScreen
                        .requestNoKey: messageData['requestNo'],
                    EmailAndUserAccountScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
      else if (messageData['requestType'].toString()
          .contains(GlobalConstants.requestCategoryAccessRight)) {
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  AccessRightScreen(requestData: {
                    AccessRightScreen.requestNoKey: messageData['requestNo'],
                    AccessRightScreen
                        .requesterHRCode: messageData['type'].toString().toLowerCase() == "submit"? messageData['requesterHRCode']:context
                        .read<AppBloc>().state.userData.employeeData?.userHrCode
                  },)));
        });
      }
    }
    else if (messageData.containsKey("type")){
      if(messageData['type'].toString()
          .contains(GlobalConstants.allNotificationVideoType)){
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
                  const VideosScreen()));
        });
      }else if(messageData['type'].toString()
          .contains(GlobalConstants.allNotificationNewsType)){
        Future.delayed(Duration.zero).then((_) {
          Navigator.push(
              NavigationService.navigatorKey.currentContext ?? context,
              MaterialPageRoute(builder:
                  (context) =>
              const NewsScreen()));
        });
      }
    }
  }
}