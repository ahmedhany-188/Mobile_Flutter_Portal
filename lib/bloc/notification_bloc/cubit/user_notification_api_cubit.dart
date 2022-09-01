import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../constants/enums.dart';
import '../../../data/models/user_notification_api/user_notification_api.dart';
import '../../../data/repositories/request_repository.dart';

part 'user_notification_api_state.dart';

class UserNotificationApiCubit extends HydratedCubit<UserNotificationApiState>{
  UserNotificationApiCubit(this.requestRepository) : super(const UserNotificationApiState()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userNotificationEnumStates == UserNotificationEnumStates.failed ||
          state.userNotificationEnumStates == UserNotificationEnumStates.noConnection && state.userNotificationList.isNotEmpty) {
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
          status: FormzStatus.pure
        ));
        // await Future.delayed(Duration(minutes: 1));
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



  submitRequestAction(ActionValueStatus valueStatus,UserNotificationApi notification) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress,));
    final vacationResultResponse = await requestRepository.postTakeActionRequest(
        valueStatus: valueStatus,
        requestNo: notification.requestNo.toString(),
        actionComment: "",
        serviceID: notification.serviceID ?? "",
        requesterHRCode: notification.requestHRCode ?? "");

    final result = vacationResultResponse.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      emit(
        state.copyWith(
          successMessage: "#${notification.requestNo} \n ${valueStatus == ActionValueStatus.accept ? "Request has been Accepted":"Request has been Rejected"}",
          status: FormzStatus.submissionSuccess,
        ),
      );
    }
    else {
      emit(
        state.copyWith(
          errorMessage:"An error occurred",
          status: FormzStatus.submissionFailure,
        ),
      );
      // }
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
    if (state.userNotificationEnumStates == UserNotificationEnumStates.success) {
      return state.toMap();
    } else {
      return null;
    }
  }
  Future<void> clearState() async {
    emit(state.copyWith(userNotificationEnumStates: UserNotificationEnumStates.success,userNotificationList: [],));
    await clear();
  }

}
