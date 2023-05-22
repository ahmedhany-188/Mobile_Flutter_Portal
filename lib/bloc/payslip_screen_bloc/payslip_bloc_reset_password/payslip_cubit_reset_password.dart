import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_bloc_reset_password/payslip_state_reset_password.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/payslip_repository.dart';



class PayslipResetPasswordCubit extends Cubit<PayslipResetPasswordStateInitial> {

  final Connectivity connectivity = Connectivity();

  PayslipResetPasswordCubit(this.payslipRepository)
      : super(const PayslipResetPasswordStateInitial());

  static PayslipResetPasswordCubit get(context) => BlocProvider.of(context);
  final PayslipRepository payslipRepository;

  @override
  Future<void> close() {
    EasyLoading.dismiss();
    return super.close();
  }

  void getSubmitResetPassword(String? hrCode, String ?email) async {
    final verificationCode = RequestDate.dirty(state.verificationCode.value);
    final password = RequestDate.dirty(state.password.value);
    final passwordConfirm = RequestDate.dirty(state.passwordConfirm.value);

    String? newEmail = email?.replaceAll("@hassanallam.com", "");
    emit(state.copyWith(
      verificationCode: verificationCode,
      password: password,
      passwordConfirm: passwordConfirm,
      status: Formz.validate([verificationCode, password, passwordConfirm]),
    ));

    if (state.status.isValidated) {
      emit(state.copyWith(
          status: FormzStatus.submissionInProgress));

      if (password == passwordConfirm) {
        try {
          var connectivityResult = await connectivity.checkConnectivity();
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
            final response = await payslipRepository.sentResetPassword(
                hrCode,newEmail,password.value, verificationCode.value);
            if (response.error==false) {
              emit(state.copyWith(
                  response: response.message,
                  status: FormzStatus.submissionSuccess));
            } else {
              emit(state.copyWith(
                error: response.message,
                status: FormzStatus.submissionFailure,
              ),
              );
            }
          } else {
            emit(
              state.copyWith(
                error: "No internet Connection",
                status: FormzStatus.submissionFailure,
              ),
            );
          }
        } catch (ex) {
          emit(
            state.copyWith(
              error: ex.toString(),
              status: FormzStatus.submissionFailure,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            error: "Password Mismatch",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  void addPassword(String value) {
    final password = RequestDate.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate(
          [state.verificationCode, password, state.passwordConfirm]),
    ));
  }

  void confirmPassword(String value) {
    final confirmPassword = RequestDate.dirty(value);
    emit(state.copyWith(
      passwordConfirm: confirmPassword,
      status: Formz.validate(
          [state.verificationCode, state.password, confirmPassword]),
    ));
  }

  void verificationCode(String value) {
    final verificationCode = RequestDate.dirty(value);
    emit(state.copyWith(
      verificationCode: verificationCode,
      status: Formz.validate(
          [verificationCode, state.password, state.passwordConfirm]),
    ));
  }

  void sendVerificationRequest(String hrCode) async {
    emit(state.copyWith(
        status: FormzStatus.submissionInProgress));
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        final response = await payslipRepository.sentVerificationPassword(
            hrCode);
        if (response.error == false) {
          emit(state.copyWith(
              response: "Send Successfully",
              status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(
            error: "An error occurred", status: FormzStatus.submissionFailure,
          ),
          );
        }
      } else {
        emit(
          state.copyWith(
            error: "No internet Connection",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    } catch (ex) {
      emit(
        state.copyWith(
          error: ex.toString(),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}



