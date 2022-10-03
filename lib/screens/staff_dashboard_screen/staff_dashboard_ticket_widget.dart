import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_projects_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/url_links.dart';

class StaffDashBoardTicketWidget extends StatelessWidget {
  final List<CompanyStaffDashBoard> staffDashboardList;
  final String date;

  const StaffDashBoardTicketWidget(this.staffDashboardList, this.date,
      {Key? key})
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
      physics: const BouncingScrollPhysics(),
      itemCount: staffDashboardList.length,
      itemBuilder: (context, index) {
        attendManPowerSub = (staffDashboardList[index].laborAttend??0 +
                staffDashboardList[index].staffAttend!)
            .round();

        absentManPowerSub = ((staffDashboardList[index].laborCount??0 +
                    staffDashboardList[index].staffCount!) -
                (staffDashboardList[index].laborAttend??0 +
                    staffDashboardList[index].staffAttend!))
            .round();

        totalManPowerSub = (staffDashboardList[index].laborCount??0 +
                staffDashboardList[index].staffCount!)
            .round();

        totalContractorsSub =
            (staffDashboardList[index].subContractor??0).round();

        labourCount = (staffDashboardList[index].laborCount??0).round();
        staffCount = (staffDashboardList[index].staffCount??0).round();

        return InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(StaffDashBoardProjectScreen.routeName, arguments: {
              StaffDashBoardProjectScreen.companyID:
                  staffDashboardList[index].id.toString(),
              StaffDashBoardProjectScreen.project: "0",
              StaffDashBoardProjectScreen.director: "0",
              StaffDashBoardProjectScreen.date: date.toString(),
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Stack(
              // fit: StackFit.passthrough,
              children: [
                Container(
                  height: 185,
                  // padding: const EdgeInsets.only(top: 20.0),
                  margin: const EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Assets.images.staffdashboard.dashboardsub1
                            .image()
                            .image),
                  ),
                  // child: Container(
                    // padding: const EdgeInsets.only(
                    //     left: 100.0, right: 20.0, bottom: 10.0, top: 15.0),
                    // decoration: BoxDecoration(
                    //   // color: Colors.red,
                    //   image: DecorationImage(
                    //       alignment: Alignment.topLeft,
                    //       fit: BoxFit.fitHeight,scale: 9,
                    //       image: CachedNetworkImageProvider(
                    //           subsidiariesIconLink('HAC.png'),)),
                    // ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20,top: 20,bottom: 45),
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                                imageUrl: subsidiariesIconLink(getSubsidiariesPhotoLink(staffDashboardList[index].id??0)),
                              placeholder: (_,__) => Assets.images.favicon.image(),
                              errorWidget: (_,__,___) => Assets.images.favicon.image(),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0,right: 15,left: 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Attendance",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          Text(attendManPowerSub.toString(),
                                              style: const TextStyle(
                                                  color: ConstantsColors
                                                      .greenAttendance)),
                                        ],
                                      ),
                                      getLinearProgressAttend(context,
                                          attendManPowerSub??0, totalManPowerSub??0),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Absents",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          Text(
                                            absentManPowerSub.toString(),
                                            style: const TextStyle(
                                                color:
                                                    ConstantsColors.redAttendance),
                                          ),
                                        ],
                                      ),
                                      getLinearProgressAbsent(context,
                                          absentManPowerSub??0, totalManPowerSub??0),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Contractors",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          Text(totalContractorsSub.toString(),
                                              style: const TextStyle(
                                                  color: Colors.yellow)),
                                        ],
                                      ),
                                      getLinearContractors(context),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade600,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: Assets.images.staffdashboard.dashboardsub4
                                  .image()
                                  .image,
                              height: 40,
                              width: 40,
                            ),
                            Text(
                              staffCount.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image(
                              image: Assets.images.staffdashboard.dashboardsub3
                                  .image()
                                  .image,
                              height: 40,
                              width: 40,
                            ),
                            Text(
                              labourCount.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  LinearPercentIndicator getLinearProgressAttend(
      context, int value, int total) {
    int percentage = ((value / total) * 100).round();
    return LinearPercentIndicator(
      animation: true,
      // center: Text(
      //   "$percentage%",
      //   style: TextStyle(color: Colors.white),
      // ),
      // widgetIndicator: Text(
      //   "$percentage%",
      //   style: TextStyle(color: Colors.white,fontSize: 14),
      // ),
      lineHeight: 2.0,
      animationDuration: 2000,
      percent: percentage / 100,
      trailing: Text(
        "$percentage%",
        style: const TextStyle(color: Colors.white),
      ),
      barRadius: const Radius.circular(10),
      progressColor: Colors.greenAccent,
    );
  }

  LinearPercentIndicator getLinearProgressAbsent(
      context, int value, int total) {
    int percentage = ((value / total) * 100).round();
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 2.0,
      animationDuration: 2000,
      percent: percentage / 100,
      trailing: Text(
        "$percentage%",
        style: const TextStyle(color: Colors.white),
      ),

      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(10),
      progressColor: ConstantsColors.redAttendance,
    );
  }

  LinearPercentIndicator getLinearContractors(context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 2.0,
      animationDuration: 2000,
      percent: 20 / 100,
      // center: Text(percentage.toString()+"%"),
      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(10),
      progressColor: Colors.yellow,
    );
  }

  String getSubsidiariesPhotoLink(int deptId){
    switch (deptId){
      case 15: return 'HAH.png';
      case 9: return 'HAC.png';
      case 12: return 'HAT.png';
      case 18: return 'Inteck.png';
      case 21: return 'Jinet.png';
      case 19: return 'PGESCO.png';
      case 17: return 'CHEMTECH.png';
      case 1: return 'Core.png';
      case 5: return 'HATE.png';
      case 3: return '3s.png';
      case 20: return 'flag-circle-algeria.png';
      // case 22: return 'legacy.png';
      case 7: return 'Util.png';
      case 6: return 'HAR.png';

    // case : return 'Bioworks.png';
    // case : return 'Lightsource.png';
    // case : return 'HAP.png';

      default: return 'null';
    }

  }

}
