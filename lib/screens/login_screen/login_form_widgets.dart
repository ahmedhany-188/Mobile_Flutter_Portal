import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/login_cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 20,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ))),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class GradientButton extends StatelessWidget {
  GradientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFF186597),
                      Color(0xFF174873),
                      // Color(0xFF42A5F5),
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: state.status.isValidated
                      ? () => context.read<LoginCubit>().logInWithCredentials()
                      : null,
                  child: const Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              );
      },
    );
  }
}

class UsernameInput extends StatelessWidget {
  UsernameInput({Key? key, required this.emailAddressFocusNode})
      : super(key: key);
  FocusNode emailAddressFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          focusNode: emailAddressFocusNode,
          cursorColor: Colors.white,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFcfdeec),
            prefixIcon: Icon(Icons.email,
                color: (emailAddressFocusNode.hasFocus)
                    ? Color(0xFF186597)
                    : Color(0xFF174873)),
            hintText: 'Enter your email',
            hintStyle: TextStyle(color: Color(0xFFa2b6c9)),
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  PasswordInput({Key? key, required this.passwordFocusNode}) : super(key: key);
  FocusNode passwordFocusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          focusNode: passwordFocusNode,
          cursorColor: Colors.white,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFcfdeec),
            hintText: 'Enter your password',
            hintStyle: const TextStyle(color: Color(0xFFa2b6c9)),
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}
