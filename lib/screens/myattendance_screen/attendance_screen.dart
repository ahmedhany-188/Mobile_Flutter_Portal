import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_widget.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class Attendance_Screen extends StatefulWidget {

  static const routeName = '/myattendance-list-screen';
  const Attendance_Screen({Key? key}) : super(key: key);

  @override
  State<Attendance_Screen> createState() => _attendance_sreenState();
}

class _attendance_sreenState extends State<Attendance_Screen> {

  List<dynamic> AttendanceListData = [];
  String AttendanceStringData = "";

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,

        drawer: MainDrawer(),
      body: BlocProvider<AttendanceCubit>(
        create: (context) =>
        AttendanceCubit()
          ..getAttendanceList(),
        child: BlocConsumer<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is BlocGetTheAttendanceSuccesState) {

              AttendanceStringData = state.getContactList;
              AttendanceListData = jsonDecode(AttendanceStringData);

              // open pdf file in
              // final  _url = "https://portal.hassanallam.com/Public/medical.aspx?FormID=2217";
              // if (await canLaunch(_url))
              //   await launch(_url);

            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: deviceSize.height -
                          ((deviceSize.height * 0.24) -
                              MediaQuery
                                  .of(context)
                                  .viewPadding
                                  .top),
                      child: AttendanceTicketWidget(AttendanceListData),
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              "assets/images/backgroundattendance.jpg"),
                              fit: BoxFit.cover)
                      ),
                    )
                  ],
                )
            );
          },
        ),
      ),
    );
  }
}

