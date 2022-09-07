import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/projectstaffdashboard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_jobs_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StaffDashboardProjectWidget extends StatelessWidget {

  List<ProjectStaffDashboardModel> staffDashboardProjectList;
  String date;

  StaffDashboardProjectWidget(this.staffDashboardProjectList, this.date,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String projectName, projectManager;
    int employees, totalEmployees, staff, totalStaff, labour, totalLabour,
        subContractors, percEmployee, percLabour, perTotal;

    return ListView.builder(

      itemCount: staffDashboardProjectList.length,
      itemBuilder: (BuildContext context, int index) {
        projectName = staffDashboardProjectList[index].projectName ?? "";
        projectManager =
            staffDashboardProjectList[index].name ?? "Not Assigned";
        employees = staffDashboardProjectList[index].totalSignin ?? 0;
        totalEmployees = ((staffDashboardProjectList[index].cEmployees as int) +
            (staffDashboardProjectList[index].cLabors as int)) ?? 0;
        staff = staffDashboardProjectList[index].employees ?? 0;
        totalStaff = staffDashboardProjectList[index].cEmployees ?? 0;
        labour = staffDashboardProjectList[index].labors ?? 0;
        totalLabour = staffDashboardProjectList[index].cLabors ?? 0;
        subContractors = staffDashboardProjectList[index].subContractor ?? 0;

        percEmployee = staffDashboardProjectList[index].percEmp ?? 0;
        percLabour = staffDashboardProjectList[index].percLabor ?? 0;
        perTotal = staffDashboardProjectList[index].totalPerc ?? 0;

        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
                StaffDashboardJobScreen.routeName,
                arguments: {
                  StaffDashboardJobScreen
                      .projectCode: staffDashboardProjectList[index].id
                      .toString(),
                  StaffDashboardJobScreen.director: "0",
                  StaffDashboardJobScreen.jobTitle: "0",
                  StaffDashboardJobScreen.fromDay: date,
                  StaffDashboardJobScreen.toDay: date,
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [

              Column(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Assets.images.staffdashboard.boxlayer
                          .image()
                          .image,
                      fit: BoxFit.none,
                    ),
                  ),
                  child: Column(children: [
                    getHeader(projectName,0),
                    getHeader(projectManager,1),
                  ],),
                ),

                 Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.5),
                         spreadRadius: 5,
                         blurRadius: 7,
                         offset: Offset(0, 3), // changes position of shadow
                       ),
                     ],
                   ),

                    child: Column(children: [
                    Center(child: getLinearProgress(context,
                        "Total Employees: $employees From $totalEmployees",
                        perTotal)),
                    Center(child: getLinearProgress(
                        context, "Total Staff: $staff From $totalStaff",
                        percEmployee)),
                    Center(child: getLinearProgress(
                        context, "Total Labor: $labour From $totalLabour",
                        percLabour)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("$subContractors SubContractors"),
                        ),
                      ],
                    ),
                  ],),
                  ),
              ],),
            ],),
          ),
        );
      },
    );
  }

  Padding getHeader(String header,int number){

    return Padding(
      padding:number==0?EdgeInsets.only(top: 20,bottom: 2.0):EdgeInsets.only(top: 2.0,bottom: 20.0) ,
      child: Center(
        child: Text(header,
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Padding getLinearProgress(context, header, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(header, style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 5.0,
            animationDuration: 2000,
            percent: value / 100,
            // center: Text("$value%"),

            trailing: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text("$value%"),
            ),

            // linearStrokeCap: LinearStrokeCap.roundAll,
            barRadius: const Radius.circular(10),
            progressColor: ConstantsColors.petrolTextAttendance,
          ),
        ],
      ),
    );
  }

}