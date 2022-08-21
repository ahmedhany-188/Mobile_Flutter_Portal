import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> with HydratedMixin {
  MyRequestsCubit(this.requestRepository) : super(const MyRequestsState()){

    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.userRequestsEnumStates == UserRequestsEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getRequests();

          } catch (e) {
            emit(state.copyWith(
              userRequestsEnumStates: UserRequestsEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            userRequestsEnumStates: UserRequestsEnumStates.noConnection,
          ));
        }
      }
    });

  }

  static MyRequestsCubit get(context) =>BlocProvider.of(context);
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
        requestRepository.getMyRequestsData()
            .then((value) async {
          emit(state.copyWith(
            userRequestsEnumStates: UserRequestsEnumStates.success,
            getMyRequests: value
          ));
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
    if (state.userRequestsEnumStates == UserRequestsEnumStates.success && state.getMyRequests.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }


}
