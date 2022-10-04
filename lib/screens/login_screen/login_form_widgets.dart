import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../bloc/login_cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator(color: Colors.white,))
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                // style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ))),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {

                      context.read<LoginCubit>().logInWithCredentials();
                      FocusManager.instance.primaryFocus?.unfocus();
                },
                // state.status.isValidated
                //     ? () => context.read<LoginCubit>().logInWithCredentials()
                //     : null,
                child: const Text(
                  'Sign in',
                  style:  TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              );
      },
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key}) : super(key: key);

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
                  onPressed:  () => context.read<LoginCubit>().logInWithCredentials()
                      ,
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
  const UsernameInput({Key? key, required this.emailAddressFocusNode})
      : super(key: key);
  final FocusNode emailAddressFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          focusNode: emailAddressFocusNode,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          decoration: InputDecoration(
            labelText: 'User Name',
            labelStyle: const TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.zero,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white38)
            ),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white,)
            ),
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key, required this.passwordFocusNode})
      : super(key: key);
  final FocusNode passwordFocusNode;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          focusNode: widget.passwordFocusNode,
          cursorColor: Colors.white,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: showPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              color: Colors.white,
              splashRadius: 1,
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: showPassword
                  ? const Icon(
                      Icons.visibility,

                    )
                  : const Icon(Icons.visibility_off,
              ),
            ),
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.zero,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38)
            ),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white,)
            ),
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}
