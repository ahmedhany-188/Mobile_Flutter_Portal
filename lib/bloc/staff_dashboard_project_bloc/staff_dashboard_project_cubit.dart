import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/projectstaffdashboard_model.dart';
import 'package:hassanallamportalflutter/data/repositories/staff_dashboard_project_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'staff_dashboard_project_state.dart';

class StaffDashboardProjectCubit extends Cubit<StaffDashboardProjectState>
    with HydratedMixin {
  StaffDashboardProjectCubit(this.userHRCode)
      : super(
            StaffDashboardProjectState(date: DateTime.now().month.toString())) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.projectStaffDashBoardEnumStates ==
              ProjectStaffDashBoardEnumStates.failed ||
          state.projectStaffDashBoardEnumStates ==
              ProjectStaffDashBoardEnumStates.noConnection) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            // getFirstAttendanceList(userHrCode,state.month);
          } catch (e) {
            emit(state.copyWith(
              projectStaffDashBoardEnumStates:
                  ProjectStaffDashBoardEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            projectStaffDashBoardEnumStates:
                ProjectStaffDashBoardEnumStates.noConnection,
          ));
        }
      }
    });
  }

  static StaffDashboardProjectCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  String userHRCode;

  chosenDirectorOptions(String chosenFilter) {
    emit(state.copyWith(chosenDirectorFilter: chosenFilter));
  }

  updateFilters() {
    var apiMap = <String>{'All'};
    state.projectStaffDashBoardList
        .where((element) => apiMap.add(element.name ?? 'Not Assigned'))
        .toList();
    List<String> directorsFilters = apiMap.toList();
    apiMap.clear();
    emit(state.copyWith(
      directorFilter: directorsFilters,
    ));
  }

  writenText(String text) {
    emit(state.copyWith(writtenText: text, isFiltered: true));
    checkAllFilters();
  }

  checkAllFilters() {
    List<ProjectStaffDashboardModel> mySearchResultsList = [];
    if (state.writtenText.isEmpty && state.chosenDirectorFilter.isEmpty) {
      onClearData();
    } else {
      var splitQuery = state.writtenText.toLowerCase().trim().split(' ');
      mySearchResultsList = state.projectStaffDashBoardList
          .where((myRequestElement) =>
                  ((state.writtenText.isNotEmpty)
                      ? splitQuery.every((singleSplitElement) =>
                          myRequestElement.projectName
                              .toString()
                              .toLowerCase()
                              .trim()
                              .contains(singleSplitElement))
                      : true) &&
                  ((state.chosenDirectorFilter.isNotEmpty && state.chosenDirectorFilter != 'All')
                      ? state.chosenDirectorFilter
                          .contains(myRequestElement.name ?? 'Not Assigned')
                      : true)
              // ((state.pending)
              //     ? state.getTempMyRequests.contains(myRequestElement)
              //     : true) &&
              // ((state.rejected)
              //     ? state.getTempMyRequests.contains(myRequestElement)
              //     : true)
              )
          .toList();
        // ..sort((a, b) => b.projectName?.compareTo(a.projectName!) ?? 0);

      emit(state.copyWith(
        getResult: mySearchResultsList,
        isFiltered: true,
      ));
    }
  }

  void onClearData() {
    emit(
      state.copyWith(
        writtenText: '',
        isFiltered: false,
        getResult: [],
        getResultTemp: [],
        chosenDirectorFilter: '',

      ),
    );
  }

  Future<void> getFirstStaffBoardProjects(
      company, project, director, date) async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      try {
        emit(state.copyWith(
          projectStaffDashBoardEnumStates:
              ProjectStaffDashBoardEnumStates.loading,
        ));

        await StaffDashBoardProjectRepository()
            .getStaffDashBoardData(company, project, director, date)
            .then((value) async {
          emit(state.copyWith(
              projectStaffDashBoardEnumStates:
                  ProjectStaffDashBoardEnumStates.success,
              projectStaffDashBoardList: value,
              date: date));
        }).catchError((error) {
          emit(state.copyWith(
            projectStaffDashBoardEnumStates:
                ProjectStaffDashBoardEnumStates.failed,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          projectStaffDashBoardEnumStates:
              ProjectStaffDashBoardEnumStates.failed,
        ));
      }
    } else {
      emit(state.copyWith(
        projectStaffDashBoardEnumStates:
            ProjectStaffDashBoardEnumStates.noConnection,
      ));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
  StaffDashboardProjectState? fromJson(Map<String, dynamic> json) {
    return StaffDashboardProjectState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(StaffDashboardProjectState state) {
    if (state.projectStaffDashBoardEnumStates ==
            ProjectStaffDashBoardEnumStates.success &&
        state.projectStaffDashBoardList.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
  }
}
