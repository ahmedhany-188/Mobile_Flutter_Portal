
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_cubit.dart';
import '../../widgets/background/custom_background.dart';

class PayslipResetPasswordScreen extends StatefulWidget {
  static const routeName = 'payslip-reset-password-screen';
  // final TargetPlatform? platform;

  const PayslipResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<PayslipResetPasswordScreen> createState() => _PayslipResetPasswordScreenState();
}

class _PayslipResetPasswordScreenState  extends State<PayslipResetPasswordScreen> {

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
        await EasyLoading.dismiss(animation: true);
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
          body: BlocConsumer<PayslipCubit, PayslipState>(
            listener: (context, state) {
              if (state.payslipDataEnumStates ==
                  PayslipDataEnumStates.loading) {
                EasyLoading.show(status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,);
              } else if (state.payslipDataEnumStates == PayslipDataEnumStates.failed) {
                EasyLoading.showError(state.error);
              }
              else if (state.payslipDataEnumStates ==
                  PayslipDataEnumStates.success) {
                EasyLoading.showSuccess(state.response,);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [

                    const SizedBox(height: 10,),

                    const SizedBox(height: 10,),

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