import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_bloc_reset_password/payslip_cubit_reset_password.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_bloc_reset_password/payslip_state_reset_password.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';
import '../../widgets/background/custom_background.dart';

class PayslipResetNewPasswordScreen extends StatefulWidget {
  static const routeName = 'payslip-reset-new-password-screen';

  const PayslipResetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<PayslipResetNewPasswordScreen> createState() => _PayslipResetNewPasswordScreenState();
}

class _PayslipResetNewPasswordScreenState  extends State<PayslipResetNewPasswordScreen> {

  final FocusNode passwordFocusNode = FocusNode();
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
        child: CustomTheme(
          child: BlocProvider<PayslipResetPasswordCubit>(
            create: (payslipContext) => (PayslipResetPasswordCubit(PayslipRepository(user))),
            child: BlocBuilder<PayslipResetPasswordCubit, PayslipResetPasswordStateInitial>(
                builder: (context, state) {
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        title: const Text("Payslip Reset Password"),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // centerTitle: true,
                      ),
                      floatingActionButton: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: ConstantsColors.bottomSheetBackground,
                        onPressed: () {
                          context.read<PayslipResetPasswordCubit>()
                              .getSubmitResetPassword();
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('SUBMIT'),
                      ),
                      body: BlocListener<PayslipResetPasswordCubit, PayslipResetPasswordStateInitial>(
                        listener: (context, state) {
                          if (state.status.isSubmissionInProgress) {
                            EasyLoading.show(status: 'Loading...',
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: false,);
                          } else if (state.status.isSubmissionFailure) {
                            EasyLoading.showError(state.error);
                          }
                          else if (state.status.isSubmissionSuccess) {
                            EasyLoading.showSuccess(state.error,);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: user.employeeData?.email,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    labelText: 'E-mail',
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: Colors.white70,),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<
                                      PayslipResetPasswordCubit,
                                      PayslipResetPasswordStateInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          initialValue: state.verificationCode.value,
                                          onChanged: (value) {
                                            context.read<
                                                PayslipResetPasswordCubit>()
                                                .verificationCode(value);
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Verification code',
                                            prefixIcon: const Icon(
                                              Icons.shield,
                                              color: Colors.white70,),
                                            errorText: state.verificationCode
                                                .invalid
                                                ? 'invalid Phone Number'
                                                : null,
                                          ),
                                        );
                                      }
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<
                                      PayslipResetPasswordCubit,
                                      PayslipResetPasswordStateInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          initialValue: state.password.value,
                                          obscureText: showPassword,
                                          onChanged: (value) {
                                            context.read<
                                                PayslipResetPasswordCubit>()
                                                .addPassword(value);
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Create Password',
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: showPassword
                                                  ? const Icon(
                                                  Icons.visibility,
                                                  color: Colors.white70
                                              )
                                                  : const Icon(Icons.visibility_off,
                                                  color: Colors.white38),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.password,
                                              color: Colors.white70,),
                                            errorText: state.password.invalid
                                                ? 'invalid Phone Number'
                                                : null,
                                          ),
                                        );
                                      }
                                  )
                              ),

                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<
                                      PayslipResetPasswordCubit,
                                      PayslipResetPasswordStateInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          initialValue: state.passwordConfirm.value,
                                          obscureText: true,
                                          onChanged: (value) {
                                            context.read<
                                                PayslipResetPasswordCubit>()
                                                .confirmPassword(value);
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Confirm Password',
                                            prefixIcon: const Icon(
                                              Icons.password,
                                              color: Colors.white70,),
                                            errorText: state.passwordConfirm
                                                .invalid
                                                ? 'invalid Phone Number'
                                                : null,
                                          ),
                                        );
                                      })
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
            ),
          ),
        ),
      ),
    );
  }
}