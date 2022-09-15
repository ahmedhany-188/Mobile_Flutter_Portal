import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';

class StaffDashboardJobWidget extends StatelessWidget {
  final List<JobStaffDashboardModel> staffDashBoardJobList;

  const StaffDashboardJobWidget(this.staffDashBoardJobList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status;
    bool isLabour;
    int count, total;

    return (staffDashBoardJobList.isNotEmpty)
        ? GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: (16 / 10),
            ),
            padding: const EdgeInsets.all(5),
            itemCount: staffDashBoardJobList.length,
            itemBuilder: (BuildContext context, int index) {
              // id = staffDashBoardJobList[index].id ?? 0;
              status = staffDashBoardJobList[index].status ?? "";
              count = staffDashBoardJobList[index].count ?? 0;
              total = staffDashBoardJobList[index].total ?? 0;
              isLabour = staffDashBoardJobList[index].islabor ?? false;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber.shade600,
                      image: DecorationImage(
                        image: isLabour == false
                            ? Assets.images.staffdashboard.staffbox
                                .image()
                                .image
                            : Assets.images.staffdashboard.laboreffect
                                .image()
                                .image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: Text(status,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Attendance",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    count.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "ManPower",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    total.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: isLabour == false
                            ? Assets.images.staffdashboard.staffeffect
                                .image()
                                .image
                            : Assets.images.staffdashboard.laboreffect
                                .image()
                                .image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        : const Center(
            child: Text('No Data Found'),
          );
  }
}
