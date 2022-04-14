part of 'attendance_cubit.dart';

@immutable
abstract class AttendanceState {}


class AttendanceInitial extends AttendanceState {}

class BlocGetTheAttendanceLoadingState extends AttendanceState{}
class BlocGetTheAttendanceSuccesState extends AttendanceState{

   String getContactList;
   BlocGetTheAttendanceSuccesState(this.getContactList);

}

class BlocGetTheAttendanceErrorState extends AttendanceState{

  final String error;

  BlocGetTheAttendanceErrorState(this.error);
}


