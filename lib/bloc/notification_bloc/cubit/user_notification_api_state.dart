part of 'user_notification_api_cubit.dart';

enum UserNotificationEnumStates {loading, success, failed}


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
}
