part of 'my_requests_cubit.dart';

@immutable
abstract class MyRequestsState {}

class MyRequestsInitial extends MyRequestsState {}


class BlocGetMyRequestsLoadingState extends MyRequestsState{}

class BlocGetMyRequestsSuccesState extends MyRequestsState{
  String getMyrequests;
  BlocGetMyRequestsSuccesState(this.getMyrequests);
}

class BlocGetMyRequestsErrorState extends MyRequestsState{
  final String error;
  BlocGetMyRequestsErrorState(this.error);
}


