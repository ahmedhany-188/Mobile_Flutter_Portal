import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/helpers/assist_function.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    final deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
        AuthForm.keyboardSubscription;
      },
      child: DelayedDisplay(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ///from here this is the container code
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 337,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(300),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_image_background_two.png'),
                              fit: BoxFit.fitWidth),
                        ))),
                Positioned(
                    top: 252,
                    left: 0,
                    child: Container(
                        width: 360,
                        height: 356,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ))),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 252,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80),
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/login_image_background.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),

                /// end of the containers code

                /// the light code
                Positioned(
                    top: -20,
                    left: -70,
                    child: Container(
                        width: deviceSize.width,
                        height: 252,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_image_light.png'),
                              fit: BoxFit.fitWidth),
                        ))),

                /// Centered Logo on the screen
                Positioned(
                    top: 56,
                    child: Container(
                        width: deviceSize.width / 1.5,
                        height: deviceSize.height / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_image_logo.png'),
                              fit: BoxFit.fitWidth),
                        ))),

                /// down buildings
                Positioned(
                    top: deviceSize.height / 1.4,
                    left: 0,
                    child: Container(
                        width: deviceSize.width,
                        height: deviceSize.height / 4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_image_buildings.png'),
                              fit: BoxFit.fitWidth),
                        ))),

                Positioned(
                  top: deviceSize.height / 2.5,
                  child: Container(
                    child: AuthForm(),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      // color: Color.fromRGBO(207, 222, 236, 1),
                    ),
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
