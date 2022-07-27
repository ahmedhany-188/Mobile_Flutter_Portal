part of 'profile_manager_cubit.dart';

@immutable
abstract class ProfileManagerState {}

class ProfileManagerInitial extends ProfileManagerState {}

class BlocGetManagerDataLoadingState extends ProfileManagerState{}

class BlocGetManagerDataSuccessState extends ProfileManagerState{
  EmployeeData managerData;
  BlocGetManagerDataSuccessState(this.managerData);
}

class BlocGetManagerDataErrorState extends ProfileManagerState{
  final String error;
  BlocGetManagerDataErrorState(this.error);
}