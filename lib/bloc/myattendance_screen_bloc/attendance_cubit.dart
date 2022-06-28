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

  void getAttendanceList(userHRCode,monthNumber) async {

    emit(BlocGetTheAttendanceLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        AttendanceRepository().getAttendanceData(userHRCode, monthNumber)
        // AttendanceDataProvider().getAttendanceList(userHRcode,monthNumber)
            .then((value){

          // print("----------"+myAttendance);
          emit(BlocGetTheAttendanceSuccessState(value));
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
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
