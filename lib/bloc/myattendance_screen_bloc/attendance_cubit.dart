import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/data/repositories/attendance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> with HydratedMixin{
  AttendanceCubit(this.userHrCode) : super( AttendanceState(month: DateTime.now().month)){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.attendanceDataEnumStates == AttendanceDataEnumStates.failed || state.attendanceDataEnumStates == AttendanceDataEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getFirstAttendanceList(userHrCode);
          } catch (e) {
            emit(state.copyWith(
              attendanceDataEnumStates: AttendanceDataEnumStates.failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.noConnection,
          ));
        }
      }
    });
  }

  static AttendanceCubit get(context) =>BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  final String userHrCode;

  Future<void> getAllAttendanceList(userHRCode) async {

    if (state.getAttendanceList[state.month-1].isEmpty) {

      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.loading,
          ));
          await AttendanceRepository().getAttendanceData(userHRCode, state.month)
              .then((value) async {

            MyAttendanceModel lastModel = value.last;
            if(lastModel.date!=null){
            int monthCount1 = int.parse(lastModel.date!.split("-")[1]) ?? 0;

            state.getAttendanceList.removeAt(monthCount1-1);
            state.getAttendanceList.insert(monthCount1-1, value);
            }

          }).catchError((error) {
            emit(state.copyWith(
              attendanceDataEnumStates: AttendanceDataEnumStates.failed,
            ));
          });
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.fullSuccess,
            getAttendanceList: state.getAttendanceList,
          ));
        } catch (e) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        }
      } else {
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.noConnection,
        ));
      }
    }
  }

  Future<void> getFirstAttendanceList(userHRCode
      ) async {
    if (state.getAttendanceList.isEmpty) {

      List<List<MyAttendanceModel>> getAttendanceListSuccess = [];

      List<MyAttendanceModel> emptyLit = [];

      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);
      getAttendanceListSuccess.add(emptyLit);

          emit(state.copyWith(
            getAttendanceList: getAttendanceListSuccess,
          ));

          getAllAttendanceList(userHRCode);

    }
  }

  void monthValueChanged(int value) {
    emit(state.copyWith(month: value,));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  AttendanceState? fromJson(Map<String, dynamic> json) {
    return AttendanceState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AttendanceState state) {
    if (state.attendanceDataEnumStates == AttendanceDataEnumStates.success && state.getAttendanceList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}