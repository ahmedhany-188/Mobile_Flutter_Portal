part of 'my_requests_cubit.dart';

enum UserRequestsEnumStates {loading, success, failed,noConnection}

@immutable
 class MyRequestsState extends Equatable {

  final UserRequestsEnumStates userRequestsEnumStates;
  final List<MyRequestsModelData> getMyRequests;

  const MyRequestsState({
    this.userRequestsEnumStates = UserRequestsEnumStates.loading,
    this.getMyRequests = const <MyRequestsModelData>[],
  });

  MyRequestsState copyWith({
    UserRequestsEnumStates? userRequestsEnumStates,
    List<MyRequestsModelData>? getMyRequests,
  }) {
    return MyRequestsState(
      userRequestsEnumStates: userRequestsEnumStates ?? this.userRequestsEnumStates,
      getMyRequests: getMyRequests ?? this.getMyRequests,
    );
  }
  @override
  List<Object> get props => [userRequestsEnumStates,getMyRequests];

  static MyRequestsState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const MyRequestsState(
        userRequestsEnumStates :UserRequestsEnumStates.loading,
        getMyRequests : <MyRequestsModelData>[],
      );
    }
    int val = json['userRequestsEnumStates'];
    return MyRequestsState(
      userRequestsEnumStates :UserRequestsEnumStates.values[val],
      getMyRequests : List<MyRequestsModelData>.from(
          json['userNotificationList']?.map((p) => MyRequestsModelData.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userRequestsEnumStates':userRequestsEnumStates.index,
      'userNotificationList': getMyRequests,
    };
  }
}


// class MyRequestsInitial extends MyRequestsState {}
//
// class BlocGetMyRequestsLoadingState extends MyRequestsState{}
//
// // ignore: must_be_immutable
// class BlocGetMyRequestsSuccessState extends MyRequestsState{
//
//   List<MyRequestsModelData> getMyRequests;
//   BlocGetMyRequestsSuccessState(this.getMyRequests);
//
// }
//
// class BlocGetMyRequestsErrorState extends MyRequestsState{
//   final String error;
//   BlocGetMyRequestsErrorState(this.error);
//
// }


