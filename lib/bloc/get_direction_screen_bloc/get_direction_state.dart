part of 'get_direction_cubit.dart';

abstract class GetDirectionState {
  // const GetDirectionState();
}

class GetDirectionInitial extends GetDirectionState {}

class GetDirectionLoadingState extends GetDirectionState {}

class GetDirectionSuccessState extends GetDirectionState {
  List<dynamic> getDirectionList;

  GetDirectionSuccessState(this.getDirectionList);
}

class GetDirectionErrorState extends GetDirectionState {
  final String error;
  GetDirectionErrorState(this.error);
}
