import 'dart:convert';
import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_job_provider.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:http/http.dart' as http;

class StaffDashBoardJobRepository {

  final StaffDashBoardJobDataProvider staffDashBoardJobDataProvider = StaffDashBoardJobDataProvider();

  Future<List<JobStaffDashboardModel>> getStaffDashBoardData(String projectCode,String director,String jobTitle,String fromDay,String toDay) async {
    final http.Response rawStaffDashboard = await staffDashBoardJobDataProvider.getJobByProjects( projectCode, director, jobTitle, fromDay,toDay);
    final json = await jsonDecode(rawStaffDashboard.body);
    List<JobStaffDashboardModel> myJobDashBoardList = List<JobStaffDashboardModel>.from(
        json.map((model) => JobStaffDashboardModel.fromJson(model)));
    print("-----"+myJobDashBoardList.toString());

    return myJobDashBoardList;

  }
}