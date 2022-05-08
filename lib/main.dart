import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/economy_news_screen_bloc/economy_news_cubit.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/screens/economy_news_screen/economy_news_screen.dart';
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
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  // WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
  );
  HydratedBlocOverrides.runZoned(
        () => runApp(MyApp(
          appRouter: AppRouter(),
          connectivity: Connectivity())),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );

  await GeneralDio.init();

}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final platform = Theme.of(context).platform;
    final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
    _authenticationRepository.init();
    // final AuthenticationBloc authenticationBloc = AuthenticationBloc(authenticationRepository);
    // final Repositor = AuthenticationRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
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
          create: (attendanceCubitContext) =>
              AttendanceCubit()..getAttendanceList(),
        ),
        BlocProvider<MedicalRequestCubit>(
          create: (medicalRequestCubitContext) => MedicalRequestCubit()
          // MedicalRequestCubit()..getSuccessMessage(),
        ),

        BlocProvider<EconomyNewsCubit>(
          create: (economyNewsCubitContext) => EconomyNewsCubit(),
        ),

        BlocProvider<GetDirectionCubit>(
          create: (getDirectionCubitContext) =>
              GetDirectionCubit()..getDirection(),
        ),
        BlocProvider<BenefitsCubit>(
          create: (benefitsCubitContext) =>
          BenefitsCubit()..getBenefits(),
        ),
        BlocProvider<SubsidiariesCubit>(
          create: (subsidiariesCubitContext) =>
          SubsidiariesCubit()..getSubsidiaries(),
        ),
        BlocProvider<AppBloc>(
          create: (authenticationContext) =>
              AppBloc(authenticationRepository: _authenticationRepository,),),
        BlocProvider<LoginCubit>(
          create: (authenticationContext) =>
              LoginCubit(_authenticationRepository),),
      ],
      child: MaterialApp(
        title: 'Hassan Allam Portal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
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
