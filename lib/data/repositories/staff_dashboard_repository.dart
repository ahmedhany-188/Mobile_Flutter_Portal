
import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/staff_dashboard_provider/staff_dashboard_providers.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:http/http.dart' as http;

class StaffDashBoardRepository {

  final StaffDashBoardDataProvider staffDashBoardDataProvider = StaffDashBoardDataProvider();

  // Future<List<CompanyStaffDashBoard>> getStaffDashBoardData(String hrCode,String Date) async {
  Future<List<CompanyStaffDashBoard>> getStaffDashBoardData(String hrCode,String Date) async {

    final http.Response rawStaffDashboard = await staffDashBoardDataProvider.getUserAccessCompany(hrCode, Date);

    final json = await jsonDecode(rawStaffDashboard.body);


    print("-----"+json.toString());
    List<CompanyStaffDashBoard> myCompanyDashBoardList = List<CompanyStaffDashBoard>.from(
        json.map((model) => CompanyStaffDashBoard.fromJson(model)));
    print("-----"+myCompanyDashBoardList.toString());

    return myCompanyDashBoardList;
  }

}