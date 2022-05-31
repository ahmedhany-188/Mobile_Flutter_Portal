import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprung/sprung.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../screens/home_screen/taps_screen.dart';
import '../../screens/login_screen/auth_screen.dart';
import '../../widgets/animation/page_transition_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin {
  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation!);

    animation!.addStatusListener((status){
      if(status == AnimationStatus.completed){
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
              // duration: 2000,
              splashIconSize: deviceHeight,
              splashTransition: SplashTransition.fadeTransition,
              animationDuration: const Duration(milliseconds: 1000),
              splash: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    FadeTransition(
                      opacity: _fadeInFadeOut!,
                      child: SizedBox(
                        child: Center(
                          child: Image.asset(
                              'assets/images/login_image_logo.png',
                              fit: BoxFit.cover,scale: 2),
                        ),
                      ),
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 2500),
                      slidingCurve: Sprung.criticallyDamped,
                      slidingBeginOffset: const Offset(0.0, 0.05),
                      fadeIn: true,
                      fadingDuration: const Duration(milliseconds: 2000),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                fontFamily: 'RobotoFlex'
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
                                fontFamily: 'RobotoFlex'
                              ),
                            ),
                          ),

                          // DelayedDisplay(
                          //   delay: const Duration(milliseconds: 2500),
                          //   // slidingCurve: Sprung.underDamped,
                          //   slidingBeginOffset: const Offset(0.0, 0.0),
                          //   child: SizedBox(
                          //     width: deviceWidth,
                          //     child: DefaultTextStyle(
                          //       style: const TextStyle(
                          //         fontSize: 32.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //       child:  AnimatedTextKit(isRepeatingAnimation: false,
                          //         animatedTexts: [
                          //           FadeAnimatedText(' ',duration: Duration(milliseconds: 3000)),
                          //           // FadeAnimatedText('Welcome to'),
                          //           // FadeAnimatedText('Hassan Allam'),
                          //           RotateAnimatedText('Hello'),
                          //           RotateAnimatedText('Welcome to'),
                          //           RotateAnimatedText('Hassan Allam'),
                          //         ],
                          //         onTap: () {
                          //           print("Tap Event");
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 350,),
                        ],
                      ),
                    ),

                  ],
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
                  delayedDuration: 3000,
                  pageDirection: BlocBuilder<AppBloc, AppState>(
                    builder: (ctx, state) {
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
