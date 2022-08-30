part of 'my_requests_cubit.dart';

enum UserRequestsEnumStates { loading, success, failed, noConnection }

@immutable
class MyRequestsState extends Equatable {
  final UserRequestsEnumStates userRequestsEnumStates;
  final List<MyRequestsModelData> getMyRequests;
  final List<MyRequestsModelData> getTempMyRequests;
  final List<MyRequestsModelData> getResult;
  // final List<MyRequestsModelData> getPending;
  // final List<MyRequestsModelData> getRejected;
  final String writtenText;
  final bool isFiltered;
  final bool approved;
  final bool pending;
  final bool rejected;

  const MyRequestsState({
    this.userRequestsEnumStates = UserRequestsEnumStates.loading,
    this.getMyRequests = const <MyRequestsModelData>[],
    this.getTempMyRequests = const <MyRequestsModelData>[],
    this.getResult = const <MyRequestsModelData>[],
    // this.getPending = const <MyRequestsModelData>[],
    // this.getRejected = const <MyRequestsModelData>[],
    this.writtenText = '',
    this.isFiltered = false,
    this.approved = false,
    this.pending = false,
    this.rejected = false,
  });

  MyRequestsState copyWith({
    UserRequestsEnumStates? userRequestsEnumStates,
    List<MyRequestsModelData>? getMyRequests,
    List<MyRequestsModelData>? getTempMyRequests,
    List<MyRequestsModelData>? getResult,
    // List<MyRequestsModelData>? getPending,
    // List<MyRequestsModelData>? getRejected,
    String? writtenText,
    bool? isFiltered,
    bool? approved,
    bool? pending,
    bool? rejected,
  }) {
    return MyRequestsState(
      userRequestsEnumStates:
          userRequestsEnumStates ?? this.userRequestsEnumStates,
      getMyRequests: getMyRequests ?? this.getMyRequests,
      getTempMyRequests: getTempMyRequests ?? this.getTempMyRequests,
      writtenText: writtenText ?? this.writtenText,
      getResult: getResult ?? this.getResult,
      // getPending: getPending ?? this.getPending,
      // getRejected: getRejected ?? this.getRejected,
      isFiltered: isFiltered ?? this.isFiltered,
      approved: approved ?? this.approved,
      pending: pending ?? this.pending,
      rejected: rejected ?? this.rejected,
    );
  }

  @override
  List<Object> get props => [
        userRequestsEnumStates,
        getMyRequests,
        writtenText,
        isFiltered,
        getResult,
        // getPending,
        // getRejected,
        getTempMyRequests,
        approved,
        pending,
        rejected,
      ];

  static MyRequestsState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const MyRequestsState(
        userRequestsEnumStates: UserRequestsEnumStates.loading,
        getMyRequests: <MyRequestsModelData>[],
      );
    }
    int val = json['userRequestsEnumStates'];
    return MyRequestsState(
      userRequestsEnumStates: UserRequestsEnumStates.values[val],
      getMyRequests: List<MyRequestsModelData>.from(json['userNotificationList']
          ?.map((p) => MyRequestsModelData.fromJson(p))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userRequestsEnumStates': userRequestsEnumStates.index,
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
