import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';


// ignore: must_be_immutable
class AttendanceTicketWidget extends StatelessWidget {
  List<MyAttendanceModel> attendanceListData;

  String timeIn = "";
  String timeIn2 = "";
  String timeOut = "";
  String timeOut2 = "";
  bool holiday = false;
  String vacation = "";
  String permission = "";
  String businessMission = "";
  String forget = "";
  String monthPeriod = "";
  String deduction = "";


  AttendanceTicketWidget(this.attendanceListData, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: attendanceListData.isNotEmpty,
        builder: (context) =>
            GridView.builder(

              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                // childAspectRatio: (1 / .4),
                 mainAxisExtent: 90, // here set custom Height You Want
                // width between items
                crossAxisSpacing: 2,
                // height between items
                mainAxisSpacing: 2,
              ),
              itemCount: attendanceListData.length,
              itemBuilder: (BuildContext context, int index) {

                List<String> date = attendanceListData[index].date
                    .toString().split('-');



                if(attendanceListData[index].timeIN!=null && attendanceListData[index].timeOUT !=null){
                  timeIn = attendanceListData[index].timeIN
                      .toString()
                      .split(':')[0];
                  timeIn2 = attendanceListData[index].timeIN
                      .toString()
                      .split(':')[1];

                  timeIn2=timeIn2.replaceAll("AM", "");
                  timeIn2=timeIn2.replaceAll("PM", "");
                  timeOut = attendanceListData[index].timeOUT
                      .toString()
                      .split(':')[0];
                  timeOut2 = attendanceListData[index].timeOUT
                      .toString()
                      .split(':')[1];
                  timeOut2=timeOut2.replaceAll("AM", "");
                  timeOut2=timeOut2.replaceAll("PM", "");

                  print("----"+timeIn+"--"+timeIn2+"--");
                  print("----"+timeOut+"--"+timeOut2+"--");
                }



                holiday = attendanceListData[index].holiday!;
                vacation = attendanceListData[index].vacation.toString();
                permission =attendanceListData[index].permission.toString();

                businessMission =attendanceListData[index].businessMission.toString();

                forget = attendanceListData[index].forget.toString();

                monthPeriod =
                    attendanceListData[index].monthPeriod.toString();

                deduction =
                    attendanceListData[index].deduction.toString();

                if (attendanceListData[index].timeIN.toString() !=
                    "null" &&
                    attendanceListData[index].timeOUT.toString() !=
                        "null") {
                  if (((int.parse(timeOut) >= 5) ||
                      (int.parse(timeOut) == 4 &&
                          int.parse(timeOut2) == 59)) &&
                      ((int.parse(timeIn) < 8) || (int.parse(timeIn) == 8 &&
                          int.parse(timeIn2) < 31))) {
                    return SizedBox(

                      width: double.infinity,
                      child: InkWell(
                          onTap: () {
                             DialogPopUpUserProfile();
                          },

                          child: Column(children: [
                            Text(
                                "${date[1]}/${date[2].substring(0, 2)}",
                                style: const TextStyle(color: Colors.white,)),

                            Container(


                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.lightGreen,
                              ),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 30,


                              child: Text(
                                  attendanceListData[index].timeIN.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,)),

                            ),

                            Container(height: 5, color: Colors.white,),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              height: 30,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.lightGreen,
                              ),
                              child: Text(
                                  attendanceListData[index].timeOUT.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,)),
                            ),
                          ])

                      ),

                    );
                  }

                  else if
                  (((int.parse(timeOut) >= 5) || (int.parse(timeOut) == 4 &&
                      int.parse(timeOut2) == 59)) &&
                      ((int.parse(timeIn) > 8) || (int.parse(timeIn) == 8 &&
                          int.parse(timeIn2) > 30))) {
                    return SizedBox(
                      width: double.infinity,
                        child: InkWell(
                          onTap: () {
                             DialogPopUpUserProfile();
                          },
                      child: Column(children: [

                        Text("${date[1]}/${date[2].substring(0, 2)}",
                            style: const TextStyle(color: Colors.white)),

                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.red,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(attendanceListData[index].timeIN.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            )),
                        ),
                        Container(height: 5,color:Colors.white,),

                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: Colors.lightGreen,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(attendanceListData[index].timeOUT.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            )),

                        ),


                      ]),
                        ),
                    );
                  }
                  else if
                  ((int.parse(timeOut) != 4 && int.parse(timeOut2) != 59)
                      ||
                      (int.parse(timeOut) != 4 && int.parse(timeOut2) < 59) ||
                      (int.parse(timeOut) < 5)
                          &&
                          ((int.parse(timeIn) < 8) ||
                              (int.parse(timeIn) == 8 &&
                                  int.parse(timeIn2) < 31))) {
                    return SizedBox(

                      width: double.infinity,
                        child: InkWell(
                        onTap: () {
                           DialogPopUpUserProfile();
                    },
                      child: Column(children: [

                      Text("${date[1]}/${date[2].substring(0, 2)}",
                          style: const TextStyle(color: Colors.white)),

                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.lightGreen,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                            attendanceListData[index].timeIN.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),),
                      Container(height: 5,color:Colors.white,),

                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                            attendanceListData[index].timeOUT.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),),


                    ]),
                        ),
                    );
                  }
                  else {
                    return SizedBox(
                      width: double.infinity,
                    child: InkWell(
                    onTap: () {
                       DialogPopUpUserProfile();
                    },
                       child: Column(children: [

                      Text(
                          "${date[1]}/${date[2].substring(0, 2)}",
                          style: const TextStyle(color: Colors.white)),
                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                            attendanceListData[index].timeIN.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),),

                      Container(height: 5,color:Colors.white,),

                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                            attendanceListData[index].timeOUT.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),),
                    ]),
                    ),
                    );
                  }
                }
                else {
                  return SizedBox(
                    width: double.infinity,
                  child: InkWell(
                  onLongPress: () {
                    const DialogPopUpUserProfile();
                  },
                    child: Column(children: [
                      Text("${date[1]}/${date[2].substring(0, 2)}",
                          style: const TextStyle(color: Colors.white)),
                      Container(

                        height: 65,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)),
                          color: Colors.grey,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),
                    ]),
                  ),
                  );
                }
              },

            ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }

}
