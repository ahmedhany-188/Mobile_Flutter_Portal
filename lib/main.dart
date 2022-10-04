import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/repositories/medical_request_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hassanallamportalflutter/bloc/apps_screen_bloc/apps_cubit.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/employee_appraisal_screen_bloc/employee_appraisal_bloc_cubit.dart';
import 'package:hassanallamportalflutter/bloc/hr_request_bloc/hr_request_export.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/bloc/news_screen_bloc/news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'package:hassanallamportalflutter/bloc/photos_screen_bloc/photos_cubit.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_job_bloc/staff_dashboard_job_cubit.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_project_bloc/staff_dashboard_project_cubit.dart';
import 'package:hassanallamportalflutter/bloc/statistics_bloc/statistics_cubit.dart';
import 'package:hassanallamportalflutter/bloc/upgrader_bloc/app_upgrader_cubit.dart';
import 'package:hassanallamportalflutter/data/repositories/attendance_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/employee_appraisal_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_job_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_project_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_repository.dart';
import 'package:hassanallamportalflutter/data/repositories/upgrader_repository.dart';
import 'package:hassanallamportalflutter/life_cycle_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:move_to_background/move_to_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import './data/data_providers/general_dio/general_dio.dart';
import './bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import './bloc/weather_bloc/weather_bloc.dart';
import './bloc/contacts_screen_bloc/contacts_cubit.dart';
import './bloc/home_screen_bloc/counter_cubit.dart';
import './bloc/internet_connectivity_bloc/internet_cubit.dart';
import './bloc/setting_screen_bloc/settings_cubit.dart';
import './config/app_router.dart';
import './bloc/benefits_screen_bloc/benefits_cubit.dart';
import './bloc/myattendance_screen_bloc/attendance_cubit.dart';
import './bloc/payslip_screen_bloc/payslip_cubit.dart';
import './bloc/subsidiaries_screen_bloc/subsidiaries_cubit.dart';
import 'bloc/auth_app_status_bloc/app_bloc.dart';
import 'bloc/login_cubit/login_cubit.dart';
import 'bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'bloc/videos_screen_bloc/videos_cubit.dart';
import 'constants/colors.dart';
import 'data/data_providers/album_dio/album_dio.dart';
import 'data/repositories/request_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterServicesBinding.ensureInitialized();

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Paint.enableDithering = true;
  await FlutterDownloader.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity())),
    storage: storage,
    // createStorage: () async {
    //   WidgetsFlutterBinding.ensureInitialized();
    //   return HydratedStorage.build(
    //     storageDirectory: kIsWeb
    //         ? HydratedStorage.webStorageDirectory
    //         : await getTemporaryDirectory(),
    //   );
    // },
    blocObserver: AppBlocObserver(),
  );

  configLoading();
  // await GeneralDio.init();
  await AlbumDio.initAlbums();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("_firebaseMessagingBackgroundHandler");
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

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

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
  //   systemNavigationBarColor: ConstantsColors.bottomSheetBackgroundDark,
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   systemNavigationBarDividerColor: ConstantsColors.bottomSheetBackgroundDark,
  // );

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final platform = Theme.of(context).platform;
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository.getInstance();
    // _authenticationRepository.init();

    // LifeCycleStates(context);

    // final AuthenticationBloc authenticationBloc = AuthenticationBloc(authenticationRepository);
    // final Repositor = AuthenticationRepository();
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (internetCubitContext) =>
                InternetCubit(connectivity: widget.connectivity),
          ),
          BlocProvider<CounterCubit>(
            create: (counterCubitContext) => CounterCubit(),
          ),
          BlocProvider<SettingsCubit>(
            create: (counterCubitContext) => SettingsCubit(),
          ),
          BlocProvider<WeatherBloc>(
            create: (weatherBlocContext) =>
                WeatherBloc()..add(WeatherRequest()),
          ),
          BlocProvider<AppBloc>(
            create: (authenticationContext) => AppBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<ContactsCubit>(
            create: (contactsCubitContext) => ContactsCubit(GeneralDio(
                BlocProvider.of<AppBloc>(contactsCubitContext).state.userData))..getContacts(),
            lazy: true,
          ),
          BlocProvider<PayslipCubit>(
            create: (payslipContext) => PayslipCubit(
                PayslipRepository(
                    BlocProvider.of<AppBloc>(payslipContext)
                        .state
                        .userData)
            ),
          ),

          BlocProvider<EconomyNewsCubit>(
            create: (economyNewsCubitContext) => EconomyNewsCubit(),
          ),
          BlocProvider<GetDirectionCubit>(
            create: (getDirectionCubitContext) =>
                GetDirectionCubit(GeneralDio(
                    BlocProvider.of<AppBloc>(getDirectionCubitContext).state.userData))..getDirection(),
          ),
          BlocProvider<BenefitsCubit>(
            create: (benefitsCubitContext) => BenefitsCubit(GeneralDio(
                BlocProvider.of<AppBloc>(benefitsCubitContext).state.userData))..getBenefits(),
          ),
          BlocProvider<SubsidiariesCubit>(
            create: (subsidiariesCubitContext) =>
                SubsidiariesCubit(GeneralDio(
                    BlocProvider.of<AppBloc>(subsidiariesCubitContext).state.userData))..getSubsidiaries(),
          ),

          BlocProvider<MedicalRequestCubit>(
              create: (medicalRequestCubitContext) => MedicalRequestCubit(
                MedicalRepository(
                    BlocProvider.of<AppBloc>(medicalRequestCubitContext)
                        .state
                        .userData),
              ),
          ),

          BlocProvider<AttendanceCubit>(
            create: (attendanceCubitContext) => AttendanceCubit(
              AttendanceRepository(
                  BlocProvider.of<AppBloc>(attendanceCubitContext)
                      .state
                      .userData),
            ),
          ),


          // BlocProvider<EmailUserAccountCubit>(
          //   create: (emailUserAccountRequestContext) =>
          //       EmailUserAccountCubit(),
          // ),
          // BlocProvider<EmbassyLetterCubit>(
          //   create: (embassyLetterContext) =>
          //       EmbassyLetterCubit(),
          // ),
          // BlocProvider<BusinessCardCubit>(
          //   create: (businessCardRequestContext) =>
          //       BusinessCardCubit(),
          // ),
          // BlocProvider<AccessRightCubit>(
          //   create: (accessRightAccountRequestContext) =>
          //       AccessRightCubit(),
          // ),



          BlocProvider<LoginCubit>(
            create: (authenticationContext) =>
                LoginCubit(authenticationRepository),
          ),
          BlocProvider<PhotosCubit>(
            create: (photosContext) => PhotosCubit()..getPhotos(),
          ),
          BlocProvider<VideosCubit>(
            create: (videosContext) => VideosCubit()..getVideos(),
          ),
          // BlocProvider<UserNotificationBloc>(
          //   lazy: true,
          //   create: (userNotificationContext) => UserNotificationBloc(
          //     firebaseProvider: FirebaseProvider(
          //         BlocProvider.of<AppBloc>(userNotificationContext)
          //             .state
          //             .userData),
          //   ),
          // ),

          BlocProvider<UserNotificationApiCubit>(
              lazy: true,
              create: (userNotificationContext){
                    if (kDebugMode) {
                      print('token ${BlocProvider.of<AppBloc>(userNotificationContext)
                        .state
                        .userData.user?.token}');
                    }
                return UserNotificationApiCubit(
                      RequestRepository(
                          BlocProvider.of<AppBloc>(userNotificationContext)
                              .state
                              .userData),
                    );
                  }
              // ..getNotifications(),
              ),
          BlocProvider<AppUpgraderCubit>(
            lazy: false,
            create: (context) => AppUpgraderCubit(
              UpgraderRepository(),
            )..getUpgradeFromServer(context),
          ),

          BlocProvider<AppBloc>(
            create: (authenticationContext) => AppBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<AppsCubit>(
            create: (appsCubitContext) => AppsCubit(GeneralDio(
                BlocProvider.of<AppBloc>(appsCubitContext).state.userData))
              ..getApps(),
          ),
          BlocProvider<MyRequestsCubit>(
            create: (myRequestCubitContext) => MyRequestsCubit(
                RequestRepository(
                    BlocProvider.of<AppBloc>(myRequestCubitContext)
                        .state
                        .userData))
              ..getRequests(),
          ),

          BlocProvider<AttendanceCubit>(
            create: (attendanceCubitContext) => AttendanceCubit(
            AttendanceRepository(
                BlocProvider.of<AppBloc>(attendanceCubitContext)
                    .state
                    .userData),
          ),
          ),

          BlocProvider<EmployeeAppraisalBlocCubit>(
            create: (employeeAppraisalContext) => EmployeeAppraisalBlocCubit(
              EmployeeAppraisalRepository(
                  BlocProvider.of<AppBloc>(employeeAppraisalContext)
                      .state
                      .userData),
            ),
          ),

          BlocProvider<StaffDashboardCubit>(
            create: (staffDashBoardCubitContext) => StaffDashboardCubit(
              StaffDashBoardRepository(
                    BlocProvider.of<AppBloc>(staffDashBoardCubitContext)
                        .state
                        .userData),
            ),
          ),

          BlocProvider<StaffDashboardProjectCubit>(
            create: (staffDashBoardProjectCubitContext) =>
                StaffDashboardProjectCubit(
                    StaffDashBoardProjectRepository(
                        BlocProvider.of<AppBloc>(staffDashBoardProjectCubitContext)
                            .state
                            .userData)
                        ),
          ),

          BlocProvider<StaffDashboardJobCubit>(
            create: (staffDashBoardJobCubitContext) => StaffDashboardJobCubit(
                StaffDashBoardJobRepository(
                      BlocProvider.of<AppBloc>(staffDashBoardJobCubitContext)
                          .state
                          .userData)
              ),
          ),

          BlocProvider<StatisticsCubit>(
            create: (statisticsCubitContext) => StatisticsCubit(GeneralDio(
                BlocProvider.of<AppBloc>(statisticsCubitContext)
                    .state
                    .userData))
              ..getStatistics(),
          ),
          BlocProvider<NewsCubit>(
            create: (newsContext) => NewsCubit(GeneralDio(
                BlocProvider.of<AppBloc>(newsContext).state.userData))
              ..getNewsOld()
              ..getLatestNews(),
            lazy: true,
          ),
          BlocProvider<ResponsibleVacationCubit>(
            create: (responsibleContext) => ResponsibleVacationCubit(GeneralDio(
                BlocProvider.of<AppBloc>(responsibleContext).state.userData)),
            lazy: true,
          ),
          BlocProvider<SubsidiariesCubit>(
            create: (subsidiariesContext) => SubsidiariesCubit(GeneralDio(
                BlocProvider.of<AppBloc>(subsidiariesContext).state.userData)),
            lazy: true,
          ),

          // BlocProvider<PermissionCubit>(
          //   create: (permissionContext) => PermissionCubit()..getRequestData(RequestStatus.newRequest),
          // ),
        ],
        child: LifeCycleState(
          child: WillPopScope(
            onWillPop: () async {
              // MoveToBackground.moveTaskToBack();
              return false;
            },
            child: MaterialApp(
              title: 'Hassan Allam Portal',
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              themeMode: ThemeMode.system,
              darkTheme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ConstantsColors.buttonColors)),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                // colorScheme: ColorScheme.fromSeed(
                //   seedColor: const Color.fromRGBO(23, 72, 115, 1),
                // ),
              ),
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromRGBO(23, 72, 115, 1),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ConstantsColors.buttonColors)),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: widget.appRouter.onGenerateRoute,
            ),
          ),
        ));
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print("Change --> $bloc");
    }
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      print("Close --> $bloc");
    }
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      print(bloc);
    }
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print("Error --> $bloc");
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      print("Event --> $bloc");
    }
    super.onEvent(bloc, event);
  }
}
