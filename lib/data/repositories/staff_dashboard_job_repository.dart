import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_job_provider.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:http/http.dart' as http;

class StaffDashBoardJobRepository {

  final StaffDashBoardJobDataProvider staffDashBoardJobDataProvider = StaffDashBoardJobDataProvider();

  MainUserData? userData;

  static final StaffDashBoardJobRepository _inst = StaffDashBoardJobRepository._internal();

  StaffDashBoardJobRepository._internal();

  factory StaffDashBoardJobRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  Future<List<JobStaffDashboardModel>> getStaffDashBoardData(String projectCode,String director,String jobTitle,String fromDay,String toDay) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawStaffDashboard = await staffDashBoardJobDataProvider.getJobByProjects( header,projectCode, director, jobTitle, fromDay,toDay);
    final json = await jsonDecode(rawStaffDashboard.body);
    List<JobStaffDashboardModel> myJobDashBoardList = List<JobStaffDashboardModel>.from(
        json.map((model) => JobStaffDashboardModel.fromJson(model)));
    print("-----"+myJobDashBoardList.toString());

    return myJobDashBoardList;

  }
}