import 'dart:async';
import 'dart:core';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:badges/badges.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hassanallamportalflutter/bloc/login_cubit/login_cubit.dart';
import 'package:hassanallamportalflutter/data/helpers/assist_function.dart';
import 'package:hassanallamportalflutter/screens/home_screen/taps_screen.dart';
import 'package:hassanallamportalflutter/widgets/animation/page_transition_animation.dart';
import 'package:formz/formz.dart';
import 'login_form_widgets.dart';


class AuthForm extends StatefulWidget {
  // final bool isLoading;

  const AuthForm(
      // this.isLoading,
      // this.submitFn,
      );

  // final void Function(
  //   String email,
  //   String password,
  //   BuildContext ctx,
  // ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
  static FocusNode emailAddressFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();
  static late StreamSubscription<bool> keyboardSubscription;
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  // static FocusNode emailAddressFocusNode = FocusNode();
  // static FocusNode passwordFocusNode = FocusNode();
  // var isKeyboardOpened = false;

  var _userEmail = '';
  var _userPassword = '';

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

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please Login Correctly'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else {
      PageTransitionAnimation(
        pageDirection: TapsScreen(),
        delayedDuration: 0,
        context: context,
        transitionDuration: 500,
      ).navigateFromBottom();
    }

    if (isValid) {
      _formKey.currentState!.save();
      // widget.submitFn(
      //   _userEmail.trim(),
      //   _userPassword.trim(),
      //   context,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    var sizedBoxHeight = .7 * deviceSize.height;
    return GestureDetector(
      onTap: () {
        AuthForm.emailAddressFocusNode.unfocus();
        AuthForm.passwordFocusNode.unfocus();
      },
      child:
      BlocListener<LoginCubit, LoginState>(
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
        child: Badge(
          elevation: 0,
          badgeColor: Colors.transparent,
          position: BadgePosition.topStart(
            top: -50,
            start: 20,
          ),
          animationDuration: Duration(milliseconds: 2500),
          animationType: BadgeAnimationType.slide,
          badgeContent:
          // (AuthForm.emailAddressFocusNode.hasFocus ||
          //         AuthForm.passwordFocusNode.hasFocus)
          //     ? null
          //     :
          Image.asset(
            'assets/images/1.png',
            scale: 10,
          ),
          child:
          DelayedDisplay(
            delay: Duration(milliseconds: 0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: sizedBoxHeight,
                // height: .59 * deviceSize.height,
                child: Card(
                  color: Color(0xFFE9F4FF),
                  // clipBehavior: Clip.none,
                  // elevation: 50,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const UsernameInput(),
                            const Padding(padding: EdgeInsets.all(12)),
                            const PasswordInput(),
                            const Padding(padding: EdgeInsets.all(12)),
                            const LoginButton(),

                            // const Text(
                            //   'Sign In to see our updated Portal',
                            //   softWrap: true,
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //     color: Color(0xFF24346C),
                            //     fontStyle: FontStyle.italic,
                            //     decoration: TextDecoration.underline,
                            //   ),
                            // ),
                            //
                            // const SizedBox(height: 10),
                            // TextFormField(
                            //   key: const ValueKey('email'),
                            //   validator: (value) {
                            //     if (value!.isEmpty || !value.contains('@')) {
                            //       return 'Please enter a valid email address.';
                            //     }
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.emailAddress,
                            //   decoration: const InputDecoration(
                            //     prefixIcon: Icon(Icons.email),
                            //     filled: true,
                            //     labelText: 'Email address',
                            //   ),
                            //   onSaved: (value) {
                            //     _userEmail = value!;
                            //   },
                            //   focusNode: AuthForm.emailAddressFocusNode,
                            // ),
                            // const SizedBox(height: 10),
                            //
                            // TextFormField(
                            //   focusNode: AuthForm.passwordFocusNode,
                            //   validator: (value) {
                            //     if (value!.isEmpty || value.length < 7) {
                            //       return 'Password must be at least 7 characters long.';
                            //     }
                            //     return null;
                            //   },
                            //   decoration: const InputDecoration(
                            //     labelText: 'Password',
                            //     filled: true,
                            //     icon: Icon(Icons.vpn_key_rounded),
                            //     border: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(25)),
                            //     ),
                            //   ),
                            //   obscureText: true,
                            //   onSaved: (value) {
                            //     _userPassword = value!;
                            //   },
                            // ),
                            // const SizedBox(height: 10),
                            // // if (widget.isLoading) CircularProgressIndicator(),
                            // // if (!widget.isLoading)
                            // SizedBox(
                            //   width: double.infinity,
                            //   height: 50,
                            //   child: ElevatedButton.icon(
                            //     icon: const Icon(Icons.login),
                            //     style: ElevatedButton.styleFrom(
                            //       shape: const RoundedRectangleBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(25)),
                            //       ),
                            //     ),
                            //     label: const Text('Sign In'),
                            //     onPressed: _trySubmit,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),),
      // DelayedDisplay(
      //   delay: Duration(milliseconds: 1500),
      //   child: Entry.offset(
      //     xOffset: -280,
      //     yOffset: 0,
      //     curve:
      //         // Sprung.custom(
      //         // stiffness: 180,
      //         // damping: 300,
      //         // mass: -9000.0,
      //         // velocity: 10.0),
      //         Curves.bounceIn,
      //     delay: const Duration(milliseconds: 1000),
      //     duration: const Duration(milliseconds: 3000),
      //     child:

      //   ),
      // ),
    );
  }
}
