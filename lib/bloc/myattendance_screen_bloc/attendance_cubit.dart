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
            getFirstAttendanceList(userHrCode,state.month);
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

    List<List<MyAttendanceModel>> getAttendanceListSuccess=[];

    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.loading,
        ));

        await AttendanceRepository().getAttendanceData(userHRCode, 1)
            .then((value) async {
          print("-----------start weight");
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 2)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 3)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 4)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 5)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 6)
            .then((value) async {
              print("-----------half weight");
              getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 7)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 8)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 9)
            .then((value) async {
          print("-----------Third quarter weight");
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 10)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 11)
            .then((value) async {
          getAttendanceListSuccess.add(value);
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, 12)
            .then((value) async {
          getAttendanceListSuccess.add(value);
          print("-----------end weight");
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.fullSuccess,
          getAttendanceList: getAttendanceListSuccess,
        ));

      } catch (e) {
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.failed,
        ));
      }
    }else{
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.noConnection,
        ));
      }
    }

  Future<void> getFirstAttendanceList(userHRCode,int month) async {

    List<List<MyAttendanceModel>> getAttendanceListSuccess=[];

    List<MyAttendanceModel> emptyLit=[];

    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);
    getAttendanceListSuccess.add(emptyLit);

    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.loading,
        ));

        await AttendanceRepository().getAttendanceData(userHRCode, month-1)
            .then((value) async {
          getAttendanceListSuccess.insert(month-2,value);
          print("-----------start weight");
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, month)
            .then((value) async {
          getAttendanceListSuccess.insert(month-1,value);
          print("-----------half weight");
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        await AttendanceRepository().getAttendanceData(userHRCode, month+1)
            .then((value) async {
          getAttendanceListSuccess.insert(month,value);
          print("-----------end weight");
        }).catchError((error) {
          emit(state.copyWith(
            attendanceDataEnumStates: AttendanceDataEnumStates.failed,
          ));
        });

        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.success,
          getAttendanceList: getAttendanceListSuccess,
        ));

      } catch (e) {
        emit(state.copyWith(
          attendanceDataEnumStates: AttendanceDataEnumStates.failed,
        ));
      }
    }else{
      emit(state.copyWith(
        attendanceDataEnumStates: AttendanceDataEnumStates.noConnection,
      ));
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
