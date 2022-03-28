import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/contacts_screen_bloc/contacts_bloc_states.dart';
import 'bloc/contacts_screen_bloc/contacts_cubit.dart';
import 'bloc/home_screen_bloc/counter_cubit.dart';
import 'bloc/internet_connectivity_bloc/internet_cubit.dart';
import 'bloc/setting_screen_bloc/settings_cubit.dart';
import 'config/app_router.dart';
import 'data/data_providers/dio_provider.dart';
import 'screens/contacts_screen/contact_detail_screen.dart';
import 'screens/home_screen/taps_screen.dart';
import 'screens/login_screen/auth_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'widgets/drawer/main_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity())),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );

  DioProvider.init();
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
        ),
      ],
      child: MaterialApp(
        title: 'Hassan Allam Portal',
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
      print(bloc);
    }
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    if (kDebugMode) {
      print(bloc);
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
      print(bloc);
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
  }
}
