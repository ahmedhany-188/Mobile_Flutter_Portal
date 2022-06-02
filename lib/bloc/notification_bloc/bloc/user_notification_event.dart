part of 'user_notification_bloc.dart';

abstract class UserNotificationEvent extends Equatable {
  const UserNotificationEvent();
}
class NotificationChanged extends UserNotificationEvent {
  const NotificationChanged(this.notifications);
  final List<FirebaseUserNotification> notifications;

  @override
  List<Object> get props => [notifications];
}
