import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/data/repositories/attendance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> with HydratedMixin{
  AttendanceCubit(this.userHrCode) : super(const AttendanceState()){


    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.attendanceDataEnumStates == AttendanceDataEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {

            getAttendanceList(userHrCode,state.month);

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
  Future<void> getAttendanceList(userHRCode,monthNumber) async {



    try {
      emit(state.copyWith(
        attendanceDataEnumStates: AttendanceDataEnumStates.loading,
      ));

      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

            AttendanceRepository().getAttendanceData(userHRCode, monthNumber)
            .then((value) async{

          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.success,
            getAttendanceList: value,
              month:monthNumber,
          ));

        }).catchError((error){

          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));

        });

      }else{
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.noConnection,
        ));
      }
    }catch(e){
      emit(state.copyWith(
        attendanceDataEnumStates: AttendanceDataEnumStates.failed,
      ));
    }

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
