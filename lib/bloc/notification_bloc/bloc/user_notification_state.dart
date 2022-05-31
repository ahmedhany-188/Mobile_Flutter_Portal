part of 'user_notification_bloc.dart';

class UserNotificationState extends Equatable {
  // const UserNotificationState()
  const UserNotificationState({
    this.status = NotificationStatus.noData,
    this.notifications = const <FirebaseUserNotification>[],
  });

  const UserNotificationState.hasData(List<FirebaseUserNotification> notifications)
      : this(status: NotificationStatus.hasData, notifications: notifications);

  const UserNotificationState.noData() : this(status: NotificationStatus.noData);

  final NotificationStatus status;
  final List<FirebaseUserNotification> notifications;

  @override
  List<Object> get props => [status, notifications];
}
enum NotificationStatus{
  noData,
  hasData
}
//
// class UserNotificationInitial extends UserNotificationState {
//   @override
//   List<Object> get props => [];
// }
