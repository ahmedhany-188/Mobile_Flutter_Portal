part of 'employee_appraisal_bloc_cubit.dart';

@immutable
abstract class EmployeeAppraisalBlocState {}

class EmployeeAppraisalBlocInitial extends EmployeeAppraisalBlocState {}


class BlocGetEmployeeAppraisalBlocInitialLoadingState extends EmployeeAppraisalBlocState{}

// ignore: must_be_immutable
class BlocGetEmployeeAppraisalBlocInitialSuccessState extends EmployeeAppraisalBlocState{

  String employeeAppraisaleList;
  BlocGetEmployeeAppraisalBlocInitialSuccessState(this.employeeAppraisaleList);

}

class BlocGetEmployeeAppraisalBlocInitialErrorState extends EmployeeAppraisalBlocState{
  final error;
BlocGetEmployeeAppraisalBlocInitialErrorState(this.error);

}