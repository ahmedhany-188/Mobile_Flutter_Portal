
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';

class ShowAttendanceBottomSheet extends StatefulWidget {

  const ShowAttendanceBottomSheet({Key? key, required this.attendanceListData,required this.hrUser})
      : super(key: key);

  final MyAttendanceModel attendanceListData;
  final String hrUser;

  @override
  ShowAttendanceBottomSheetClass createState() =>
      ShowAttendanceBottomSheetClass(attendanceListData,hrUser);
}

class ShowAttendanceBottomSheetClass extends State<ShowAttendanceBottomSheet> {
  ShowAttendanceBottomSheetClass(MyAttendanceModel attendanceListData,
      String hrUser);

  List<Widget> _getChildren(int count, String name) =>
      List<Widget>.generate(
        count, (i) => ListTile(title: Text('$name$i')),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return ListView(
      children: <Widget>[

        Container(

          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
          ),
          child: Column(children: [

            TextFormField(
              initialValue: requestCase(),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Requested',
                prefixIcon: Icon(Icons.all_inbox),
              ),
            ),

            TextFormField(
              initialValue: widget.attendanceListData.deduction ??
                  "No Comment",
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Deduction',
                prefixIcon: Icon(
                    Icons.email),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Create Request",
                style: TextStyle(color: Colors.grey, fontSize: 20),),),

    // Row(children: [
            checkViewForm(widget.attendanceListData),
            sizeBoxRequest("Permission", Icon(Icons.timelapse)),
            // sizeBoxRequest("Forget sign", const Icon(Icons.fingerprint)),
            sizeBoxRequest("Business Mission", Icon(Icons.hail)),
            sizeBoxRequest("Vacation", Icon(Icons.beach_access)),
    // ]),
          ],
          ),


        ),
      ],
    );
  }

  Padding checkViewForm(MyAttendanceModel attendanceModel) {
    if (attendanceModel.vacation != null || attendanceModel.permission != null
        || attendanceModel.businessMission !=
            null) { // || attendanceModel.forget != null) {
      return sizeBoxRequest(
          "View Form", iconRequest(widget.attendanceListData));
    } else {
      return const Padding(padding: EdgeInsets.all(2.0),);
    }
  }


  String requestCase() {
    if (widget.attendanceListData.permission != null) {
      return "Permission";
    }
    else if (widget.attendanceListData.forget != null) {
      return "Forget sign";
    }
    else if (widget.attendanceListData.businessMission != null) {
      return "Business Mission";
    } else if (widget.attendanceListData.vacation != null) {
      return "Vacation";
    } else {
      return "No request";
    }
  }

  Padding sizeBoxRequest(String requestType, Icon requestIcon) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: SizedBox(
          height: 80.0,

          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: requestType == "View Form"
                          ? Colors.blueGrey
                          : Colors.grey,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 2.0)
                ]),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: requestType == "View Form"
                              ? Colors.blueGrey
                              : Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: requestIcon)
                    ),
                    Expanded(
                        child: Center(
                          child: Text(requestType,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: Colors.black)),
                        )),
                  ],
                ),
                SizedBox.expand(
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(onTap: () {
                      switch (requestType) {
                        case "View Form":
                          if (widget.attendanceListData.vacation != null) {
                            print("---" +
                                widget.attendanceListData.vacation.toString());
                            Navigator.of(context)
                                .pushNamed(VacationScreen.routeName, arguments:
                            {
                              VacationScreen.requestNoKey: widget
                                  .attendanceListData.vacation.toString(),
                              VacationScreen.requesterHRCode: widget.hrUser
                            });

                            break;
                          } else
                          if (widget.attendanceListData.businessMission !=
                              null) {
                            Navigator.of(context)
                                .pushNamed(
                                BusinessMissionScreen.routeName, arguments:
                            {
                              BusinessMissionScreen.requestNoKey: widget
                                  .attendanceListData.businessMission
                                  .toString(),
                              BusinessMissionScreen
                                  .requestDateAttendance: widget
                                  .attendanceListData.date
                            });
                          } else {
                            Navigator.of(context)
                                .pushNamed(
                                PermissionScreen.routeName, arguments:
                            {
                              PermissionScreen.requestNoKey: widget
                                  .attendanceListData.permission.toString(),
                              PermissionScreen.requestDateAttendance: widget
                                  .attendanceListData.date
                            });
                          }
                          break;

                        case "Permission":
                          Navigator.of(context)
                              .pushNamed(
                              PermissionScreen.routeName, arguments: {
                            PermissionScreen.requestNoKey: "0",
                            PermissionScreen.requestDateAttendance: widget
                                .attendanceListData.date});

                          break;
                        case "Vacation":
                          Navigator.of(context)
                              .pushNamed(VacationScreen.routeName,
                              arguments: {VacationScreen.requestNoKey: "0",
                                VacationScreen.requestDateAttendance: widget
                                    .attendanceListData.date});

                          break;
                        case "Business Mission":
                          Navigator.of(context)
                              .pushNamed(BusinessMissionScreen.routeName,
                              arguments: {BusinessMissionScreen
                                  .requestNoKey: "0",
                                BusinessMissionScreen
                                    .requestDateAttendance: widget
                                    .attendanceListData.date});

                          break;
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Icon iconRequest(MyAttendanceModel attendanceModel) {
    if (attendanceModel.vacation != null) {
      return const Icon(Icons.beach_access);
    }
    else if (attendanceModel.businessMission != null) {
      return const Icon(Icons.hail);
    }
    else if (attendanceModel.permission != null) {
      return const Icon(Icons.timelapse);
    }
    else {
      return const Icon(Icons.all_inbox);
    }
  }

}

