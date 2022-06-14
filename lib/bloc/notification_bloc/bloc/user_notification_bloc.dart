import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'user_notification_event.dart';
part 'user_notification_state.dart';

class UserNotificationBloc extends Bloc<UserNotificationEvent, UserNotificationState> {
  UserNotificationBloc({required FirebaseProvider firebaseProvider}) : super(const UserNotificationState()) {
    on<NotificationChanged>(_onNotificationChanged);

    _notificationSubscription = firebaseProvider.getNotificationsData().listen(
          (notifications) => add(NotificationChanged(notifications)),
    );
  }
  late final StreamSubscription<List<FirebaseUserNotification>> _notificationSubscription;
  Future<void> _onNotificationChanged(NotificationChanged event, Emitter<UserNotificationState> emit) async {
    emit(
      event.notifications.isNotEmpty
          ? UserNotificationState(notifications: event.notifications)
          : const UserNotificationState.noData(),
    );
  }
  @override
  Future<void> close() {
    _notificationSubscription.cancel();
    // _authenticationRepository.dispose();
    return super.close();
  }
}
