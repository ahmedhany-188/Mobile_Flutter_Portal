import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/models/user_notification_api/user_notification_api.dart';
import '../../../data/repositories/request_repository.dart';

part 'user_notification_api_state.dart';

class UserNotificationApiCubit extends Cubit<UserNotificationApiState> with HydratedMixin{
  UserNotificationApiCubit(this.requestRepository) : super(const UserNotificationApiState()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userNotificationEnumStates == UserNotificationEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getNotifications();

          } catch (e) {
            emit(state.copyWith(
              userNotificationEnumStates: UserNotificationEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.noConnection,
          ));
        }
      }
    });
  }

  static UserNotificationApiCubit get(context) =>BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final RequestRepository requestRepository;

  Future<void> getNotifications() async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
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
    }else{
      emit(state.copyWith(
        userNotificationEnumStates: UserNotificationEnumStates.noConnection,
      ));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

  @override
  UserNotificationApiState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return UserNotificationApiState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserNotificationApiState state) {
    // TODO: implement toJson
    if (state.userNotificationEnumStates == UserNotificationEnumStates.success && state.userNotificationList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}
