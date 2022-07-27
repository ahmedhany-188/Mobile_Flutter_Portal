import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/data/repositories/attendance_repository.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(context) =>BlocProvider.of(context);

  final Connectivity connectivity = Connectivity();

  late MultiBlocProvider myBloc;
  late StreamSubscription mSub;

  void getAttendanceList(userHRCode,monthNumber) async {

    emit(BlocGetTheAttendanceLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {


        //mSub=
            AttendanceRepository().getAttendanceData(userHRCode, monthNumber)
            .then((value){
          emit(BlocGetTheAttendanceSuccessState(value,monthNumber));
        }).catchError((error){

          print("Err0r: "+error.toString());
          emit(BlocGetTheAttendanceErrorState(error.toString()));
        });

      }else{
        emit(BlocGetTheAttendanceErrorState("No internet connection"));
      }
    }catch(e){
      print("Err0r2: "+e.toString());
      emit(BlocGetTheAttendanceErrorState(e.toString()));
    }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    mSub.cancel();
    return super.close();
  }



}
