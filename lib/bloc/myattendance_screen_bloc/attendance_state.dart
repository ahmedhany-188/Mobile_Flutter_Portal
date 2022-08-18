part of 'attendance_cubit.dart';


enum AttendanceDataEnumStates {loading, success, failed,noConnection}


  class AttendanceState  extends Equatable {

    final AttendanceDataEnumStates attendanceDataEnumStates;
    final List<MyAttendanceModel> getAttendanceList;
    final int month;

    const AttendanceState({
      this.attendanceDataEnumStates = AttendanceDataEnumStates.loading,
      this.getAttendanceList = const <MyAttendanceModel>[],
      this.month = 1,
    });

    AttendanceState copyWith({
      AttendanceDataEnumStates? attendanceDataEnumStates,
      List<MyAttendanceModel>? getAttendanceList,
      int? month,
    }) {
      return AttendanceState(
        attendanceDataEnumStates: attendanceDataEnumStates ?? this.attendanceDataEnumStates,
        getAttendanceList: getAttendanceList ?? this.getAttendanceList,
        month: month ?? this.month,
      );
    }

    @override
    List<Object> get props => [
      attendanceDataEnumStates,getAttendanceList,month];

    static AttendanceState? fromMap(Map<String, dynamic> json) {
      if (json.isEmpty) {
        return const AttendanceState(
            attendanceDataEnumStates :AttendanceDataEnumStates.loading,
            getAttendanceList : <MyAttendanceModel>[],
            month:1,
        );
      }
      int val = json['attendanceDataEnumStates'];
      int monthVal = json['month'];
      return AttendanceState(
        attendanceDataEnumStates : AttendanceDataEnumStates.values[val],
        getAttendanceList : List<MyAttendanceModel>.from(
            json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
        month: monthVal
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'attendanceDataEnumStates':attendanceDataEnumStates.index,
        'getAttendanceList': getAttendanceList,
        'month' : month
      };
    }

  }


// class AttendanceInitial extends AttendanceState {}
//
// class BlocGetTheAttendanceLoadingState extends AttendanceState{}
//
// class BlocGetTheAttendanceSuccessState extends AttendanceState{
//    List<MyAttendanceModel> getAttendanceList;
//    int month;
//    BlocGetTheAttendanceSuccessState(this.getAttendanceList,this.month);
// }
//
// class BlocGetTheAttendanceErrorState extends AttendanceState{
//   final String error;
//   BlocGetTheAttendanceErrorState(this.error);
// }


