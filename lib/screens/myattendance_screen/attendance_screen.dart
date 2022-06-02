import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';
import 'package:hassanallamportalflutter/screens/get_direction_screen/get_direction_widget.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';

class Attendance_Screen extends StatefulWidget {

  static const routeName = '/myattendance-list-screen';
  const Attendance_Screen({Key? key}) : super(key: key);

  @override
  State<Attendance_Screen> createState() => _attendance_sreenState();
}

class _attendance_sreenState extends State<Attendance_Screen> {

  bool loadingAttendanceData=false;
  int monthNumber = DateTime
      .now()
      .month;

  List<dynamic> AttendanceListData = [];
  String AttendanceStringData = "";
  var formatter = new DateFormat('MMMM');

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My attendance'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      // drawer: MainDrawer(),

      body: BlocProvider<AttendanceCubit>(
        create: (context) => AttendanceCubit()..getAttendanceList(user.user!.userHRCode.toString(), monthNumber),
        child:  BlocConsumer<AttendanceCubit, AttendanceState>(
          listener: (context, state) {
            if (state is BlocGetTheAttendanceSuccesState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Success"),
                ),
              );
              AttendanceStringData = state.getContactList;
              AttendanceListData = jsonDecode(AttendanceStringData);
            }
            else if (state is BlocGetTheAttendanceLoadingState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Loading"),

                ),
              );
            }
            else if (state is BlocGetTheAttendanceErrorState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(child: Column(children: [
              Container(
                child: Row(children: [
                  Row(children: [
                    RaisedButton(
                      onPressed: () {
                        monthNumber--;
                        if (monthNumber < 1) {
                          monthNumber = 12;
                        }
                        BlocProvider.of<AttendanceCubit>(context)
                            .getAttendanceList(
                            user.user!.userHRCode, monthNumber);
                      },
                      child: Text('prev'),
                    ),
                  ],
                  ),
                  Row(children: [
                    RaisedButton(
                      onPressed: () {
                        monthNumber++;
                        if (monthNumber > 12) {
                          monthNumber = 1;
                        }
                        BlocProvider.of<AttendanceCubit>(context)
                            .getAttendanceList(
                            user.user!.userHRCode, monthNumber);
                      },
                      child: Text('next'),
                    ),
                  ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),


              Text(DateFormat('MMMM').format(DateTime(0, monthNumber)),
                style: TextStyle(fontSize: 20, color: Colors.black),),

              SingleChildScrollView(
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

                      )
                    ],
                  )
              )
            ],
            ),
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                      "assets/images/S_Background.png"),
                      fit: BoxFit.cover)
              ),
            );
          },
        ),
      ),

    );
  }
}

