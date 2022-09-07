part of 'staff_dashboard_job_cubit.dart';

enum JobStaffDashBoardEnumStates {loading, success, failed,noConnection}

class StaffDashboardJobState extends Equatable {

  final JobStaffDashBoardEnumStates jobStaffDashBoardEnumStates;
  final List<JobStaffDashboardModel> jobStaffDashBoardList;
  String date;

  StaffDashboardJobState({
    this.jobStaffDashBoardEnumStates = JobStaffDashBoardEnumStates
        .loading,
    this.jobStaffDashBoardList = const <JobStaffDashboardModel>[],
    required this.date,
  });

  StaffDashboardJobState copyWith({
    JobStaffDashBoardEnumStates? jobStaffDashBoardEnumStates,
    // List<List<CompanyStaffDashBoard>>? companyStaffDashBoardList,
    List<JobStaffDashboardModel>? jobStaffDashBoardList,

    String? date,
  }) {
    return StaffDashboardJobState(
      jobStaffDashBoardEnumStates: jobStaffDashBoardEnumStates ??
          this.jobStaffDashBoardEnumStates,
      jobStaffDashBoardList: jobStaffDashBoardList ??
          this.jobStaffDashBoardList,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props =>
      [
        jobStaffDashBoardEnumStates, jobStaffDashBoardList,date
      ];

  static StaffDashboardJobState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return StaffDashboardJobState(
        jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
            .loading,
        // companyStaffDashBoardList: <List<CompanyStaffDashBoard>>[],
        jobStaffDashBoardList: <JobStaffDashboardModel>[],
        date: "",
      );
    }
    int val = json['projectStaffDashBoardEnumStates'];
    String date = json['date'];
    return StaffDashboardJobState(
      jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates
          .values[val],
      // getAttendanceList : List<MyAttendanceModel>.from(
      //     json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
      // companyStaffDashBoardList: List<List<CompanyStaffDashBoard>>.from(
      //     json['getAttendanceList']?.map((p) =>
      //         CompanyStaffDashBoard.fromJson(p))),
      jobStaffDashBoardList: List<JobStaffDashboardModel>.from(
          json['getAttendanceList']?.map((p) =>
              JobStaffDashboardModel.fromJson(p))),
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobStaffDashBoardEnumStates': jobStaffDashBoardEnumStates.index,
      'jobStaffDashBoardList': jobStaffDashBoardList,
      'date': date
    };
  }


}
