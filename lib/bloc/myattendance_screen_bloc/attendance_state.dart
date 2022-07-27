part of 'attendance_cubit.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class BlocGetTheAttendanceLoadingState extends AttendanceState{}

class BlocGetTheAttendanceSuccessState extends AttendanceState{
   List<MyAttendanceModel> getAttendanceList;
   int month;
   BlocGetTheAttendanceSuccessState(this.getAttendanceList,this.month);
}

class BlocGetTheAttendanceErrorState extends AttendanceState{
  final String error;
  BlocGetTheAttendanceErrorState(this.error);
}


