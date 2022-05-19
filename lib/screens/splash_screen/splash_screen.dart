import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../screens/home_screen/taps_screen.dart';
import '../../screens/login_screen/auth_screen.dart';
import '../../widgets/animation/page_transition_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

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
          child: AnimatedSplashScreen.withScreenFunction(
              centered: false,
              disableNavigation: true,
              backgroundColor: Colors.transparent,
              curve: Curves.linear,
              duration: 2000,
              splashIconSize: deviceHeight,
              splashTransition: SplashTransition.fadeTransition,
              animationDuration: const Duration(milliseconds: 1000),
              splash: DelayedDisplay(
                delay: Duration.zero,
                slidingCurve: Curves.linear,slidingBeginOffset: const Offset(0.0, 0.1),
                fadeIn: true,
                fadingDuration: const Duration(milliseconds: 600),
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
              // nextScreen: BlocBuilder<AppBloc, AppState>(
              //   builder: (context, state) {
              //     switch (state.status) {
              //       case AppStatus.authenticated:
              //         return const TapsScreen();
              //       case AppStatus.unauthenticated:
              //         return AuthScreen();
              //       default:
              //         return const AuthScreen();
              //     }
              //   },
              // ),
              screenFunction: () {
                return PageTransitionAnimation(
                  transitionDuration: 1500,
                  context: context,
                  delayedDuration: 0,
                  pageDirection: BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case AppStatus.authenticated:
                          return const TapsScreen();
                        case AppStatus.unauthenticated:
                          return const AuthScreen();
                        default:
                          return const AuthScreen();
                      }
                    },
                  ),
                ).navigateWithFading();
              }),
        ),
      ),
    );
  }
}
