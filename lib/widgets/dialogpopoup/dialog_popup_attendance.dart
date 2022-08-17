
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
    return SingleChildScrollView(
      child: Column(
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

              checkViewForm(widget.attendanceListData),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Create New Request",
                  style: TextStyle(color: Colors.grey, fontSize: 20),),),

              Row(children: [

                Expanded(child:               sizeBoxRequest("Permission", Icon(Icons.timelapse,size: 50.0,)),
                ),
                Expanded(child:               sizeBoxRequest("Business Mission", Icon(Icons.hail,size: 50.0,)),
                ),
                Expanded(child:               sizeBoxRequest("Vacation", Icon(Icons.beach_access,size: 50.0,)),
                ),
                // sizeBoxRequest("Forget sign", const Icon(Icons.fingerprint)),
              ]),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Padding checkViewForm(MyAttendanceModel attendanceModel) {
    if (attendanceModel.vacation != null || attendanceModel.permission != null
        || attendanceModel.businessMission !=
            null) { // || attendanceModel.forget != null) {
      return requestForm(
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


  Padding requestForm(String requestType, Icon requestIcon){

    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: SizedBox(
          height: 40.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
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
                        decoration: BoxDecoration(
                          color:Colors.blueGrey,
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

  Padding sizeBoxRequest(String requestType, Icon requestIcon) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color:Colors.grey,
                            offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                            spreadRadius: 2.0)
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            // width: 40.0,
                            // height: 40.0,
                            // alignment: Alignment.centerLeft,
                            // decoration: BoxDecoration(
                            //   color:Colors.grey,
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(8.0),
                            //   ),
                            // ),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: requestIcon,)
                          ),
                          Expanded(
                              child: Center(
                                child: Text(requestType,
                                    style:
                                    TextStyle(color: Colors.black),
                                ),
                              )),
                        ],
                      ),
                      SizedBox.expand(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(onTap: () {
                            switch (requestType) {
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
      ),
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

