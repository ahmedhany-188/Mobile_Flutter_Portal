import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hassanallamportalflutter/bloc/apps_screen_bloc/apps_cubit.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/hr_request_bloc/hr_request_export.dart';
import 'package:hassanallamportalflutter/bloc/news_screen_bloc/news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'package:hassanallamportalflutter/bloc/photos_screen_bloc/photos_cubit.dart';
import 'package:hassanallamportalflutter/bloc/statistics_bloc/statistics_cubit.dart';
import 'package:hassanallamportalflutter/bloc/upgrader_bloc/app_upgrader_cubit.dart';
import 'package:hassanallamportalflutter/data/repositories/upgrader_repository.dart';
import 'package:hassanallamportalflutter/life_cycle_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:move_to_background/move_to_background.dart';
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

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  HydratedBlocOverrides.runZoned(
        () =>
        runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity())),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );

  configLoading();
  await GeneralDio.init();
  await AlbumDio.initAlbums();
}

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
  Widget buildWidget(Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          BlocProvider<ContactsCubit>(
            create: (contactsCubitContext) =>
            ContactsCubit()
              ..getContacts(),
            lazy: false,
          ),

          BlocProvider<WeatherBloc>(
            create: (weatherBlocContext) =>
            WeatherBloc()
              ..add(WeatherRequest()),
          ),
          BlocProvider<PayslipCubit>(
            create: (payslipContext) => PayslipCubit(),
          ),


          BlocProvider<EconomyNewsCubit>(
            create: (economyNewsCubitContext) => EconomyNewsCubit(),
          ),
          BlocProvider<GetDirectionCubit>(
            create: (getDirectionCubitContext) =>
            GetDirectionCubit()
              ..getDirection(),
          ),
          BlocProvider<BenefitsCubit>(
            create: (benefitsCubitContext) =>
            BenefitsCubit()
              ..getBenefits(),
          ),
          BlocProvider<SubsidiariesCubit>(
            create: (subsidiariesCubitContext) =>
            SubsidiariesCubit()
              ..getSubsidiaries(),
          ),

          // BlocProvider<MedicalRequestCubit>(
          //     create: (medicalRequestCubitContext) => MedicalRequestCubit()
          //   // MedicalRequestCubit()..getSuccessMessage(),
          // ),
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

          BlocProvider<AppBloc>(
            create: (authenticationContext) =>
                AppBloc(
                  authenticationRepository: authenticationRepository,
                ),
          ),

          BlocProvider<LoginCubit>(
            create: (authenticationContext) =>
                LoginCubit(authenticationRepository),
          ),
          BlocProvider<PhotosCubit>(
            create: (photosContext) =>
            PhotosCubit()
              ..getPhotos(),
          ),
          BlocProvider<VideosCubit>(
            create: (videosContext) =>
            VideosCubit()
              ..getVideos(),
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
            create: (userNotificationContext) =>
            UserNotificationApiCubit(
              RequestRepository(
                  BlocProvider
                      .of<AppBloc>(userNotificationContext)
                      .state
                      .userData),
            )
              ..getNotifications(),
          ),
          BlocProvider<AppUpgraderCubit>(
            lazy: false,
            create: (context) =>
            AppUpgraderCubit(
              UpgraderRepository(),
            )
              ..getUpgradeFromServer(context),
          ),

          BlocProvider<AppBloc>(
            create: (authenticationContext) =>
                AppBloc(
                  authenticationRepository: authenticationRepository,
                ),
          ),
          BlocProvider<AppsCubit>(
            create: (appsCubitContext) =>
            AppsCubit(GeneralDio(
                BlocProvider
                    .of<AppBloc>(appsCubitContext)
                    .state
                    .userData))
              ..getApps(),
          ),
          BlocProvider<MyRequestsCubit>(
            create: (myRequestCubitContext) =>
                MyRequestsCubit(
                    RequestRepository(
                        BlocProvider
                            .of<AppBloc>(myRequestCubitContext)
                            .state
                            .userData))..getRequests(),
          ),

          BlocProvider<AttendanceCubit>(
            create: (attendanceCubitContext) =>
                AttendanceCubit(
                BlocProvider
                    .of<AppBloc>(attendanceCubitContext)
                    .state
                    .userData.employeeData!.userHrCode.toString()),
          ),

          BlocProvider<StatisticsCubit>(
            create: (statisticsCubitContext) =>
            StatisticsCubit(GeneralDio(
                BlocProvider
                    .of<AppBloc>(statisticsCubitContext)
                    .state
                    .userData))
              ..getStatistics(),
          ),
          BlocProvider<NewsCubit>(
            create: (newsContext) =>
            NewsCubit()
              ..getNews()
              ..getLatestNews(),
            lazy: true,
          ),
          BlocProvider<ResponsibleVacationCubit>(
            create: (responsibleContext) => ResponsibleVacationCubit(),
            lazy: true,
          ),
          BlocProvider<SubsidiariesCubit>(
            create: (subsidiariesContext) => SubsidiariesCubit(),
            lazy: true,
          ),

          // BlocProvider<PermissionCubit>(
          //   create: (permissionContext) => PermissionCubit()..getRequestData(RequestStatus.newRequest),
          // ),
        ],
        child: LifeCycleState(
          child: WillPopScope(
            onWillPop: () async {
              MoveToBackground.moveTaskToBack();
              return false;
            },
            child: MaterialApp(
              title: 'Hassan Allam Portal',
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromRGBO(23, 72, 115, 1),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        primary: ConstantsColors.buttonColors)),
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
    // TODO: implement onClose
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
    // TODO: implement onError
    if (kDebugMode) {
      print("Error --> $bloc");
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    if (kDebugMode) {
      print("Event --> $bloc");
    }
    super.onEvent(bloc, event);
  }
}
