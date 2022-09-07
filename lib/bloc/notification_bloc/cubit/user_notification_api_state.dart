part of 'user_notification_api_cubit.dart';

enum UserNotificationEnumStates {loading, success, failed,noConnection}


class UserNotificationApiState extends Equatable {
  final UserNotificationEnumStates userNotificationEnumStates;
  final List<UserNotificationApi> userNotificationList;
  final List<UserNotificationApi> userNotificationResultList;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String searchString;
  final bool isFiltered;

  const UserNotificationApiState({
    this.userNotificationEnumStates = UserNotificationEnumStates.loading,
    this.userNotificationList = const <UserNotificationApi>[],
    this.userNotificationResultList = const <UserNotificationApi>[],
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.searchString = '',
    this.isFiltered = false,
  });

  UserNotificationApiState copyWith({
    UserNotificationEnumStates? userNotificationEnumStates,
    List<UserNotificationApi>? userNotificationList,
    List<UserNotificationApi>? userNotificationResultList,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    String? searchString,
    bool? isFiltered,

  }) {
    return UserNotificationApiState(
      userNotificationEnumStates: userNotificationEnumStates ?? this.userNotificationEnumStates,
      userNotificationList: userNotificationList ?? this.userNotificationList,
      userNotificationResultList: userNotificationResultList ?? this.userNotificationResultList,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      searchString: searchString ??this.searchString,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }
  @override
  List<Object> get props => [userNotificationEnumStates,userNotificationList,userNotificationResultList,status,searchString,isFiltered];


  static UserNotificationApiState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const UserNotificationApiState(
        userNotificationEnumStates :UserNotificationEnumStates.loading,
        userNotificationList : <UserNotificationApi>[],
      );
    }
    int val = json['userNotificationEnumStates'];
    return UserNotificationApiState(
      userNotificationEnumStates :UserNotificationEnumStates.values[val],
      userNotificationList : List<UserNotificationApi>.from(
          json['userNotificationList']?.map((p) => UserNotificationApi.fromJson(p))),
      // : null)json['listContacts'] as List<ContactsDataFromApi>,
      // tempList : List<ContactsDataFromApi>.from(
      //     json['tempList']?.map((p) => ContactsDataFromApi.fromJson(p))),
      // // json['tempList'],
      // companiesFilter : json['companiesFilter'],
      // projectsFilter : json['projectsFilter'],
      // departmentFilter : json['departmentFilter'],
      // titleFilter : json['titleFilter'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userNotificationEnumStates':userNotificationEnumStates.index,
      'userNotificationList': userNotificationList,
    };
  }
}
