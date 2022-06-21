import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/upgrader_bloc/app_upgrader_cubit.dart';
import 'package:hassanallamportalflutter/life_cycle_states.dart';
import 'package:sprung/sprung.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../data/helpers/assist_function.dart';
import '../../screens/home_screen/taps_screen.dart';
import '../../screens/login_screen/auth_screen.dart';
import '../../widgets/animation/page_transition_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation!);

    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation!.reverse();
      }
      // else if(status == AnimationStatus.dismissed){
      //   animation!.clearListeners();
      // }
    });
    animation!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    final double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/S_Background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: BlocConsumer<AppUpgraderCubit, AppUpgraderInitial>(
            listener: (context, state) {
              // TODO: implement listener
              if (state.appUpgrader == AppUpgrader.needUpdate) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) =>
                    Platform.isAndroid ? AlertDialog(
                      content: Text(state.upgrader.android?.message ??
                          "The update is really important"),
                      title: const Text("HAH Portal New Version"),
                      actions: [
                        TextButton(
                          child: const Text("Update"),
                          onPressed: () {
                            BlocProvider.of<AppUpgraderCubit>(context).onUpdateAction();
                          },
                        ),
                        if(!(state.upgrader.android?.force ?? false))
                        TextButton(
                          child: const Text("Later"),
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<AppUpgraderCubit>(context).onLaterAction();
                          },
                        ),
                      ],
                    ) : CupertinoAlertDialog(
                      title: const Text("HAH Portal New Version"),
                      content: Text(state.upgrader.ios?.message ??
                          "The update is really important"),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text("Update"),
                          onPressed: (){
                            BlocProvider.of<AppUpgraderCubit>(context).onUpdateAction();
                          },

                        ),
                        if(!(state.upgrader.ios?.force ?? false))
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: (){
                              Navigator.pop(context);
                              BlocProvider.of<AppUpgraderCubit>(context).onLaterAction();
                            },
                            child: const Text("Later"),
                          ),
                      ],
                    )
                );
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
                        // duration: 2000,
                        splashIconSize: deviceHeight,
                        splashTransition: SplashTransition.fadeTransition,
                        animationDuration: const Duration(milliseconds: 1000),
                        splash: Stack(
                          children: [
                            Positioned(
                              top: -40,
                              left: -55,
                              child: DelayedDisplay(
                                delay: const Duration(milliseconds: 1500),
                                slidingBeginOffset: const Offset(0, 0),
                                // slidingCurve: Sprung.criticallyDamped,
                                child: SizedBox(
                                  width: deviceWidth,
                                  height: 300,
                                  child: Image.asset(
                                    'assets/images/login_image_light.png',
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                              ),
                            ),
                            FadeTransition(
                              opacity: _fadeInFadeOut!,
                              child: SizedBox(
                                child: Center(
                                  child: Image.asset(
                                      'assets/images/login_image_logo.png',
                                      fit: BoxFit.cover, scale: 2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: DelayedDisplay(
                                delay: const Duration(milliseconds: 2500),
                                slidingCurve: Sprung.criticallyDamped,
                                slidingBeginOffset: const Offset(0.0, 0.05),
                                fadeIn: true,
                                fadingDuration: const Duration(
                                    milliseconds: 2000),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                        child: Text(
                                          checkTimeAmPm()
                                              ? 'Good Morning'
                                              : 'Good Evening',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 70,
                                              letterSpacing: 4,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'RobotoFlex'),
                                        )),
                                    const Flexible(
                                      child: Text(
                                        'Welcome To Hassan Allam Portal',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            letterSpacing: 4,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RobotoFlex'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 350,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        screenFunction: () {
                          return PageTransitionAnimation(
                            transitionDuration: 1500,
                            context: context,
                            delayedDuration: 3000,
                            pageDirection: BlocBuilder<AppBloc, AppState>(
                              builder: (ctx, state) {
                                switch (state.status) {
                                  case AppStatus.authenticated:
                                    FirebaseProvider(state.userData.user!)
                                        .updateUserOnline(
                                        AppLifecycleStatus.online);
                                    return const TapsScreen();
                                // return AlertUpgradeShow();
                                  case AppStatus.unauthenticated:
                                    return const AuthScreen();

                                  default:
                                    return const AuthScreen();

                                }
                              },
                            ),
                          ).navigateWithFading();
                        });
                  } else {
                    return Container(
                      child: SizedBox(
                        child: Center(
                          child: Image.asset(
                              'assets/images/login_image_logo.png',
                              fit: BoxFit.cover, scale: 2),
                        ),),
                    );
                  }
                },
              );
            },
          ),
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
    return Container(
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("hi"),
        ));
  }
}
