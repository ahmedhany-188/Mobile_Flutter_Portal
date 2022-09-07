import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_project_provider.dart';
import 'package:http/http.dart' as http;
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/projectstaffdashboard_model.dart';

class StaffDashBoardProjectRepository {

  final StaffDashBoardProjectDataProvider staffDashBoardProjectDataProvider = StaffDashBoardProjectDataProvider();

  Future<List<ProjectStaffDashboardModel>> getStaffDashBoardData(String company,String project,String director,String date) async {


    final http.Response rawStaffDashboard = await staffDashBoardProjectDataProvider.getProjectsBySubs(company,project,director,date);
    final json = await jsonDecode(rawStaffDashboard.body);

    print("-----"+json.toString());

    List<ProjectStaffDashboardModel> myProjectDashBoardList = List<ProjectStaffDashboardModel>.from(
        json.map((model) => ProjectStaffDashboardModel.fromJson(model)));

    print("-----"+myProjectDashBoardList.toString());

    return myProjectDashBoardList;

  }

}