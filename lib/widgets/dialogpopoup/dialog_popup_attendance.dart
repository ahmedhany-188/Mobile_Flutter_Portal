
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';

class DialogPopUpAttendance extends StatefulWidget {


  const DialogPopUpAttendance({Key? key, required this.attendanceListData})
      : super(key: key);

  final MyAttendanceModel attendanceListData;

  @override
  DialogPopUpAttendanceClass createState() =>
      DialogPopUpAttendanceClass(attendanceListData);

}

class DialogPopUpAttendanceClass extends State<DialogPopUpAttendance> {
  DialogPopUpAttendanceClass(MyAttendanceModel attendanceListData);

  List<Widget> _getChildren(int count, String name) =>
      List<Widget>.generate(
        count,
            (i) => ListTile(title: Text('$name$i')),
      );


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),


      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }


  contentBox(context) {
    return Stack(
      children: <Widget>[

        Container(

          height: 500.0,

          padding: const EdgeInsets.only(left: 20, top: 45
              + 20, right: 20, bottom: 20
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(0, 3),
                    blurRadius: 3
                ),
              ]
          ),
          child: Container(
            margin: const EdgeInsets.all(10),

            child: Column(children: [
              TextFormField(
                initialValue: requestCase(),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Requested',
                  prefixIcon: Icon(
                      Icons.all_inbox),
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
              sizeBoxRequest("Permission", Icon(Icons.timelapse)),
              // sizeBoxRequest("Forget sign", const Icon(Icons.fingerprint)),
              sizeBoxRequest("Business Mission", Icon(Icons.hail)),
              sizeBoxRequest("Vacation", Icon(Icons.beach_access)),
            ],
            ),

          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Image.asset("assets/images/logo.png")
            ),
          ),
        ),
      ],
    );
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
          height: 36.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 2.0)
                ]),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: requestIcon)),
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
                        case "Permission":

                           Navigator.of(context)
                               .pushNamed(PermissionScreen.routeName,arguments: {PermissionScreen.requestNoKey:"0",
                             PermissionScreen.requestDateAttendance:widget.attendanceListData.date});

                          break;
                        case "Vacation":

                          Navigator.of(context)
                              .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey:"0",
                            VacationScreen.requestDateAttendance:widget.attendanceListData.date});

                          break;
                        case "Business Mission":


                          Navigator.of(context)
                              .pushNamed(BusinessMissionScreen.routeName,arguments: {BusinessMissionScreen.requestNoKey:"0",
                            BusinessMissionScreen.requestDateAttendance:widget.attendanceListData.date});

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

}

