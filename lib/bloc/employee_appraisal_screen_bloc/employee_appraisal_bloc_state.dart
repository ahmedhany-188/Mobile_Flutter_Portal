part of 'employee_appraisal_bloc_cubit.dart';

@immutable
abstract class EmployeeAppraisalBlocState {}

class EmployeeAppraisalBlocInitial extends EmployeeAppraisalBlocState {}


class BlocgetEmployeeAppraisalBlocInitialLoadingState extends EmployeeAppraisalBlocState{}

class BlocgetEmployeeAppraisalBlocInitialSuccessState extends EmployeeAppraisalBlocState{

  String employeeAppraisaleList;
  BlocgetEmployeeAppraisalBlocInitialSuccessState(this.employeeAppraisaleList);

}

class BlocgetEmployeeAppraisalBlocInitialErrorState extends EmployeeAppraisalBlocState{
  final error;
BlocgetEmployeeAppraisalBlocInitialErrorState(this.error);

}