import 'dart:ui';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:badges/badges.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/screens/home_screen/home_screen.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:sprung/sprung.dart';

import '../../widgets/animation/page_transition_animation.dart';
import '../../screens/login_screen/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedSplashScreen(
        splashIconSize: deviceWidth * 2,
        curve: Curves.linear,
        disableNavigation: true,
        duration: 1500,
        centered: false,
        splash: Stack(
          children: [
            Image.asset(
              'assets/images/S_Background.png',
              fit: BoxFit.fill,
              width: deviceWidth,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 1000),
              slidingCurve: Curves.decelerate,
              fadeIn: true,
              fadingDuration: Duration(milliseconds: 1500),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Welcome To Hassan Allam Portal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Sizer(
        //   builder: (BuildContext context, Orientation orientation,
        //       DeviceType deviceType) {
        //     return Image.asset(
        //           'assets/images/S_Background.png',width: deviceWidth.w,
        //         );
        //   },
        // ),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        animationDuration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.transparent,
        nextScreen: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                return const TapsScreen();
              case AppStatus.unauthenticated:
                return const AuthScreen();
              default:
                return AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
