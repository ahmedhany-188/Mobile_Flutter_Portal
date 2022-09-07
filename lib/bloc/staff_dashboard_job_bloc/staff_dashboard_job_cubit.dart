import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_job_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'staff_dashboard_job_state.dart';

class StaffDashboardJobCubit extends Cubit<StaffDashboardJobState> with HydratedMixin{

  StaffDashboardJobCubit(this.userHRCode)
      : super(StaffDashboardJobState(date: DateTime
      .now()
      .month
      .toString())) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.jobStaffDashBoardEnumStates ==
          JobStaffDashBoardEnumStates.failed ||
          state.jobStaffDashBoardEnumStates ==
              JobStaffDashBoardEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getFirstAttendanceList(userHrCode,state.month);
          } catch (e) {
            emit(state.copyWith(
              jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
                  .failed,
            ));
          }
        }
        else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
                .noConnection,
          ));
        }
      }
    });
  }
  static StaffDashboardJobCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  String userHRCode;


  Future<void> getFirstStaffBoardJobs(projectCode, director, jobTitle, fromDay,toDay) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          emit(state.copyWith(
            jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
                .loading,
          ));
          print("--here0");
          print("-"+projectCode+"-"+director+"-"+jobTitle+"-"+fromDay+"-"+toDay);
          print("--here00");
          await StaffDashBoardJobRepository().getStaffDashBoardData(projectCode, director, jobTitle, fromDay,toDay)
              .then((value) async {


            emit(state.copyWith(
                jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
                    .success,
                jobStaffDashBoardList: value,
                date:fromDay,
            ));
                print("--here2");
          }).catchError((error) {
            emit(state.copyWith(
              jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.failed,
            ));
          });
        } catch (e) {
          emit(state.copyWith(
            jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.failed,
          ));
        }
      } else {
        emit(state.copyWith(
          jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
              .noConnection,
        ));
      }
    }



  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  StaffDashboardJobState? fromJson(Map<String, dynamic> json) {
    return StaffDashboardJobState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(StaffDashboardJobState state) {
    if (state.jobStaffDashBoardEnumStates ==
        JobStaffDashBoardEnumStates.success &&
        state.jobStaffDashBoardList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }

}
