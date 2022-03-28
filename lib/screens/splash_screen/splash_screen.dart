import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:sprung/sprung.dart';

import '../../widgets/animation/page_transition_animation.dart';
import 'package:hassanallamportalflutter/screens/login_screen/auth_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   // AnimationController? _controller;
//   // Animation<Offset>? offset;
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller =
//   //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
//   //
//   //   offset = Tween<Offset>(
//   //       begin: Offset(Alignment.bottomCenter.x, Alignment.bottomCenter.y),
//   //       end: Offset(Alignment.topCenter.x, Alignment.topCenter.y))
//   //       .animate(_controller!);
//   // }
//   //
//   // Future<void> loopOnce(BuildContext context)async{
//   //   await _controller!.forward();
//   //   await _controller!.reverse();
//   //   //we can add duration here
//   //   //await Future.delayed(Duration(seconds: 4));
//   //   Navigator.of(context).push(MaterialPageRoute( // since this triggers when the animation is done, no duration is needed
//   //     builder: (context) => AuthScreen(),
//   //   ));
//   // }
//   AnimationController? _controller;
//   Animation<double>? _animation;
//   int state = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller = AnimationController(
//     //     vsync: this, duration: const Duration(milliseconds: 3000), value: 0);
//
//     // Future.delayed(Duration.zero, () async {
//     //   FadeAnimation(AuthScreen(), context).navigate();
//     // });
//
//   //   SchedulerBinding.instance!.addPostFrameCallback((_) => PageTransitionAnimation(
//   //           pageDirection: AuthScreen(),
//   //           context: context,
//   //           delayedDuration: 3000,
//   //           transitionDuration: 1500)
//   //       .navigateFromBottom()); //i add this to access the context safely.
//   }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceTopPadding =MediaQueryData.fromWindow(window).padding.top;
    final double resizeElements = deviceHeight * -0.09 - (deviceTopPadding) ;
    final double resizeCar = deviceHeight * -0.132 - (deviceTopPadding);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: AnimatedSplashScreen.withScreenFunction(
          splashIconSize: deviceWidth,
          curve: Sprung.criticallyDamped,
          disableNavigation: true,
          duration: 2000,
          centered: true,

          splash: Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return SizedBox(
                height: deviceHeight.h - deviceTopPadding.h,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  // alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      left: 20.sp,
                      bottom: 250.sp,
                      // height: 100,
                      child: Image.asset(
                        'assets/images/fulllogoblue.png',
                        scale: 1.sp,
                      ),
                    ),
                    Positioned(
                      bottom: resizeElements.sp,
                      // height: 100,
                      child: Entry.all(
                        opacity: 1,
                        curve: Sprung.criticallyDamped,
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1500),
                        child: Image.asset(
                          'assets/images/far.png',
                          width: deviceWidth,
                          height: deviceHeight.h * 0.1.sp,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: resizeElements.sp,
                      child: Entry.offset(
                        // opacity: 1,
                        curve: Sprung.overDamped,
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1500),
                        child: Image.asset(
                          'assets/images/close.png',
                          width: deviceWidth,
                          height: deviceHeight.h * 0.1.sp,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: resizeCar,
                      left: 10,
                      child: Entry.offset(
                        xOffset: -280,
                        yOffset: 0,
                        curve: Curves.bounceIn,
                        delay: const Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 2000),
                        child: Badge(
                          elevation: 0,
                          badgeColor: Colors.transparent,
                          position: BadgePosition.topStart(
                            top: 0.sp * (MediaQuery.of(context).size.aspectRatio *0.7),
                            start: 10.sp,
                          ),
                          animationDuration: Duration(milliseconds: 2000),
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Image.asset(
                            'assets/images/1.png',
                            scale: 10,
                          ),
                          child: Container(
                            height: 60,
                            width: 100,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Column(verticalDirection: VerticalDirection.down, mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Image(
          //       image: AssetImage('assets/images/logo.png'),
          //       fit: BoxFit.cover,
          //       width: deviceWidth * 0.3,
          //       height: deviceHeight * 0.4,
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Text(
          //       'Hassan Allam Holding',
          //       style: TextStyle(
          //           fontSize: 30,
          //           fontWeight: FontWeight.w900,
          //           fontFamily: 'assets/fonts/RobotoCondensed-Bold.ttf',
          //           letterSpacing: 2,
          //           color: Theme.of(context).colorScheme.primary),
          //     ),
          //   ],
          // ),
          // pageTransitionType: PageTransitionType.bottomToTop,
          animationDuration: const Duration(milliseconds: 3000),
          backgroundColor: Colors.transparent,
          // nextScreen: AuthScreen(),
          screenFunction: () {
            return PageTransitionAnimation(
                    pageDirection: AuthScreen(),
                    context: context,
                    delayedDuration: 500,
                    transitionDuration: 1300)
                .navigateFromBottom();
          },
        ),
      ),
    );
  }
}

/// PageTransitionAnimation(pageDirection: AuthScreen(), context: context, delayedDuration: 2000, transitionDuration: 3000).navigateFromBottom()
