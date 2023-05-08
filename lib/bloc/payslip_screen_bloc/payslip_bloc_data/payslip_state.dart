part of 'payslip_cubit.dart';

enum PayslipDataEnumStates { loading, download, success, failed,validationSuccess,noConnection,validationFailed}

@immutable
abstract class PayslipState  extends Equatable{

  const PayslipState();
  const PayslipState.copyWith({
    required FormzStatus status});
}

class PayslipStateInitial  extends PayslipState {

  const PayslipStateInitial({
    this.payslipDataEnumStates = PayslipDataEnumStates.loading,
    this.pdf ="",
    this.months =  const [],
    this.response = "",
    this.error = "",
    this.status = FormzStatus.pure,
  });

  final PayslipDataEnumStates payslipDataEnumStates;
  final String pdf,response,error;
  final List<String> months;
  final FormzStatus status;

  @override
  List<Object> get props => [
    payslipDataEnumStates,pdf,
    months,response,
    error,
    status,
  ];

  PayslipStateInitial copyWith({
    PayslipDataEnumStates? payslipDataEnumStates,
    String? pdf,months,response,error,
    FormzStatus ?status,
  }) {
    return PayslipStateInitial(
      payslipDataEnumStates: payslipDataEnumStates ?? this.payslipDataEnumStates,
      pdf: pdf ?? this.pdf,
      months: months ?? this.months,
        response:response??this.response,
      error: error ?? this.error,
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
