import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';

class ShowAttendanceBottomSheet extends StatelessWidget {
  const ShowAttendanceBottomSheet(
      {Key? key, required this.attendanceListData, required this.hrUser})
      : super(key: key);

  final MyAttendanceModel attendanceListData;
  final String hrUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.75,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: requestCase(),
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Requested',
                    prefixIcon: Icon(
                      Icons.all_inbox,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: attendanceListData.deduction ?? "No Comment",
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Deduction',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              checkViewForm(attendanceListData, context),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Create New Request",
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
              ),
              Row(children: [
                Flexible(
                  child: sizeBoxRequest(
                      "Permission",
                      const Icon(
                        Icons.timelapse,
                        size: 40.0,
                      ),
                      context),
                ),
                Flexible(
                  child: sizeBoxRequest(
                      "Business Mission",
                      const Icon(
                        Icons.hail,
                        size: 40.0,
                      ),
                      context),
                ),
                Flexible(
                  child: sizeBoxRequest(
                      "Vacation",
                      const Icon(
                        Icons.beach_access,
                        size: 40.0,
                      ),
                      context),
                ),
                // sizeBoxRequest("Forget sign", const Icon(Icons.fingerprint)),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Padding checkViewForm(
      MyAttendanceModel attendanceModel, BuildContext context) {
    if (attendanceModel.vacation != null){
      return requestForm("Show Vacation Form", iconRequest(attendanceListData), context);
    }
    if (attendanceModel.permission != null) {
      return requestForm("Show Permission Form", iconRequest(attendanceListData), context);
    }
    if(attendanceModel.businessMission != null){
      // || attendanceModel.forget != null) {
      return requestForm("Show Business Mission Form", iconRequest(attendanceListData), context);
    } else {
      return const Padding(
        padding: EdgeInsets.all(2.0),
      );
    }
  }

  String requestCase() {
    if (attendanceListData.permission != null) {
      return "Permission";
    } else if (attendanceListData.forget != null) {
      return "Forget sign";
    } else if (attendanceListData.businessMission != null) {
      return "Business Mission";
    } else if (attendanceListData.vacation != null) {
      return "Vacation";
    } else {
      return "No request";
    }
  }

  Padding requestForm(
      String requestType, Icon requestIcon, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25,right: 25,top: 15,bottom: 15),
        child: SizedBox(
          height: 40.0,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 2.0)
                ]),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        width: 40.0,
                        height: 40.0,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18.0),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.center, child: requestIcon)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(requestType,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black)),
                      ),
                    )
                  ],
                ),
                SizedBox.expand(
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(onTap: () {
                      switch (requestType) {
                        case "View Form":
                          if (attendanceListData.vacation != null) {
                            Navigator.of(context).pushNamed(
                                VacationScreen.routeName,
                                arguments: {
                                  VacationScreen.requestNoKey:
                                      attendanceListData.vacation.toString(),
                                  VacationScreen.requesterHRCode: hrUser
                                });
                            break;
                          } else if (attendanceListData.businessMission !=
                              null) {
                            Navigator.of(context).pushNamed(
                                BusinessMissionScreen.routeName,
                                arguments: {
                                  BusinessMissionScreen.requestNoKey:
                                      attendanceListData.businessMission
                                          .toString(),
                                  BusinessMissionScreen.requestDateAttendance:
                                      attendanceListData.date
                                });
                          } else {
                            Navigator.of(context).pushNamed(
                                PermissionScreen.routeName,
                                arguments: {
                                  PermissionScreen.requestNoKey:
                                      attendanceListData.permission.toString(),
                                  PermissionScreen.requestDateAttendance:
                                      attendanceListData.date
                                });
                          }
                          break;
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Padding sizeBoxRequest(
      String requestType, Icon requestIcon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 2.0),
                blurRadius: 8.0,
                spreadRadius: 2.0)
          ],
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: requestIcon,
                ),
                Center(
                  child: Text(
                    requestType,
                    style: const TextStyle(color: Colors.black),softWrap: false,
                  ),
                )
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () {
                  switch (requestType) {
                    case "Permission":
                      Navigator.of(context)
                          .pushNamed(PermissionScreen.routeName, arguments: {
                        PermissionScreen.requestNoKey: "0",
                        PermissionScreen.requestDateAttendance:
                            attendanceListData.date
                      });
                      break;
                    case "Vacation":
                      Navigator.of(context)
                          .pushNamed(VacationScreen.routeName, arguments: {
                        VacationScreen.requestNoKey: "0",
                        VacationScreen.requestDateAttendance:
                            attendanceListData.date
                      });
                      break;
                    case "Business Mission":
                      Navigator.of(context).pushNamed(
                          BusinessMissionScreen.routeName,
                          arguments: {
                            BusinessMissionScreen.requestNoKey: "0",
                            BusinessMissionScreen.requestDateAttendance:
                                attendanceListData.date
                          });
                      break;
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon iconRequest(MyAttendanceModel attendanceModel) {
    if (attendanceModel.vacation != null) {
      return const Icon(Icons.beach_access);
    } else if (attendanceModel.businessMission != null) {
      return const Icon(Icons.hail);
    } else if (attendanceModel.permission != null) {
      return const Icon(Icons.timelapse);
    } else {
      return const Icon(Icons.all_inbox);
    }
  }
}
