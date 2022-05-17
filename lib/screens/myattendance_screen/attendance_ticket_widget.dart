import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';

import '../../widgets/map/open_map.dart';
import '../../constants/google_map_api_key.dart';

class AttendanceTicketWidget extends StatelessWidget {
  List<dynamic> projectsDirectionData;

  String time_in = "";
  String time_in2 = "";
  String time_out = "";
  String time_out2 = "";
  String name = "";
  bool holiday = false;
  String vacation = "";
  String permission = "";
  String BusinessMission = "";
  String forget = "";
  String month_period = "";
  String deduction = "";


  AttendanceTicketWidget(this.projectsDirectionData, {Key? key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(

      maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: projectsDirectionData.isNotEmpty,
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
              itemCount: projectsDirectionData.length,
              itemBuilder: (BuildContext context, int index) {
                List<String> date = projectsDirectionData[index]["date"]
                    .toString().split('-');

                time_in = projectsDirectionData[index]["time_IN"]
                    .toString()
                    .substring(0, 1);
                time_in2 = projectsDirectionData[index]["time_IN"]
                    .toString()
                    .substring(2, 4);

                time_out = projectsDirectionData[index]["time_OUT"]
                    .toString()
                    .substring(0, 1);
                time_out2 = projectsDirectionData[index]["time_OUT"]
                    .toString()
                    .substring(2, 4);

                holiday = projectsDirectionData[index]["holiday"];
                vacation = projectsDirectionData[index]["vacation"].toString();
                permission =
                    projectsDirectionData[index]["permission"].toString();
                BusinessMission =
                    projectsDirectionData[index]["businessMission"].toString();

                forget = projectsDirectionData[index]["forget"].toString();

                month_period =
                    projectsDirectionData[index]["monthPeriod"].toString();

                deduction =
                    projectsDirectionData[index]["deduction"].toString();



                if (projectsDirectionData[index]["time_IN"].toString() !=
                    "null" &&
                    projectsDirectionData[index]["time_OUT"].toString() !=
                        "null") {
                  if (((int.parse(time_out) >= 5) ||
                      (int.parse(time_out) == 4 &&
                          int.parse(time_out2) == 59)) &&
                      ((int.parse(time_in) < 8) || (int.parse(time_in) == 8 &&
                          int.parse(time_in2) < 31))) {
                    return Container(

                      width: double.infinity,
                      child: InkWell(
                          onTap: () {
                            Dialog_PopUp_UserProfile();
                          },

                          child: Column(children: [
                            Container(

                              child: Text(
                                  date[1] + "/" + date[2].substring(0, 2),
                                  style: TextStyle(color: Colors.white)),
                            ),

                            Container(


                              child: Text(
                                  projectsDirectionData[index]["time_IN"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.lightGreen,
                              ),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 30,

                            ),

                            Container(height: 5, color: Colors.white,),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              height: 30,
                              child: Text(
                                  projectsDirectionData[index]["time_OUT"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.lightGreen,
                              ),
                            ),
                          ])

                      ),

                    );
                  }

                  else if
                  (((int.parse(time_out) >= 5) || (int.parse(time_out) == 4 &&
                      int.parse(time_out2) == 59)) &&
                      ((int.parse(time_in) > 8) || (int.parse(time_in) == 8 &&
                          int.parse(time_in2) > 30))) {
                    return Container(
                      width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            Dialog_PopUp_UserProfile();
                          },
                      child: Column(children: [

                        Container(

                            child: Text(date[1] + "/" + date[2].substring(0, 2),
                                style: TextStyle(color: Colors.white))),

                        Container(
                          height: 30,
                          child: Text(projectsDirectionData[index]["time_IN"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.red,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                        ),
                        Container(height: 5,color:Colors.white,),

                        Container(
                          height: 30,
                          child: Text(projectsDirectionData[index]["time_OUT"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: Colors.lightGreen,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,

                        ),


                      ]),
                        ),
                    );
                  }
                  else if
                  ((int.parse(time_out) != 4 && int.parse(time_out2) != 59)
                      ||
                      (int.parse(time_out) != 4 && int.parse(time_out2) < 59) ||
                      (int.parse(time_out) < 5)
                          &&
                          ((int.parse(time_in) < 8) ||
                              (int.parse(time_in) == 8 &&
                                  int.parse(time_in2) < 31))) {
                    return Container(

                      width: double.infinity,
                        child: InkWell(
                        onTap: () {
                          Dialog_PopUp_UserProfile();
                    },
                      child: Column(children: [

                      Container(child:
                      Text(date[1] + "/" + date[2].substring(0, 2),
                          style: TextStyle(color: Colors.white)),),

                      Container(
                        height: 30,
                        child: Text(
                          projectsDirectionData[index]["time_IN"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.lightGreen,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),
                      Container(height: 5,color:Colors.white,),

                      Container(
                        height: 30,
                        child: Text(
                          projectsDirectionData[index]["time_OUT"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),


                    ]),
                        ),
                    );
                  }
                  else {
                    return Container(
                      width: double.infinity,
                    child: InkWell(
                    onTap: () {
                      Dialog_PopUp_UserProfile();
                    },
                       child: Column(children: [

                      Container(child: Text(
                          date[1] + "/" + date[2].substring(0, 2),
                          style: TextStyle(color: Colors.white)),),
                      Container(
                        height: 30,
                        child: Text(
                          projectsDirectionData[index]["time_IN"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),

                      Container(height: 5,color:Colors.white,),

                      Container(
                        height: 30,
                        child: Text(
                          projectsDirectionData[index]["time_OUT"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,),
                    ]),
                    ),
                    );
                  }
                }
                else {
                  return Container(
                    width: double.infinity,
                  child: InkWell(
                  onLongPress: () {
                    Dialog_PopUp_UserProfile();
                  },
                    child: Column(children: [
                      Container(
                        child: Text(date[1] + "/" + date[2].substring(0, 2),
                            style: TextStyle(color: Colors.white)),
                      ),
                      Container(

                        height: 65,
                        decoration: BoxDecoration(
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
