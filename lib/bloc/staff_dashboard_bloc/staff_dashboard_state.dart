part of 'staff_dashboard_cubit.dart';


enum CompanyStaffDashBoardEnumStates {loading, success, failed,noConnection,noDataFound}

class StaffDashboardState extends Equatable {

  final CompanyStaffDashBoardEnumStates companyStaffDashBoardEnumStates;
  // final List<List<CompanyStaffDashBoard>> companyStaffDashBoardList;
  final List<CompanyStaffDashBoard> companyStaffDashBoardList;

  String date;

  StaffDashboardState({

    this.companyStaffDashBoardEnumStates = CompanyStaffDashBoardEnumStates
        .loading,
    // this.companyStaffDashBoardList = const <List<CompanyStaffDashBoard>>[],
    this.companyStaffDashBoardList = const <CompanyStaffDashBoard>[],

    required this.date,

  });

  StaffDashboardState copyWith({
    CompanyStaffDashBoardEnumStates? companyStaffDashBoardEnumStates,
    // List<List<CompanyStaffDashBoard>>? companyStaffDashBoardList,
    List<CompanyStaffDashBoard>? companyStaffDashBoardList,

    String? date,
  }) {
    return StaffDashboardState(
      companyStaffDashBoardEnumStates: companyStaffDashBoardEnumStates ??
          this.companyStaffDashBoardEnumStates,
      companyStaffDashBoardList: companyStaffDashBoardList ??
          this.companyStaffDashBoardList,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props =>
      [
        companyStaffDashBoardEnumStates, companyStaffDashBoardList,date
      ];

  static StaffDashboardState? fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return StaffDashboardState(
        companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
            .loading,
        // companyStaffDashBoardList: <List<CompanyStaffDashBoard>>[],
        companyStaffDashBoardList: <CompanyStaffDashBoard>[],

        date: "",
      );
    }
    int val = json['attendanceDataEnumStates'];
    String date = json['date'];
    return StaffDashboardState(
      companyStaffDashBoardEnumStates: CompanyStaffDashBoardEnumStates
          .values[val],
      // getAttendanceList : List<MyAttendanceModel>.from(
      //     json['getAttendanceList']?.map((p) => MyAttendanceModel.fromJson(p))),
      // companyStaffDashBoardList: List<List<CompanyStaffDashBoard>>.from(
      //     json['getAttendanceList']?.map((p) =>
      //         CompanyStaffDashBoard.fromJson(p))),
      companyStaffDashBoardList: List<CompanyStaffDashBoard>.from(
          json['getAttendanceList']?.map((p) =>
              CompanyStaffDashBoard.fromJson(p))),
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyStaffDashBoardEnumStates': companyStaffDashBoardEnumStates.index,
      'companyStaffDashBoardList': companyStaffDashBoardList,
      'date': date
    };
  }


}


