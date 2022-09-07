part of 'staff_dashboard_project_cubit.dart';

enum ProjectStaffDashBoardEnumStates {loading, success, failed,noConnection}



class StaffDashboardProjectState extends Equatable {

  final ProjectStaffDashBoardEnumStates projectStaffDashBoardEnumStates;
  // final List<List<CompanyStaffDashBoard>> companyStaffDashBoardList;
  final List<ProjectStaffDashboardModel> projectStaffDashBoardList;
  String date;


  StaffDashboardProjectState({
    this.projectStaffDashBoardEnumStates = ProjectStaffDashBoardEnumStates
        .loading,
    // this.companyStaffDashBoardList = const <List<CompanyStaffDashBoard>>[],
    this.projectStaffDashBoardList = const <ProjectStaffDashboardModel>[],
    required this.date,
  });

  StaffDashboardProjectState copyWith({
    ProjectStaffDashBoardEnumStates? projectStaffDashBoardEnumStates,
    // List<List<CompanyStaffDashBoard>>? companyStaffDashBoardList,
    List<ProjectStaffDashboardModel>? projectStaffDashBoardList,

    String? date,
  }) {
    return StaffDashboardProjectState(
      projectStaffDashBoardEnumStates: projectStaffDashBoardEnumStates ??
          this.projectStaffDashBoardEnumStates,
      projectStaffDashBoardList: projectStaffDashBoardList ??
          this.projectStaffDashBoardList,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props =>
      [
        projectStaffDashBoardEnumStates, projectStaffDashBoardList,date
      ];


  static StaffDashboardProjectState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return StaffDashboardProjectState(
        projectStaffDashBoardEnumStates: ProjectStaffDashBoardEnumStates
            .loading,
        // companyStaffDashBoardList: <List<CompanyStaffDashBoard>>[],
        projectStaffDashBoardList: <ProjectStaffDashboardModel>[],
        date: "",
      );
    }
    int val = json['projectStaffDashBoardEnumStates'];
    String date = json['date'];
    return StaffDashboardProjectState(
      projectStaffDashBoardEnumStates: ProjectStaffDashBoardEnumStates
          .values[val],
      // getAttendanceList : List<MyAttendanceModel>.from(
      //     json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
      // companyStaffDashBoardList: List<List<CompanyStaffDashBoard>>.from(
      //     json['getAttendanceList']?.map((p) =>
      //         CompanyStaffDashBoard.fromJson(p))),
      projectStaffDashBoardList: List<ProjectStaffDashboardModel>.from(
          json['getAttendanceList']?.map((p) =>
              ProjectStaffDashboardModel.fromJson(p))),
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