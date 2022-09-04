import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:heroicons/heroicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StaffDashBoardTicketWidget extends StatelessWidget {

  List<CompanyStaffDashBoard> staffDashboardList;

  StaffDashBoardTicketWidget(this.staffDashboardList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    int? attendManPowerSub = 0;
    int? totalManPowerSub = 0;
    int? absentManPowerSub = 0;
    int? totalContractorsSub = 0;
    int labourCount=0;
    int staffCount=0;

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

          totalContractorsSub = (staffDashboardList[index].subContractor!).round();

          labourCount=(staffDashboardList[index].laborCount!).round();
          staffCount=(staffDashboardList[index].staffCount!).round();

          return Padding(
            padding: const EdgeInsets.all(10.0),
                child:InputDecorator(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 0, vertical: 5),
                    labelText: "Hassan allam holding",
                    floatingLabelAlignment:
                    FloatingLabelAlignment.center,
                    // prefixIcon: Icon(Icons.stacked_bar_chart,
                    //     color: Colors.white70),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceAround,
                          children: [
                            Row(
                              children: [
                                const HeroIcon(HeroIcons.users),
                                Text(
                                  staffCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.white),),
                              ],
                            ),
                          Row(children: [
                            const HeroIcon(HeroIcons.users),
                            Text(
                              labourCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white),),
                          ],)
                        ],),
                        Column(children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Attendance"),
                                    Text(attendManPowerSub.toString(),style:TextStyle(color: ConstantsColors.greenAttendance)),
                                  ],
                                ),
                                getLinearProgressAttend(context,attendManPowerSub!,totalManPowerSub!),
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Absents"),
                                    Text(absentManPowerSub.toString(),style: TextStyle(color: ConstantsColors.redAttendance),),
                                  ],
                                ),
                                getLinearProgressAbsent(context,absentManPowerSub!,totalManPowerSub!),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Contractors"),
                                    Text(totalContractorsSub.toString()),
                                  ],
                                ),
                                getLinearContractors(context!),
                              ],
                            ),
                          ),

                        ],),
                      ],
                    ),
                  ),
                ),
          );
        });
  }

  LinearPercentIndicator getLinearProgressAttend(context, int value, int total) {
    int  percentage=((value/total)*100).round();
      return LinearPercentIndicator(
        animation: true,
        lineHeight: 15.0,
        animationDuration: 2000,
        percent: percentage / 100,
        center: Text(percentage.toString()+"%"),
        // linearStrokeCap: LinearStrokeCap.roundAll,
        barRadius: const Radius.circular(10),
        progressColor: ConstantsColors.greenAttendance,
      );
  }

  LinearPercentIndicator getLinearProgressAbsent(context, int value, int total) {
    int  percentage=((value/total)*100).round();
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 15.0,
      animationDuration: 2000,
      percent: percentage / 100,
      center: Text(percentage.toString()+"%"),
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
        percent: 25 / 100,
        // center: Text(percentage.toString()+"%"),
        // linearStrokeCap: LinearStrokeCap.roundAll,
        barRadius: const Radius.circular(10),
        progressColor: ConstantsColors.backgroundStartColor,
    );
  }
}