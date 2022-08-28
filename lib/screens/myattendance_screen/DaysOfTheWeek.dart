import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';

class DayOfTheWeek extends StatelessWidget{

  List<MyAttendanceModel> attendanceListData;

  DayOfTheWeek(this.attendanceListData,{Key? key})
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
              mainAxisExtent: 40, // here set custom Height You Want
              // width between items
              crossAxisSpacing: 2,
              // height between items
              mainAxisSpacing: 2,
            ),
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: double.infinity,
                child: InkWell(
                    child: Column(children: [
                      attendanceContainer(GlobalConstants.dateFormatServer.parse(attendanceListData[index].date.toString()).weekday)
                      // attendanceContainer((attendanceListData[index].date).weekday),
                    ])
                ),
              );
          },
        ),
        fallback:null, //(context) => const Center(child: LinearProgressIndicator()),
      )
    );
  }

  Container attendanceContainer(int day) {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5)) ,
        color:Colors.white38,
      ),
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(
         GlobalConstants.daysInWeek[day-1] ,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          )
      ),
    );
  }
}