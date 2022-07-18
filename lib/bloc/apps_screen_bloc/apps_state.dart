part of 'apps_cubit.dart';

@immutable
abstract class AppsState {}

class AppsInitial extends AppsState {}

class AppsLoadingState extends AppsState {}

class AppsSuccessState extends AppsState {
  final List<AppsData> appsList;

  AppsSuccessState(this.appsList);
}

class AppsErrorState extends AppsState {
  final String error;
  AppsErrorState(this.error);
}
