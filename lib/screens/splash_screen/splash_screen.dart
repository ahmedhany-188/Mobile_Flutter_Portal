import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hassanallamportalflutter/bloc/upgrader_bloc/app_upgrader_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../screens/login_screen/auth_screen.dart';
import '../../widgets/animation/page_transition_animation.dart';
import '../home_screen/home_grid_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // with TickerProviderStateMixin {
  // late AnimationController animation;
  // Animation<double>? _fadeInFadeOut;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   animation = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 1000),
  //   );
  //   _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
  //
  //   animation.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       animation.reverse();
  //     }
  //     // else if(status == AnimationStatus.dismissed){
  //     //   animation!.clearListeners();
  //     // }
  //   });
  //   animation.forward();
  // }
  //
  // @override
  // void dispose() {
  //   animation.dispose(); /// must be before super.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // FlutterNativeSplash.remove();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: const Color(0xFF031A27),
        child: BlocConsumer<AppUpgraderCubit, AppUpgraderInitial>(
          listener: (context, state) {
            if (state.appUpgrader == AppUpgrader.needUpdate) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Platform.isAndroid
                      ? AlertDialog(
                          content: Text(state.upgrader.android?.message ??
                              "The update is really important"),
                          title: const Text("HAH Portal New Version"),
                          actions: [
                            TextButton(
                              child: const Text("Update"),
                              onPressed: () {
                                BlocProvider.of<AppUpgraderCubit>(context)
                                    .onUpdateAction();
                              },
                            ),
                            if (!(state.upgrader.android?.force ?? false))
                              TextButton(
                                child: const Text("Later"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  BlocProvider.of<AppUpgraderCubit>(context)
                                      .onLaterAction();
                                },
                              ),
                          ],
                        )
                      : CupertinoAlertDialog(
                          title: const Text("HAH Portal New Version"),
                          content: Text(state.upgrader.ios?.message ??
                              "The update is really important"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("Update"),
                              onPressed: () {
                                BlocProvider.of<AppUpgraderCubit>(context)
                                    .onUpdateAction();
                              },
                            ),
                            if (!(state.upgrader.ios?.force ?? false))
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                  BlocProvider.of<AppUpgraderCubit>(context)
                                      .onLaterAction();
                                },
                                child: const Text("Later"),
                              ),
                          ],
                        ));
            }
          },
          builder: (context, state) {
            return BlocBuilder<AppUpgraderCubit, AppUpgraderInitial>(
              builder: (context, state) {
                if (state.appUpgrader == AppUpgrader.noNeedUpdate ||
                    state.appUpgrader == AppUpgrader.failure) {
                  return AnimatedSplashScreen.withScreenFunction(
                      centered: false,
                      disableNavigation: true,
                      backgroundColor: Colors.transparent,
                      curve: Curves.linear,
                      splashIconSize: deviceHeight,
                      splashTransition: SplashTransition.fadeTransition,
                      // animationDuration: const Duration(milliseconds: 1000),
                      splash: Stack(
                        children: [
                          Align(
                            widthFactor: double.infinity,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                Assets.images.welcomeImage.path,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey.shade700,
                                  period: const Duration(milliseconds: 3000),
                                  child: const Text(
                                    '\u00a9 2023 IT Department All Rights Reserved',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                // Container(
                                //   color: Colors.red,
                                //   height: 20,
                                //   width: MediaQuery.of(context).size.width,
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      screenFunction: () {
                        return PageTransitionAnimation(
                          transitionDuration: 500,
                          context: context,
                          delayedDuration: 1500,
                          pageDirection: BlocBuilder<AppBloc, AppState>(
                            builder: (ctx, state) {
                              switch (state.status) {
                                case AppStatus.authenticated:
                                  FirebaseProvider(state.userData)
                                      .updateUserOnline(
                                          AppLifecycleStatus.online);
                                  return const HomeGridViewScreen();
                                case AppStatus.unauthenticated:
                                  return const AuthScreen();

                                default:
                                  return const AuthScreen();
                              }
                            },
                          ),
                        ).navigateFromBottom();
                      });
                } else {
                  return Container(
                    color: const Color(0xFF031A27),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class AlertUpgradeShow extends StatelessWidget {
  const AlertUpgradeShow({Key? key}) : super(key: key);

  // Wrapper Widget
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Container();
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("hi"),
            ));
  }
}
