import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_job_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'staff_dashboard_job_state.dart';

class StaffDashboardJobCubit extends Cubit<StaffDashboardJobState>
    with HydratedMixin {
  StaffDashboardJobCubit(this.userHRCode)
      : super(StaffDashboardJobState(date: DateTime.now().month.toString())) {
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
              jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            jobStaffDashBoardEnumStates:
                JobStaffDashBoardEnumStates.noConnection,
          ));
        }
      }
    });
  }
  static StaffDashboardJobCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  String userHRCode;

  void showJobsFilter(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
        builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'All',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        updateList('All');
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Staff',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        updateList('Staff');
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Labor',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        updateList('Labor');
                        Navigator.pop(context);
                      }),
                ),
              ],
            ));
  }

  void updateList(String filterBy) {
    if (filterBy == 'All') {
      clearFilters();
    } else {
      List<JobStaffDashboardModel> searchResult;
      searchResult = state.jobStaffDashBoardList
          .where((element) => (filterBy == 'Staff')
              ? element.islabor == false
              : element.islabor == true)
          .toList();
      emit(state.copyWith(
          isFiltered: true, jobStaffDashBoardSearchList: searchResult));
    }
  }

  void clearFilters() {
    emit(state.copyWith(isFiltered: false, jobStaffDashBoardSearchList: []));
  }

  Future<void> getFirstStaffBoardJobs(
      projectCode, director, jobTitle, fromDay, toDay) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.loading,
        ));
        await StaffDashBoardJobRepository()
            .getStaffDashBoardData(
                projectCode, director, jobTitle, fromDay, toDay)
            .then((value) async {
          emit(state.copyWith(
            jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.success,
            jobStaffDashBoardList: value,
            date: fromDay,
          ));
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
        jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.noConnection,
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
