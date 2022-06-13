import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  static AttendanceCubit get(context) =>BlocProvider.of(context);
  String myAttendance ="";

  final Connectivity connectivity = Connectivity();

  void getAttendanceList(userHRcode,monthNumber) async {

    emit(BlocGetTheAttendanceLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        AttendanceDataProvider().getAttendanceList(userHRcode,monthNumber).then((value){

          myAttendance = value.body;

          // print("----------"+myAttendance);
          emit(BlocGetTheAttendanceSuccesState(myAttendance));
        }).catchError((error){
          emit(BlocGetTheAttendanceErrorState(error.toString()));
        });

      }else{
        emit(BlocGetTheAttendanceErrorState("No internet connection"));
      }
    }catch(e){
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
