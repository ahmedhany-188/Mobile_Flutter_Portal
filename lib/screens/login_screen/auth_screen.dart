import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprung/sprung.dart';

import 'auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 3000),() {
      _controller.forward();
    },);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              image: DecorationImage(
                  image: AssetImage('assets/images/S_Background.png'),
                  fit: BoxFit.fill)),
          child: DelayedDisplay(
            slidingCurve: Curves.ease,
            delay: Duration.zero,
            slidingBeginOffset: const Offset(0,0),
            child: Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ///from here this is the container code
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          width: deviceSize.width,
                          height: 337,

                          /// oldValue 337
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
                          width: deviceSize.width,
                          height: deviceSize.height,
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
                      width: deviceSize.width,
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
                    top: -30,
                    left: -70,
                    // child: DelayedDisplay(
                    //   delay: const Duration(milliseconds: 3000),
                    child: SizedBox(
                      width: deviceSize.width,
                      height: 252,
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage(
                      //           'assets/images/login_image_light.png'),
                      //       ),
                      // ),
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 3000),
                        slidingBeginOffset: const Offset(0,0),
                        slidingCurve: Sprung.criticallyDamped,
                        child: RotationTransition(
                          turns:Tween(begin: 0.15, end: 0.0).animate(_controller),
                          child: Image.asset(
                              'assets/images/login_image_light.png'),
                        ),
                      ),
                    ),
                  ),
                  // ),

                  /// Centered Logo on the screen
                  Positioned(
                    top: 56,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 1500),
                      slidingCurve: Sprung.underDamped,
                      child: Container(
                        width: deviceSize.width / 1.5,
                        height: deviceSize.height / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/login_image_logo.png'),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),

                  /// down buildings
                  Positioned(
                    top: deviceSize.height / 1.3,
                    // left: 0,
                    child: Container(
                      width: deviceSize.width,
                      height: deviceSize.height / 4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/login_image_buildings.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),

                  /// form widget
                  Positioned(
                    top: deviceSize.height / 2.3,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 2000),
                      slidingCurve: Sprung.underDamped,
                      child: AuthForm(),
                    ),
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
