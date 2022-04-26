import 'dart:async';
import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/services.dart';
import 'package:sprung/sprung.dart';
import 'package:flutter/material.dart';
import 'package:entry/entry.dart';
import 'package:badges/badges.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

SizedBox addPaddingWhenKeyboardAppears() {
  final viewInsets = EdgeInsets.fromWindowPadding(
    WidgetsBinding.instance!.window.viewInsets,
    WidgetsBinding.instance!.window.devicePixelRatio,
  );

  final bottomOffset = viewInsets.bottom * 0.55;
  const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
  final isNeedPadding = bottomOffset != hiddenKeyboard;

  return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  // late StreamSubscription<bool> keyboardSubscription;
  // @override
  // void initState() {
  //   var keyboardVisibilityController = KeyboardVisibilityController();
  //
  //   keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
  //     print('Keyboard visibility update. Is visible: $visible');
  //   });
  //
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   keyboardSubscription.cancel();
  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double deviceTopPadding =MediaQueryData.fromWindow(window).padding.top;

    return GestureDetector(
      onTap: () {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
        AuthForm.keyboardSubscription;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: GridTile(
            // header: const Entry.offset(
            //   delay: Duration(milliseconds: 2000),
            //   duration: Duration(milliseconds: 2000),
            //   child: Text(
            //     'Hassan Allam New Portal',
            //     overflow: TextOverflow.clip,
            //     style: TextStyle(
            //       fontStyle: FontStyle.italic,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 30,
            //       letterSpacing: 2,
            //
            //     ),
            //   ),
            // ),
            child: SingleChildScrollView(
              physics: PageScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Entry.offset(
                    // opacity: 1,
                    curve: Sprung.overDamped,
                    delay: const Duration(milliseconds: 2000),
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(
                      'assets/images/buildings.png',
                      height: deviceSize.height * 0.3 - deviceTopPadding,
                      width: deviceSize.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.7,
                    child: AuthForm(),
                  ),
                  // addPaddingWhenKeyboardAppears(),
                  // const SizedBox(width: 5),
                  // Entry.offset(
                  //   curve: Sprung.criticallyDamped,
                  //   delay: const Duration(milliseconds: 1500),
                  //   duration: const Duration(milliseconds: 1000),
                  //   child: Image.asset(
                  //     'assets/images/middle.png',
                  //     height: deviceSize.height * .5,
                  //   ),
                  // ),
                  // // const SizedBox(width: 5),
                  // Entry.offset(
                  //   curve: Sprung.overDamped,
                  //   delay: const Duration(milliseconds: 1500),
                  //   duration: const Duration(milliseconds: 2500),
                  //   child: Image.asset(
                  //     'assets/images/right.png',
                  //     height: deviceSize.height * .4,
                  //   ),
                  // ),
                ],
              ),
            ),
            // footer:
            //     // Column(
            //     //   children: [
            //     //     // Container(
            //     //     //   width: deviceSize.width,
            //     //     //   // height: .59 * deviceSize.height,
            //     //     //   height: .24 * deviceSize.height,
            //     //     //   decoration: BoxDecoration(
            //     //     //     color: Colors.transparent.withOpacity(0.3),
            //     //     //     borderRadius: const BorderRadius.only(
            //     //     //       topLeft: Radius.circular(20),
            //     //     //       topRight: Radius.circular(20),
            //     //     //     ),
            //     //     //   ),
            //     //     //   // child:
            //     //     //   // DelayedDisplay(
            //     //     //   //   delay: const Duration(milliseconds: 2500),
            //     //     //   //   child: Container(
            //     //     //   //     // height: .59 * deviceSize.height,
            //     //     //   //     alignment: Alignment.bottomCenter,
            //     //     //   //     child: Entry.offset(
            //     //     //   //       xOffset: -1000,
            //     //     //   //       yOffset: 5,
            //     //     //   //       curve: Curves.easeInOutSine,
            //     //     //   //       delay: const Duration(milliseconds: 1500),
            //     //     //   //       duration: const Duration(milliseconds: 3000),
            //     //     //   //       child: Badge(
            //     //     //   //         elevation: 0,
            //     //     //   //         badgeColor: Colors.transparent,
            //     //     //   //         position: BadgePosition.topStart(
            //     //     //   //           top: -80,
            //     //     //   //           start: 0,
            //     //     //   //         ),
            //     //     //   //         animationDuration: Duration(milliseconds: 500),
            //     //     //   //         animationType: BadgeAnimationType.slide,
            //     //     //   //         badgeContent: Image.asset(
            //     //     //   //           'assets/images/1.png',
            //     //     //   //           scale: 6,
            //     //     //   //         ),
            //     //     //   //         // child:
            //     //     //   //       ),
            //     //     //   //     ),
            //     //     //   //   ),
            //     //     //   // ),
            //     //     // ),
            //     //     // DelayedDisplay(
            //     //     //   delay: Duration(milliseconds: 1500),
            //     //     //   child: Entry.offset(
            //     //     //     xOffset: -280,
            //     //     //     yOffset: 0,
            //     //     //     curve:
            //     //     //     // Sprung.custom(
            //     //     //         // stiffness: 180,
            //     //     //         // damping: 300,
            //     //     //         // mass: -9000.0,
            //     //     //         // velocity: 10.0),
            //     //     //     Curves.bounceIn,
            //     //     //     delay: const Duration(milliseconds: 1000),
            //     //     //     duration: const Duration(milliseconds: 3000),
            //     //     //     child: Badge(
            //     //     //       elevation: 0,
            //     //     //       badgeColor: Colors.transparent,
            //     //     //       position: BadgePosition.topStart(
            //     //     //         top: -90,
            //     //     //         start: 10,
            //     //     //       ),
            //     //     //       animationDuration: Duration(milliseconds: 2500),
            //     //     //       animationType: BadgeAnimationType.slide,
            //     //     //       badgeContent: Image.asset(
            //     //     //         'assets/images/1.png',
            //     //     //         scale: 6,
            //     //     //       ),
            //     //     //       child: const DelayedDisplay(
            //     //     //         delay: Duration(milliseconds: 4000),
            //     //     //         child:
            //     //
            //     //       SizedBox(
            //     //         height: deviceSize.height *0.85,
            //     //         child:
            //     Column(
            //   children: [
            //     SizedBox(
            //       height: deviceSize.height * 0.7,
            //       child: AuthForm(),
            //     ),
            //     addPaddingWhenKeyboardAppears(),
            //   ],
            // ),

            // ),
            // addPaddingWhenKeyboardAppears(),
            //       ),
            //     ),
            //   ),
            // ),
            // ],
            // ),
          ),
        ),
      ),
    );
  }
}
