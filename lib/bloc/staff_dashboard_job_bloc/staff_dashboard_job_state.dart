part of 'staff_dashboard_job_cubit.dart';

enum JobStaffDashBoardEnumStates { loading, success, failed, noConnection }

class StaffDashboardJobState extends Equatable {
  final JobStaffDashBoardEnumStates jobStaffDashBoardEnumStates;
  final List<JobStaffDashboardModel> jobStaffDashBoardList;
  final List<JobStaffDashboardModel> jobStaffDashBoardSearchList;
  final bool isFiltered;
  final String date;

  const StaffDashboardJobState({
    this.jobStaffDashBoardEnumStates = JobStaffDashBoardEnumStates.loading,
    this.jobStaffDashBoardList = const <JobStaffDashboardModel>[],
    this.jobStaffDashBoardSearchList = const <JobStaffDashboardModel>[],
    this.isFiltered = false,
    required this.date,
  });

  StaffDashboardJobState copyWith({
    JobStaffDashBoardEnumStates? jobStaffDashBoardEnumStates,
    List<JobStaffDashboardModel>? jobStaffDashBoardList,
    List<JobStaffDashboardModel>? jobStaffDashBoardSearchList,
    bool? isFiltered,
    String? date,
  }) {
    return StaffDashboardJobState(
      jobStaffDashBoardEnumStates:
          jobStaffDashBoardEnumStates ?? this.jobStaffDashBoardEnumStates,
      jobStaffDashBoardList:
          jobStaffDashBoardList ?? this.jobStaffDashBoardList,
      jobStaffDashBoardSearchList:
          jobStaffDashBoardSearchList ?? this.jobStaffDashBoardSearchList,
      isFiltered: isFiltered ?? this.isFiltered,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [
        jobStaffDashBoardEnumStates,
        jobStaffDashBoardList,
        date,
        jobStaffDashBoardSearchList,
        isFiltered
      ];

  static StaffDashboardJobState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const StaffDashboardJobState(
        jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.loading,
        jobStaffDashBoardList: <JobStaffDashboardModel>[],
        date: "",
      );
    }
    int val = json['projectStaffDashBoardEnumStates'];
    String date = json['date'];
    return StaffDashboardJobState(
      jobStaffDashBoardEnumStates: JobStaffDashBoardEnumStates.values[val],
      // getAttendanceList : List<MyAttendanceModel>.from(
      //     json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
      // companyStaffDashBoardList: List<List<CompanyStaffDashBoard>>.from(
      //     json['getAttendanceList']?.map((p) =>
      //         CompanyStaffDashBoard.fromJson(p))),
      jobStaffDashBoardList: List<JobStaffDashboardModel>.from(
          json['getAttendanceList']
              ?.map((p) => JobStaffDashboardModel.fromJson(p))),
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
