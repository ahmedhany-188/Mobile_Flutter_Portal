import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';

class StaffDashboardJobWidget extends StatelessWidget {

  List<JobStaffDashboardModel> staffDashBoardJobList;

  StaffDashboardJobWidget(this.staffDashBoardJobList);

  @override
  Widget build(BuildContext context) {
    String status;
    bool isLabour;
    int id, count, total;

    return GridView.builder(
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: (1 / .4),
        mainAxisExtent: 170, // here set custom Height You Want

      ),
      itemCount: staffDashBoardJobList.length,
      itemBuilder: (BuildContext context, int index) {
        id = staffDashBoardJobList[index].id ?? 0;
        status = staffDashBoardJobList[index].status ?? "";
        count = staffDashBoardJobList[index].count ?? 0;
        total = staffDashBoardJobList[index].total ?? 0;
        isLabour = staffDashBoardJobList[index].islabor ?? false;

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: isLabour == false ? Assets.images.staffdashboard
                        .staffbox
                        .image()
                        .image :
                    Assets.images.staffdashboard.laborbox
                        .image()
                        .image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Card(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            status, style: const TextStyle(
                            color: Colors.white, fontSize: 16)),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Column(children: [
                            const Text("Attendance", style: TextStyle(
                                color: Colors.white, fontSize: 14),),
                            Text(count.toString(), style: const TextStyle(
                                color: Colors.white, fontSize: 14),),
                          ],),
                            const VerticalDivider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          Column(children: [
                            const Text("ManPower", style: TextStyle(
                                color: Colors.white, fontSize: 14),),
                            Text(total.toString(), style: const TextStyle(
                                color: Colors.white, fontSize: 14),),
                          ],)
                        ],),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: isLabour == false ? Assets.images.staffdashboard
                        .staffeffect
                        .image()
                        .image :
                    Assets.images.staffdashboard.laboreffect
                        .image()
                        .image,
                    fit: BoxFit.cover,
                  ),
                ),),
            ],
          ),
        );
      },
    );
  }
}