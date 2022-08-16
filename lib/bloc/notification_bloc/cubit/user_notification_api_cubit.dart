import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_notification_api/user_notification_api.dart';
import '../../../data/repositories/request_repository.dart';

part 'user_notification_api_state.dart';

class UserNotificationApiCubit extends Cubit<UserNotificationApiState> {
  UserNotificationApiCubit(this.requestRepository) : super(const UserNotificationApiState()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userNotificationEnumStates != UserNotificationEnumStates.success) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {

            getNotifications();

          } catch (e) {
            emit(state.copyWith(
              userNotificationEnumStates: UserNotificationEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.failed,
          ));
        }
      }

    });
  }

  static UserNotificationApiCubit get(context) =>BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final RequestRepository requestRepository;

  Future<void> getNotifications() async {
    try {
      emit(state.copyWith(
        userNotificationEnumStates: UserNotificationEnumStates.loading,
      ));
      await requestRepository.getMyNotificationData()
          .then((value) async {
        emit(state.copyWith(
          userNotificationList: value,
          userNotificationEnumStates: UserNotificationEnumStates.success
        ));
      }).catchError((error) {
        emit(state.copyWith(
          userNotificationEnumStates: UserNotificationEnumStates.failed,
        ));
      });
    }
    catch (e) {
      emit(state.copyWith(
        userNotificationEnumStates: UserNotificationEnumStates.failed,
      ));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
