import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/services.dart';
import 'package:sprung/sprung.dart';
import 'package:flutter/material.dart';
import 'package:entry/entry.dart';

import 'auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    final deviceSize = MediaQuery.of(context).size;
    final double deviceTopPadding =
        MediaQueryData.fromWindow(window).padding.top;

    return GestureDetector(
      onTap: () {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
        AuthForm.keyboardSubscription;
      },
      child: Container(
        height: deviceSize.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_background.png"),
                fit: BoxFit.fitHeight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DelayedDisplay(
                  delay: Duration(milliseconds: 2000),
                  child: Image.asset(
                    'assets/images/login_background.png',
                    // height: deviceSize.height * 0.3 - deviceTopPadding,
                    width: deviceSize.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Entry.offset(
                  // opacity: 1,
                  curve: Sprung.overDamped,
                  delay: const Duration(milliseconds: 2000),
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: CustomClipPath(),
                        child: Container(
                          height: 100,
                          width: deviceSize.width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100)),
                              color: Colors.white),
                        ),
                      ),
                      AuthForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
  // firstPoint.dx, firstPoint.dy);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    // path.lineTo(size.width, 0);

    // path.quadraticBezierTo(
    //     size.height, size.height * 0.10, size.width, size.width * 0.5);

    path.quadraticBezierTo(
      size.width / 1.05,
      size.width / 3.4,
      260,
      size.height,
    );
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Container(
// height: deviceSize.height,
// decoration: const BoxDecoration(
// image: DecorationImage(
// image: AssetImage("assets/images/login_background.png"),
// fit: BoxFit.fitHeight)),
// child: Scaffold(
// backgroundColor: Colors.transparent,
// resizeToAvoidBottomInset: false,
// extendBodyBehindAppBar: true,
// body: SingleChildScrollView(
// physics: const PageScrollPhysics(),
// child: Column(
// // mainAxisSize: MainAxisSize.min,
// // mainAxisAlignment: MainAxisAlignment.center,
// // crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// DelayedDisplay(
// delay: Duration(milliseconds: 2000),
// child: Image.asset(
// 'assets/images/login_background.png',
// // height: deviceSize.height * 0.3 - deviceTopPadding,
// width: deviceSize.width,
// fit: BoxFit.fitWidth,
// ),
// ),
// Entry.offset(
// // opacity: 1,
// curve: Sprung.overDamped,
// delay: const Duration(milliseconds: 2000),
// duration: const Duration(milliseconds: 1000),
// child: Column(
// children: [
// ClipPath(
// clipper: CustomClipPath(),
// child: Container(
// height: 100,
// width: deviceSize.width,
// decoration: const BoxDecoration(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(100)),
// color: Colors.white),
// ),
// ),
// AuthForm(),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// ),