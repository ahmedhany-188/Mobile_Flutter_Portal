part of 'subsidiaries_cubit.dart';

@immutable
abstract class SubsidiariesState {}

class SubsidiariesInitial extends SubsidiariesState {}

class SubsidiariesLoadingState extends SubsidiariesState {}

class SubsidiariesSuccessState extends SubsidiariesState {
  List<SubsidiariesData> subsidiariesList;

  SubsidiariesSuccessState(this.subsidiariesList);
}

class SubsidiariesErrorState extends SubsidiariesState {
  final String error;
  SubsidiariesErrorState(this.error);
}

