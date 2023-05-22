import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_bloc_reset_password/payslip_cubit_reset_password.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_bloc_reset_password/payslip_state_reset_password.dart';
import '../../widgets/background/custom_background.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_reset_new_password_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';

class PayslipResetPasswordScreen extends StatefulWidget {
  static const routeName = 'payslip-reset-password-screen';
  // final TargetPlatform? platform;
  const PayslipResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<PayslipResetPasswordScreen> createState() => _PayslipResetPasswordScreenState();
}

class _PayslipResetPasswordScreenState  extends State<PayslipResetPasswordScreen> {

  final FocusNode passwordFocusNode = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData.user);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(
          PayslipScreen.routeName,
        );
        return true;
      },
      child: CustomBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Payslip Reset Password"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // centerTitle: true,
          ),
          body: BlocConsumer<PayslipResetPasswordCubit, PayslipResetPasswordStateInitial>(
            listener: (context, state) {
              if (state.status.isSubmissionInProgress) {
                EasyLoading.show(status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,);
              } else if (state.status.isSubmissionFailure) {
                EasyLoading.showError(state.error);
              }
              else if (state.status.isSubmissionSuccess) {
                EasyLoading.showSuccess(state.response,);
                Navigator.of(context).pushReplacementNamed(
                  PayslipResetNewPasswordScreen.routeName,
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    TextFormField(
                      initialValue:"Email:",
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    TextFormField(
                      initialValue:user?.email,
                      readOnly: true,
                      style: const TextStyle(color: Color(0xFFa2b6c9)),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[200],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.read<PayslipResetPasswordCubit>()
                            .sendVerificationRequest(user?.userHRCode??"");
                      },
                      // child: const Text("Download Payslip"),
                      child: const Text("Send Request and Close Account"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}