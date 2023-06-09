
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/AttendanceTicketWidgetDefault.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAttendance extends StatelessWidget{
  const ShimmerAttendance({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
          child: Column(children: [
            Shimmer.fromColors(
              baseColor: Colors.white12,
              highlightColor: Colors.grey,
              child: AttendanceTicketWidgetDefault("---", 7),
            ),
            Shimmer.fromColors(
              baseColor: Colors.white12,
              highlightColor: Colors.grey,
              child: AttendanceTicketWidgetDefault("00/00", 28),
            ),
          ],)
      ),
    );
  }

}