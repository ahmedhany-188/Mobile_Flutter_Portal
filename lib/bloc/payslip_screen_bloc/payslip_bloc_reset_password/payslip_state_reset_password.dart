import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';

enum PayslipDataEnumStates {initial, loading, download, success, failed,noConnection}

@immutable
abstract class PayslipResetPasswordState  extends Equatable{

  const PayslipResetPasswordState();
  const PayslipResetPasswordState.copyWith({
    required  RequestDate verificationCode,required RequestDate password,
    required RequestDate passwordConfirm,
    required FormzStatus status});
}

class PayslipResetPasswordStateInitial  extends Equatable {

  const PayslipResetPasswordStateInitial({
    this.payslipDataEnumStates = PayslipDataEnumStates.loading,
    this.response = "",
    this.error = "",
    this.verificationCode = const RequestDate.pure(),
    this.password = const RequestDate.pure(),
    this.passwordConfirm = const RequestDate.pure(),
    this.status = FormzStatus.pure,
  });

  final PayslipDataEnumStates payslipDataEnumStates;
  final String response,error;
  final RequestDate verificationCode;
  final RequestDate password;
  final RequestDate passwordConfirm;
  final FormzStatus status;

  @override
  List<Object> get props => [
    payslipDataEnumStates,response,
    error,verificationCode,
    password,passwordConfirm,
    status,
  ];

  PayslipResetPasswordStateInitial copyWith({
    PayslipDataEnumStates? payslipDataEnumStates,
    String? pdf,months,response,error,
    RequestDate? verificationCode,
    RequestDate? password,
    RequestDate? passwordConfirm,
    FormzStatus ?status,
  }) {
    return PayslipResetPasswordStateInitial(
      payslipDataEnumStates: payslipDataEnumStates ?? this.payslipDataEnumStates,
      response:response??this.response,
      error: error ?? this.error,
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      status: status ?? this.status,
    );
  }


}


// @immutable
// abstract class PayslipState {}
// class PayslipInitialState extends PayslipState{}
// class PayslipLoadingState extends PayslipState{}
// class PayslipDownloadState extends PayslipState{
//   final String response;
//   PayslipDownloadState(this.response);
// }
// class PayslipSuccessState extends PayslipState{
//   final String response;
//   PayslipSuccessState(this.response);
// }
//
// class PayslipErrorState extends PayslipState {
//   final String error;
//   PayslipErrorState(this.error);
// }
