import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends HydratedCubit<MyRequestsState> {
  MyRequestsCubit(this.requestRepository) : super(const MyRequestsState()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userRequestsEnumStates == UserRequestsEnumStates.failed ||
          state.userRequestsEnumStates == UserRequestsEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getRequests();
          } catch (e) {
            emit(state.copyWith(
              userRequestsEnumStates: UserRequestsEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            userRequestsEnumStates: UserRequestsEnumStates.noConnection,
          ));
        }
      }
    });
  }

  static MyRequestsCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final RequestRepository requestRepository;

  Future<void> getRequests() async {
    try {
      emit(state.copyWith(
        userRequestsEnumStates: UserRequestsEnumStates.loading,
      ));
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        requestRepository.getMyRequestsData().then((value) async {
          emit(state.copyWith(
              userRequestsEnumStates: UserRequestsEnumStates.success,
              getMyRequests: value));
        }).catchError((error) {
          emit(state.copyWith(
            userRequestsEnumStates: UserRequestsEnumStates.failed,
          ));
        });
      } else {
        emit(state.copyWith(
          userRequestsEnumStates: UserRequestsEnumStates.noConnection,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        userRequestsEnumStates: UserRequestsEnumStates.failed,
      ));
    }
  }

  writenText(String text) {
    emit(state.copyWith(writtenText: text, isFiltered: true));
    checkAllFilters();
  }

  checkAllFilters() {
    List<MyRequestsModelData> myRequestSearchResultsList = [];
    if (!state.approved &&
        !state.pending &&
        !state.rejected &&
        state.writtenText.isEmpty) {
      onClearData();
    } else {
      var splitQuery = state.writtenText.toLowerCase().trim().split(' ');
      myRequestSearchResultsList = state.getMyRequests
          .where((myRequestElement) =>
              ((state.writtenText.isNotEmpty)
                  ? splitQuery.every((singleSplitElement) =>
                      myRequestElement.requestNo
                          .toString()
                          .toLowerCase()
                          .trim()
                          .contains(singleSplitElement) ||
                      myRequestElement.serviceName
                          .toString()
                          .toLowerCase()
                          .trim()
                          .contains(singleSplitElement))
                  : true) &&
              ((state.approved)
                  ? state.getTempMyRequests.contains(myRequestElement)
                  : true) &&
              ((state.pending)
                  ? state.getTempMyRequests.contains(myRequestElement)
                  : true) &&
              ((state.rejected)
                  ? state.getTempMyRequests.contains(myRequestElement)
                  : true))
          .toList()
        ..sort((a, b) => b.reqDate?.compareTo(a.reqDate!) ?? 0);

      emit(state.copyWith(
        getResult: myRequestSearchResultsList,
        isFiltered: true,
      ));
    }
  }

  onApprovedSelected(List<MyRequestsModelData> list) {
    emit(
      state.copyWith(
        approved: true,
        getTempMyRequests: list,
      ),
    );
  }

  onPendingSelected(List<MyRequestsModelData> list) {
    emit(state.copyWith(
      pending: true,
      getTempMyRequests: list,
    ));
  }

  onRejectedSelected(List<MyRequestsModelData> list) {
    emit(state.copyWith(
      rejected: true,
      getTempMyRequests: list,
    ));
  }

  onApprovedUnSelected(List<MyRequestsModelData> list) {
    emit(state.copyWith(
      approved: false,
      getTempMyRequests: list,
    ));
  }

  onPendingUnSelected(List<MyRequestsModelData> list) {
    emit(state.copyWith(
      pending: false,
      getTempMyRequests: list,
    ));
  }

  onRejectedUnSelected(List<MyRequestsModelData> list) {
    emit(state.copyWith(
      rejected: false,
      getTempMyRequests: list,
    ));
  }

  void onClearData() {
    emit(
      state.copyWith(
        writtenText: '',
        isFiltered: false,
        getResult: [],
        // getPending: [],
        // getRejected: [],
        approved: false,
        rejected: false,
        pending: false,
        getTempMyRequests: [],
        // getMyRequests: state.getMyRequests,
      ),
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

  @override
  MyRequestsState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return MyRequestsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(MyRequestsState state) {
    // TODO: implement toJson
    if (state.userRequestsEnumStates == UserRequestsEnumStates.success) {
      return state.toMap();
    } else {
      return null;
    }
  }
  Future<void> clearState() async {
    onClearData();
    // emit(state.copyWith(userNotificationEnumStates: UserNotificationEnumStates.success,userNotificationList: [],));
    await clear();
  }
}
