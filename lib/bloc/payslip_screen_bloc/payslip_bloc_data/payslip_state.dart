part of 'payslip_cubit.dart';

enum PayslipDataEnumStates { loading, download, success, failed,validationSuccess,noConnection,validationFailed,initialLoading,exite}

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
    this.payslipOpen = 0,
  });

  final PayslipDataEnumStates payslipDataEnumStates;
  final String pdf,response,error;
  final List<String> months;
  final FormzStatus status;
  final int payslipOpen;

  @override
  List<Object> get props => [
    payslipDataEnumStates,pdf,
    months,response,
    error,
    status,
    payslipOpen,
  ];

  PayslipStateInitial copyWith({
    PayslipDataEnumStates? payslipDataEnumStates,
    String? pdf,months,response,error,
    FormzStatus ?status,
    int ?payslipOpen,
  }) {
    return PayslipStateInitial(
      payslipDataEnumStates: payslipDataEnumStates ?? this.payslipDataEnumStates,
      pdf: pdf ?? this.pdf,
      months: months ?? this.months,
        response:response??this.response,
      error: error ?? this.error,
      status: status ?? this.status,
      payslipOpen: payslipOpen ?? this.payslipOpen,
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
