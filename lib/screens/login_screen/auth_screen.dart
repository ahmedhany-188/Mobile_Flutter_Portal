import 'dart:ui';

import 'package:hassanallamportalflutter/data/helpers/assist_function.dart';
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                const Flexible(
                  child: AuthForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
