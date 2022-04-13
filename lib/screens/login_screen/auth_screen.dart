import 'dart:ui';

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
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double deviceTopPadding =
        MediaQueryData.fromWindow(window).padding.top;

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
