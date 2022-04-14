import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:meta/meta.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(context) =>BlocProvider.of(context);

  String myAttendance ="";

  void getAttendanceList() async {

    emit(BlocGetTheAttendanceLoadingState());

    AttendanceDataProvider().getAttendanceList().then((value){

      // final json =  jsonDecode(value.body);
      // myAttendance=MyAttendance_Model.fromJson(json);
      myAttendance = value.body;
      emit(BlocGetTheAttendanceSuccesState(myAttendance));
    }).catchError((error){

      print(error.toString());
      emit(BlocGetTheAttendanceErrorState(error.toString()));
    });
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
