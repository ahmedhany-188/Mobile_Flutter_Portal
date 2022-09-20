part of 'staff_dashboard_project_cubit.dart';

enum ProjectStaffDashBoardEnumStates { loading, success, failed, noConnection }

class StaffDashboardProjectState extends Equatable {
  final ProjectStaffDashBoardEnumStates projectStaffDashBoardEnumStates;
  final List<ProjectStaffDashboardModel> projectStaffDashBoardList;
  final String date;
  final List<ProjectStaffDashboardModel> getResult;
  final List<ProjectStaffDashboardModel> getResultTemp;
  final String chosenDirectorFilter;
  final List<String> directorFilter;
  final String writtenText;
  // final String chosenDirector;
  final bool isFiltered;

  const StaffDashboardProjectState({
    this.projectStaffDashBoardEnumStates =
        ProjectStaffDashBoardEnumStates.loading,
    this.projectStaffDashBoardList = const <ProjectStaffDashboardModel>[],
    required this.date,
    this.isFiltered = false,
    this.writtenText = '',
    // this.chosenDirector = 'All',
    this.getResult = const <ProjectStaffDashboardModel>[],
    this.getResultTemp = const <ProjectStaffDashboardModel>[],
    this.chosenDirectorFilter = '',
    this.directorFilter = const [],
  });

  StaffDashboardProjectState copyWith(
      {ProjectStaffDashBoardEnumStates? projectStaffDashBoardEnumStates,
      List<ProjectStaffDashboardModel>? projectStaffDashBoardList,
      String? date,
      List<ProjectStaffDashboardModel>? getResult,
      List<ProjectStaffDashboardModel>? getResultTemp,
      String? writtenText,
      String? chosenDirector,
      bool? isFiltered,
      String? chosenDirectorFilter,
      List<String>? directorFilter}) {
    return StaffDashboardProjectState(
      projectStaffDashBoardEnumStates: projectStaffDashBoardEnumStates ??
          this.projectStaffDashBoardEnumStates,
      projectStaffDashBoardList:
          projectStaffDashBoardList ?? this.projectStaffDashBoardList,
      date: date ?? this.date,
      isFiltered: isFiltered ?? this.isFiltered,
      writtenText: writtenText ?? this.writtenText,
      // chosenDirector: chosenDirector ?? this.chosenDirector,
      getResult: getResult ?? this.getResult,
      getResultTemp: getResultTemp ?? this.getResultTemp,
      directorFilter: directorFilter ?? this.directorFilter,
      chosenDirectorFilter:
          chosenDirectorFilter ?? this.chosenDirectorFilter,
    );
  }

  @override
  List<Object> get props => [
        projectStaffDashBoardEnumStates,
        projectStaffDashBoardList,
        date,
        isFiltered,
        writtenText,
        // chosenDirector,
        getResult,
        getResultTemp,
        chosenDirectorFilter,
        directorFilter,
      ];

  static StaffDashboardProjectState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const StaffDashboardProjectState(
        projectStaffDashBoardEnumStates:
            ProjectStaffDashBoardEnumStates.loading,
        // companyStaffDashBoardList: <List<CompanyStaffDashBoard>>[],
        projectStaffDashBoardList: <ProjectStaffDashboardModel>[],
        date: "",
      );
    }
    int val = json['projectStaffDashBoardEnumStates'];
    String date = json['date'];
    return StaffDashboardProjectState(
      projectStaffDashBoardEnumStates:
          ProjectStaffDashBoardEnumStates.values[val],
      // getAttendanceList : List<MyAttendanceModel>.from(
      //     json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
      // companyStaffDashBoardList: List<List<CompanyStaffDashBoard>>.from(
      //     json['getAttendanceList']?.map((p) =>
      //         CompanyStaffDashBoard.fromJson(p))),
      projectStaffDashBoardList: List<ProjectStaffDashboardModel>.from(
          json['getAttendanceList']
              ?.map((p) => ProjectStaffDashboardModel.fromJson(p))),
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectStaffDashBoardEnumStates': projectStaffDashBoardEnumStates.index,
      'projectStaffDashBoardList': projectStaffDashBoardList,
      'date': date
    };
  }
}
