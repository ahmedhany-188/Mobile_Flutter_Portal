import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/response_take_action.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../constants/enums.dart';
import '../../../constants/request_service_id.dart';
import '../../../data/models/user_notification_api/user_notification_api.dart';
import '../../../data/repositories/request_repository.dart';

part 'user_notification_api_state.dart';

class UserNotificationApiCubit extends HydratedCubit<UserNotificationApiState> {
  UserNotificationApiCubit(this.requestRepository)
      : super(const UserNotificationApiState()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userNotificationEnumStates ==
              UserNotificationEnumStates.failed ||
          state.userNotificationEnumStates ==
                  UserNotificationEnumStates.noConnection &&
              state.userNotificationList.isNotEmpty) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            await getNotifications(requestRepository.userData ?? MainUserData.empty);
          } catch (e) {
            emit(state.copyWith(
              userNotificationEnumStates: UserNotificationEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.noConnection,
          ));
        }
      }
    });
  }

  static UserNotificationApiCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final RequestRepository requestRepository;

  // updateRepository(this.requestRepository);

  writenTextSearch(String searchString) {
    emit(state.copyWith(searchString: searchString));
    checkAllFilters();
  }

  checkAllFilters() {
    List<UserNotificationApi> notificationSearchResultsList = [];
    if (state.searchString.isEmpty) {
      onClearData();
    } else {
      var splitQuery = state.searchString.toLowerCase().trim().split(' ');
      notificationSearchResultsList =
          state.userNotificationList.where((notificationElement) {
        return ((state.searchString.isNotEmpty)
            ? splitQuery.every((singleSplitElement) =>
                notificationElement.requestNo
                    .toString()
                    .toLowerCase()
                    .trim()
                    .contains(singleSplitElement) ||
                notificationElement.reqName
                    .toString()
                    .toLowerCase()
                    .trim()
                    .contains(singleSplitElement))
            : true);
      }).toList();
      emit(state.copyWith(
          userNotificationResultList: notificationSearchResultsList,
          isFiltered: true));
    }
  }

  onClearData() {
    emit(state.copyWith(
      searchString: null,
      userNotificationList: state.userNotificationList,
      userNotificationResultList: [],
      isFiltered: false,
    ));
  }

  Future<void> getNotifications(MainUserData userData) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.loading,
            status: FormzStatus.pure));
        // await Future.delayed(Duration(minutes: 1));
        await RequestRepository(userData).getMyNotificationData().then((value) async {
          emit(state.copyWith(
              userNotificationList: value,
              userNotificationEnumStates: UserNotificationEnumStates.success));
        }).catchError((error) {
          emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.failed,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          userNotificationEnumStates: UserNotificationEnumStates.failed,
        ));
      }
    } else {
      emit(state.copyWith(
        userNotificationEnumStates: UserNotificationEnumStates.noConnection,
      ));
    }
  }
  Future<void> getNotificationsWithoutLoading(MainUserData userData) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        // emit(state.copyWith(
        //     userNotificationEnumStates: UserNotificationEnumStates.loading,
        //     status: FormzStatus.pure));
        // await Future.delayed(Duration(minutes: 1));
        await RequestRepository(userData).getMyNotificationData().then((value) async {
          emit(state.copyWith(
              userNotificationList: value,
              userNotificationEnumStates: UserNotificationEnumStates.success));
        }).catchError((error) {
          emit(state.copyWith(
            userNotificationEnumStates: UserNotificationEnumStates.failed,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          userNotificationEnumStates: UserNotificationEnumStates.failed,
        ));
      }
    } else {
      emit(state.copyWith(
        userNotificationEnumStates: UserNotificationEnumStates.noConnection,
      ));
    }
  }

  submitRequestAction(
      ActionValueStatus valueStatus, UserNotificationApi notification,
      {String? actionComment}) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    var serviceID = notification.serviceID ?? "";
    ResponseTakeAction resultResponse;
    if(serviceID.contains(RequestServiceID.equipmentServiceID)) {
      resultResponse = await requestRepository
          .postEquipmentTakeActionRequest(
        valueStatus: valueStatus,
        requestNo: notification.requestNo.toString(),
        actionComment: actionComment ?? "",
        serviceID: RequestServiceID.equipmentServiceID,
        requesterHRCode: notification.requestHRCode ?? "",
        requesterEmail: notification.requesterEmail ?? "",
        serviceName: notification.serviceName ?? "",
      ).catchError((err) {
        EasyLoading.showError('Something went wrong');
        throw err;
      });
    }else{
      resultResponse =
      await requestRepository.postTakeActionRequest(
          valueStatus: valueStatus,
          requestNo: notification.requestNo.toString(),
          actionComment: "",
          serviceID: notification.serviceID ?? "",
          serviceName: notification.serviceName ?? "",
          requesterHRCode: notification.requestHRCode ?? "",
          requesterEmail: notification.requesterEmail ?? "");
    }

    final result = resultResponse.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      emit(
        state.copyWith(
          successMessage:
              "#${notification.requestNo} \n ${valueStatus == ActionValueStatus.accept ? "Request has been Accepted" : "Request has been Rejected"}",
          status: FormzStatus.submissionSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          errorMessage: "An error occurred",
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
    if (state.userNotificationEnumStates ==
        UserNotificationEnumStates.success) {
      return state.toMap();
    } else {
      return null;
    }
  }

  Future<void> clearState() async {
    emit(state.copyWith(
      userNotificationEnumStates: UserNotificationEnumStates.success,
      userNotificationList: [],
    ));
    await clear();
  }
}
