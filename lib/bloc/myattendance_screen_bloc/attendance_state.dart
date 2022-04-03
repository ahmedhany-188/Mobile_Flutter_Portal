part of 'attendance_cubit.dart';

@immutable
abstract class AttendanceState {}


class AttendanceInitial extends AttendanceState {}

class BlocGetTheAttendanceLoadingState extends AttendanceState{}
class BlocGetTheAttendanceSuccesState extends AttendanceState{}
class BlocGetTheAttendanceErrorState extends AttendanceState{}


