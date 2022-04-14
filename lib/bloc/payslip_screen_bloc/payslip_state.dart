part of 'payslip_cubit.dart';

@immutable
abstract class PayslipState {}
class PayslipInitialState extends PayslipState{}
class PayslipLoadingState extends PayslipState{}
class PayslipDownloadState extends PayslipState{
  final String response;
  PayslipDownloadState(this.response);
}
class PayslipSuccessState extends PayslipState{
  final String response;
  PayslipSuccessState(this.response);
}
class PayslipErrorState extends PayslipState {
  final String error;
  PayslipErrorState(this.error);
}
