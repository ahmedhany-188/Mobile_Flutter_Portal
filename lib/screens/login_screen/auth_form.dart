import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hassanallamportalflutter/bloc/login_cubit/login_cubit.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/helpers/assist_function.dart';
import 'login_form_widgets.dart';

class AuthForm extends StatefulWidget {
  AuthForm();

  @override
  _AuthFormState createState() => _AuthFormState();
  static FocusNode emailAddressFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();
  static late StreamSubscription<bool> keyboardSubscription;
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();

    AuthForm.keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    AuthForm.keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var sizedBoxHeight = .6 * deviceSize.height;
    return GestureDetector(
      onTap: () {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
      },
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: sizedBoxHeight,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 50, top: 50),
                      child: UsernameInput(
                        emailAddressFocusNode: AuthForm.emailAddressFocusNode,
                      ),
                    ),
                    // Padding(padding: EdgeInsets.all(12)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 50, top: 50),
                      child: PasswordInput(
                          passwordFocusNode: AuthForm.passwordFocusNode),
                    ),
                    // Padding(padding: EdgeInsets.all(12)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 50, top: 30, bottom: 10),
                      child: LoginButton(),
                    ),
                    addPaddingWhenKeyboardAppears(),
                  ],
                ),
              ),
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
    path.moveTo(size.width, 300);
    // path.lineTo(size.width, 0);

    // path.quadraticBezierTo(
    //     size.height, size.height * 0.10, size.width, size.width * 0.5);

    path.quadraticBezierTo(
      size.width,
      size.width * 1.2,

      100,
      size.height,

    );
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFE9F4FF);

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.height * -1.5,
      size.height * 0.1,
      size.width,
      size.width * -0.15,
    );
    path.quadraticBezierTo(
      size.height,
      size.height * 0.1,
      size.width,
      size.width * 0.3,
    );
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
