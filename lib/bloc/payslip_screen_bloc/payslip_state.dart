part of 'payslip_cubit.dart';


enum PayslipDataEnumStates {initial, loading, download, success, failed,noConnection}


class PayslipState  extends Equatable {

  final PayslipDataEnumStates payslipDataEnumStates;
  final String pdf,response,error;
  final List<String> months;

  PayslipState({
    this.payslipDataEnumStates = PayslipDataEnumStates.loading,
    this.pdf ="",
    this.months =  const [],
    this.response = "",
    this.error = "",
  });

  PayslipState copyWith({
    PayslipDataEnumStates? payslipDataEnumStates,
    String? pdf,months,response,error
  }) {
    return PayslipState(
      payslipDataEnumStates: payslipDataEnumStates ?? this.payslipDataEnumStates,
      pdf: pdf ?? this.pdf,
      months: months ?? this.months,
        response:response??this.response,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    payslipDataEnumStates,pdf,months,response,error
  ];
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
