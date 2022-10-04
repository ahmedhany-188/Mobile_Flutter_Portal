
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_providers.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:http/http.dart' as http;

class StaffDashBoardRepository {

  final StaffDashBoardDataProvider staffDashBoardDataProvider = StaffDashBoardDataProvider();

  MainUserData? userData;

  static final StaffDashBoardRepository _inst = StaffDashBoardRepository._internal();

  StaffDashBoardRepository._internal();

  factory StaffDashBoardRepository(MainUserData userData) {
    _inst.userData = userData;
    return _inst;
  }

  // Future<List<CompanyStaffDashBoard>> getStaffDashBoardData(String hrCode,String Date) async {
  Future<List<CompanyStaffDashBoard>> getStaffDashBoardData(String hrCode,String date) async {

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userData?.user?.token}',
    };
    final http.Response rawStaffDashboard = await staffDashBoardDataProvider.getUserAccessCompany(header,hrCode, date);

    final json = await jsonDecode(rawStaffDashboard.body);


    List<CompanyStaffDashBoard> myCompanyDashBoardList = List<CompanyStaffDashBoard>.from(
        json.map((model) => CompanyStaffDashBoard.fromJson(model)));

    return myCompanyDashBoardList;
  }

}