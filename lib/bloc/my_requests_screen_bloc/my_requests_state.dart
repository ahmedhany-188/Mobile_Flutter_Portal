part of 'my_requests_cubit.dart';

@immutable
abstract class MyRequestsState {}

class MyRequestsInitial extends MyRequestsState {}

class BlocGetMyRequestsLoadingState extends MyRequestsState{}

// ignore: must_be_immutable
class BlocGetMyRequestsSuccessState extends MyRequestsState{

  List<MyRequestsModelData> getMyRequests;
  BlocGetMyRequestsSuccessState(this.getMyRequests);

}

class BlocGetMyRequestsErrorState extends MyRequestsState{
  final String error;
  BlocGetMyRequestsErrorState(this.error);

}


