import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_projects_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StaffDashBoardTicketWidget extends StatelessWidget {

  List<CompanyStaffDashBoard> staffDashboardList;
  String date;

  StaffDashBoardTicketWidget(this.staffDashboardList, this.date, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? attendManPowerSub = 0;
    int? totalManPowerSub = 0;
    int? absentManPowerSub = 0;
    int? totalContractorsSub = 0;
    int labourCount = 0;
    int staffCount = 0;

    return ListView.builder(
        itemCount: staffDashboardList.length,
        itemBuilder: (BuildContext context, int index) {
          attendManPowerSub = (staffDashboardList[index].laborAttend! +
              staffDashboardList[index].staffAttend!).round();

          absentManPowerSub = ((staffDashboardList[index].laborCount! +
              staffDashboardList[index].staffCount!) -
              (staffDashboardList[index].laborAttend! +
                  staffDashboardList[index].staffAttend!)).round();

          totalManPowerSub = (staffDashboardList[index].laborCount! +
              staffDashboardList[index].staffCount!).round();

          totalContractorsSub =
              (staffDashboardList[index].subContractor!).round();

          labourCount = (staffDashboardList[index].laborCount!).round();
          staffCount = (staffDashboardList[index].staffCount!).round();

          return InkWell(

            onTap: () {
              Navigator.of(context).pushNamed(
                  StaffDashBoardProjectScreen.routeName,
                  arguments: {
                    StaffDashBoardProjectScreen
                        .companyID: staffDashboardList[index].id.toString(),
                    StaffDashBoardProjectScreen.project: "0",
                    StaffDashBoardProjectScreen.director: "0",
                    StaffDashBoardProjectScreen.date: date.toString(),
                  });
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 30.0),
                         child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: ConstantsColors.petrolTextAttendance
                           ),
                           child: Padding(
                             padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 15.0),
                             child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Attendance",
                                                  style: TextStyle(color: Colors.white)),
                                              Text(attendManPowerSub.toString(),
                                                  style: TextStyle(color: ConstantsColors.greenAttendance)),
                                            ],
                                          ),
                                          getLinearProgressAttend(
                                              context, attendManPowerSub!,
                                              totalManPowerSub!),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Absents",
                                                  style: TextStyle(color: Colors.white)),
                                              Text(absentManPowerSub.toString(),
                                                style: TextStyle(color: ConstantsColors.redAttendance),),
                                            ],
                                          ),
                                          getLinearProgressAbsent(
                                              context, absentManPowerSub!,
                                              totalManPowerSub!),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Contractors",
                                                  style: TextStyle(color: Colors.white)),
                                              Text(totalContractorsSub.toString(),
                                                  style: TextStyle(color: Colors.yellow)),
                                            ],),
                                          getLinearContractors(context),
                                        ],),
                                    ),
                                ],),
                           ),
                         ),
                       ),

                      Padding(
                        padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceAround,
                            children: [
                              Row(
                                children: [
                                  Image(image: Assets.images.staffdashboard
                                      .dashboardsub4
                                      .image()
                                      .image,
                                    height: 40, width: 40,),
                                  Text(
                                    staffCount.toString(),
                                    style: const TextStyle(
                                        color: Colors.white),),
                                ],
                              ),
                              Row(children: [
                                Image(
                                  image: Assets.images.staffdashboard.dashboardsub3
                                      .image()
                                      .image, height: 40, width: 40,),
                                Text(
                                  labourCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.white),),
                              ],),
                            ],),
                        ),
                      ),
                    ],
              ),
            ),
          );
        });
  }



  LinearPercentIndicator getLinearProgressAttend(context, int value,
      int total) {
    int percentage = ((value / total) * 100).round();
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 15.0,
      animationDuration: 2000,
      percent: percentage / 100,
      center: Text(percentage.toString() + "%"),
      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(10),
      progressColor: ConstantsColors.greenAttendance,
    );
  }

  LinearPercentIndicator getLinearProgressAbsent(context, int value,
      int total) {
    int percentage = ((value / total) * 100).round();
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 15.0,
      animationDuration: 2000,
      percent: percentage / 100,
      center: Text(percentage.toString() + "%"),
      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(10),
      progressColor: ConstantsColors.redAttendance,
    );
  }

  LinearPercentIndicator getLinearContractors(context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 15.0,
      animationDuration: 2000,
      percent: 20 / 100,
      // center: Text(percentage.toString()+"%"),
      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(10),
      progressColor: Colors.yellow,
    );
  }
}