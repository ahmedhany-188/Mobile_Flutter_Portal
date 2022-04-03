import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:meta/meta.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(context) =>BlocProvider.of(context);

  List<dynamic> myAttendance = [];

  void getAttendanceList(){

    emit(BlocGetTheAttendanceLoadingState());

    AttendanceDataProvider("03","10204738").getAttendanceList().then((value){
      myAttendance=value.bodyBytes;

      emit(BlocGetTheAttendanceSuccesState());
    }).catchError((error){

      print(error.toString());
      emit(BlocGetTheAttendanceErrorState());
    });
  }

}
