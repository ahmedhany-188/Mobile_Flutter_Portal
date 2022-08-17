part of 'user_notification_api_cubit.dart';

enum UserNotificationEnumStates {loading, success, failed,noConnection}


class UserNotificationApiState extends Equatable {
  final UserNotificationEnumStates userNotificationEnumStates;
  final List<UserNotificationApi> userNotificationList;

  const UserNotificationApiState({
    this.userNotificationEnumStates = UserNotificationEnumStates.loading,
    this.userNotificationList = const <UserNotificationApi>[],
  });

  UserNotificationApiState copyWith({
    UserNotificationEnumStates? userNotificationEnumStates,
    List<UserNotificationApi>? userNotificationList,
  }) {
    return UserNotificationApiState(
      userNotificationEnumStates: userNotificationEnumStates ?? this.userNotificationEnumStates,
      userNotificationList: userNotificationList ?? this.userNotificationList,
    );
  }
  @override
  List<Object> get props => [userNotificationEnumStates,userNotificationList];


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
