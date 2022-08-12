import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/login_cubit/login_cubit.dart';
import 'package:formz/formz.dart';
import 'login_form_widgets.dart';

class AuthForm extends StatefulWidget {

  const AuthForm({Key? key}) : super(key: key);
  static final FocusNode emailAddressFocusNode = FocusNode();
  static final FocusNode passwordFocusNode = FocusNode();
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: deviceSize.width / 1.5, ///before was 1.3

            ///oldValue 1.5
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UsernameInput(
                    emailAddressFocusNode: AuthForm.emailAddressFocusNode,
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  PasswordInput(passwordFocusNode: AuthForm.passwordFocusNode),
                  const Padding(padding: EdgeInsets.all(8)),
                  SizedBox(
                    width: deviceSize.width / 1.3,
                    child: const LoginButton(),
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
    Paint paint = Paint()..color = const Color(0xFFE9F4FF);

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
