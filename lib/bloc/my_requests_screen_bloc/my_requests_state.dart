part of 'my_requests_cubit.dart';

@immutable
abstract class MyRequestsState {}

class MyRequestsInitial extends MyRequestsState {}

class BlocGetMyRequestsLoadingState extends MyRequestsState{}

// ignore: must_be_immutable
class BlocGetMyRequestsSuccesState extends MyRequestsState{
  List<dynamic> getMyRequests;
  BlocGetMyRequestsSuccesState(this.getMyRequests);
}

class BlocGetMyRequestsErrorState extends MyRequestsState{
  final String error;
  BlocGetMyRequestsErrorState(this.error);
}


