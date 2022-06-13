import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/business_card_request/business_card_cubit.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/embassy_letter_request/embassy_letter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/apps_screen_bloc/apps_cubit.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
// import 'package:hassanallamportalflutter/bloc/hr_request_bloc/permission_cubit.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_detail_screen_bloc/my_requests_detail_cubit.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_screen_bloc/my_requests_cubit.dart';
import 'package:hassanallamportalflutter/bloc/news_screen_bloc/news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/bloc/user_notification_bloc.dart';
import 'package:hassanallamportalflutter/bloc/photos_screen_bloc/photos_cubit.dart';
import 'package:hassanallamportalflutter/data/data_providers/firebase_provider/FirebaseProvider.dart';
import 'package:hassanallamportalflutter/life_cycle_states.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
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
import 'bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'bloc/videos_screen_bloc/videos_cubit.dart';
import 'data/data_providers/album_dio/album_dio.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity())),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );

  await GeneralDio.init();
  await AlbumDio.initAlbums();

}

class MyApp extends StatefulWidget{
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
    final platform = Theme.of(context).platform;
    final AuthenticationRepository _authenticationRepository =
        AuthenticationRepository.getInstance();
    print("build");
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
          create: (contactsCubitContext) => ContactsCubit()..getContacts(),
          // child: ContactsScreen(),
        ),
        BlocProvider<WeatherBloc>(
          create: (weatherBlocContext) => WeatherBloc()..add(WeatherRequest()),
        ),
        BlocProvider<PayslipCubit>(
          create: (payslipContext) => PayslipCubit(),
        ),
        BlocProvider<AttendanceCubit>(
          create: (attendanceCubitContext) => AttendanceCubit(),
        ),
        BlocProvider<MedicalRequestCubit>(
            create: (medicalRequestCubitContext) => MedicalRequestCubit()
            // MedicalRequestCubit()..getSuccessMessage(),
            ),
        BlocProvider<EconomyNewsCubit>(
          create: (economyNewsCubitContext) => EconomyNewsCubit(),
        ),
        BlocProvider<MyRequestsDetailCubit>(
          create: (economyNewsCubitContext) => MyRequestsDetailCubit(),
        ),
        BlocProvider<GetDirectionCubit>(
          create: (getDirectionCubitContext) =>
              GetDirectionCubit()..getDirection(),
        ),
        BlocProvider<BenefitsCubit>(
          create: (benefitsCubitContext) => BenefitsCubit()..getBenefits(),
        ),
        BlocProvider<SubsidiariesCubit>(
          create: (subsidiariesCubitContext) =>
              SubsidiariesCubit()..getSubsidiaries(),
        ),

        BlocProvider<EmailUserAccountCubit>(
          create: (emailUserAccountRequestContext) =>
              EmailUserAccountCubit(),
        ),

        BlocProvider<EmbassyLetterCubit>(
          create: (embassyLetterContext) =>
              EmbassyLetterCubit(),
        ),

        BlocProvider<BusinessCardCubit>(
          create: (businessCardRequestContext) =>
              BusinessCardCubit(),
        ),

        BlocProvider<AccessRightCubit>(
          create: (accessRightAccountRequestContext) =>
              AccessRightCubit(),
        ),

        BlocProvider<MyRequestsCubit>(
          create: (travelRequestContext) =>
              MyRequestsCubit(),
        ),

        BlocProvider<AppBloc>(
          create: (authenticationContext) => AppBloc(
            authenticationRepository: _authenticationRepository,
          ),
        ),


        BlocProvider<LoginCubit>(
          create: (authenticationContext) =>
              LoginCubit(_authenticationRepository),
        ),
        BlocProvider<PhotosCubit>(
          create: (photosContext) => PhotosCubit()..getPhotos(),
        ),
        BlocProvider<VideosCubit>(
          create: (videosContext) => VideosCubit()..getVideos(),
        ),
        BlocProvider<UserNotificationBloc>(
          lazy: true,
          create: (userNotificationContext) => UserNotificationBloc(firebaseProvider: FirebaseProvider(BlocProvider.of<AppBloc>(userNotificationContext).state.userData.user!),),
        ),
        // BlocProvider<PermissionCubit>(
        //   create: (permissionContext) => PermissionCubit()..getRequestData(RequestStatus.newRequest),
        // ),
      ],
      child: LifeCycleState(
        child: MaterialApp(
          title: 'Hassan Allam Portal',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(23, 72, 115, 1),
            ),
            // primarySwatch: Colors.accents,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: widget.appRouter.onGenerateRoute,
        ),
      ));
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if(bloc is AppsCubit || bloc is ContactsCubit || bloc is NewsCubit){
      FocusManager.instance.primaryFocus?.unfocus();
    }
    if (kDebugMode) {
      // FocusManager.instance.primaryFocus?.unfocus();
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
