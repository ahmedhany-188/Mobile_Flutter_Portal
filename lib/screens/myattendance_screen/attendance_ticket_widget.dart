import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import '../../widgets/dialogpopoup/dialog_popup_attendance.dart';
import 'package:intl/intl.dart';

class AttendanceTicketWidget extends StatelessWidget {

  final List<MyAttendanceModel> attendanceListData;
  final String hrUser;

  String timeIn = "";
  String timeIn2 = "";
  String timeOut = "";
  String timeOut2 = "";

  AttendanceTicketWidget(this.attendanceListData, this.hrUser, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: attendanceListData.isNotEmpty,
      builder: (context) => GridView.builder(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
          List<String> date =
              attendanceListData[index].date.toString().split('-');

          if (attendanceListData[index].holiday == true ||
              attendanceListData[index].vacation != null) {
            return SizedBox(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  if (attendanceListData[index].vacation == null &&
                      attendanceListData[index].holiday == false) {
                    showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return ShowAttendanceBottomSheet(
                              attendanceListData: attendanceListData[index],
                              hrUser: hrUser);
                        });
                  }
                },
                child: Column(children: [
                  Text("${date[1]}/${date[2].substring(0, 2)}",
                      style: const TextStyle(color: Colors.white)),
                  holidayContainer(attendanceListData[index]),
                ]),
              ),
            );
          } else if (attendanceListData[index].businessMission != null ||
              attendanceListData[index].permission != null) {
            return sizedDay(attendanceListData[index], context, "in", "out",
                "blue", "blue", hrUser);
          } else if (attendanceListData[index].timeIN != null &&
              attendanceListData[index].timeOUT != null) {

            DateTime date1= DateFormat("hh:mma").parse(attendanceListData[index].timeIN.toString());
            DateTime date2= DateFormat("hh:mma").parse(attendanceListData[index].timeOUT.toString());

            String dateDay=DateFormat("HH:mm").format(date1);
            String dateNight=DateFormat("HH:mm").format(date2);

            timeIn = dateDay.split(':')[0];
            timeIn2 = dateDay.split(':')[1];

            timeOut = dateNight.split(':')[0];
            timeOut2 = dateNight.split(':')[1];



            if (attendanceListData[index]
                    .timeIN
                    .toString()
                    .split(':')[1]
                    .contains("PM") ||
                attendanceListData[index]
                    .timeOUT
                    .toString()
                    .split(':')[1]
                    .contains("AM")) {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "red", "red", hrUser);
            }

            else if (
            ((int.parse(timeOut) >= 17) || (int.parse(timeOut) == 16 && int.parse(timeOut2) == 59)) &&
                ((int.parse(timeIn) < 8) || (int.parse(timeIn) == 8 && int.parse(timeIn2) < 31))
            ) {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "green", "green", hrUser);
            } else if (
            ((int.parse(timeOut) >= 17) || (int.parse(timeOut) == 16 && int.parse(timeOut2) == 59)) &&
                ((int.parse(timeIn) > 8) || (int.parse(timeIn) == 8 && int.parse(timeIn2) > 30))
            ) {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "red", "green", hrUser);
            } else if (
            ((int.parse(timeOut) == 16 && int.parse(timeOut2) < 59) || (int.parse(timeOut) < 16)) &&
                ((int.parse(timeIn) < 8) || (int.parse(timeIn) == 8 && int.parse(timeIn2) < 31))
            ) {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "green", "red", hrUser);
            }
            else {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "red", "red", hrUser);
            }


          } else if (attendanceListData[index].timeIN.toString() != "null" &&
                  attendanceListData[index].timeOUT.toString() == "null" ||
              attendanceListData[index].timeIN.toString() == "null" &&
                  attendanceListData[index].timeOUT.toString() != "null") {
            return sizedDay(attendanceListData[index], context, "in", "out",
                "red", "red", hrUser);
          } else {
            if (attendanceListData[index].deduction == "غياب") {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "red", "red", hrUser);
            } else {
              return sizedDay(attendanceListData[index], context, "in", "out",
                  "grey", "grey", hrUser);
            }
          }
        },
      ),
      fallback:
          null, //(context) => const Center(child: LinearProgressIndicator()),
    );
  }
}

Container holidayContainer(MyAttendanceModel attendanceModel) {
  return Container(
    height: 65,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey,
    ),
    alignment: Alignment.center,
    width: double.infinity,
    child: iconContainer(attendanceModel),
  );
}

Container attendanceContainer(String timeText, String action, String color) {
  return Container(
    height: 30,
    decoration: BoxDecoration(
      borderRadius: action == "in"
          ? const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))
          : const BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
      color: containerColor(color),
    ),
    alignment: Alignment.center,
    width: double.infinity,
    child: Text(timeText,
        style: const TextStyle(
          color: ConstantsColors.petrolTextAttendance,
          fontSize: 11,
        )),
  );
}

Color containerColor(String color) {
  if (color == "green") {
    return ConstantsColors.greenAttendance;
  } else if (color == "red") {
    return ConstantsColors.redAttendance;
  } else if (color == "blue") {
    return Colors.blueGrey;
  } else {
    return ConstantsColors.whiteNormalAttendance;
  }
}

SizedBox sizedDay(
    MyAttendanceModel attendanceModel,
    BuildContext context,
    String dayMorning,
    String dayNight,
    String dayActionMorning,
    String dayActionNight,
    String hrUser) {
  List<String> date = attendanceModel.date.toString().split('-');

  return SizedBox(
    width: double.infinity,
    child: InkWell(
        onTap: () {
          if (attendanceModel.vacation == null &&
              attendanceModel.holiday != true) {
            showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return ShowAttendanceBottomSheet(
                      attendanceListData: attendanceModel, hrUser: hrUser);
                });
          }
        },
        child: Column(children: [
          Text("${date[1]}/${date[2].substring(0, 2)}",
              style: const TextStyle(
                color: Colors.white,
              )),
          attendanceContainer(
              attendanceModel.timeIN.toString() != "null"
                  ? attendanceModel.timeIN.toString()
                  : "",
              dayMorning,
              dayActionMorning),
          Container(
            height: 5,
            color: Colors.white,
          ),
          attendanceContainer(
              attendanceModel.timeOUT.toString() != "null"
                  ? attendanceModel.timeOUT.toString()
                  : "",
              dayNight,
              dayActionNight),
        ])),
  );
}

IconButton iconContainer(MyAttendanceModel attendanceModel) {
  if (attendanceModel.vacation != null) {
    return IconButton(
      icon: const Icon(
        Icons.beach_access,
        color: Colors.white70,
      ),
      onPressed: () {},
    );
  } else if (attendanceModel.businessMission != null) {
    return IconButton(
      icon: const Icon(Icons.hail),
      onPressed: () {},
    );
  } else if (attendanceModel.permission != null) {
    return IconButton(
      icon: const Icon(Icons.hail),
      onPressed: () {},
    );
  } else if (attendanceModel.forget != null) {
    return IconButton(
      icon: const Icon(Icons.timelapse),
      onPressed: () {},
    );
  } else if (attendanceModel.holiday == true) {
    return IconButton(
      icon: const Icon(
        Icons.weekend,
        color: Colors.white70,
      ),
      onPressed: () {},
    );
  } else {
    return IconButton(
      icon: const Icon(
        Icons.work,
        color: Colors.white70,
      ),
      onPressed: () {},
    );
  }
}
