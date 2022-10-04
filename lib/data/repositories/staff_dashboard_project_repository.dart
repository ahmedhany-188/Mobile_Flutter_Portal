import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_project_provider.dart';
import 'package:http/http.dart' as http;
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/projectstaffdashboard_model.dart';

class StaffDashBoardProjectRepository {

  final StaffDashBoardProjectDataProvider staffDashBoardProjectDataProvider = StaffDashBoardProjectDataProvider();

  MainUserData? userData;

  static final StaffDashBoardProjectRepository _inst = StaffDashBoardProjectRepository._internal();

  StaffDashBoardProjectRepository._internal();

  factory StaffDashBoardProjectRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  Future<List<ProjectStaffDashboardModel>> getStaffDashBoardData(String company,String project,String director,String date) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };

    final http.Response rawStaffDashboard = await staffDashBoardProjectDataProvider.getProjectsBySubs(header,company,project,director,date);
    final json = await jsonDecode(rawStaffDashboard.body);


    List<ProjectStaffDashboardModel> myProjectDashBoardList = List<ProjectStaffDashboardModel>.from(
        json.map((model) => ProjectStaffDashboardModel.fromJson(model)));


    return myProjectDashBoardList;

  }

}