import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {

  static const routeName = '/myattendance-list-screen';
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => AttendanceScreenStateClass();
}

class AttendanceScreenStateClass extends State<AttendanceScreen> {

  bool loadingAttendanceData = false;
  int monthNumber = DateTime
      .now()
      .month;

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
            create: (context) =>
            AttendanceCubit()
              ..getAttendanceList(
                  user.user!.userHRCode.toString(), monthNumber),

            child: BlocConsumer<AttendanceCubit, AttendanceState>(
                listener: (context, state) {
                  if (state is BlocGetTheAttendanceSuccessState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Success"),
                      ),
                    );
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
                  return Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              "assets/images/S_Background.png"),
                              fit: BoxFit.cover)
                      ),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  monthNumber--;
                                  if (monthNumber < 1) {
                                    monthNumber = 12;
                                  }
                                  BlocProvider.of<AttendanceCubit>(context)
                                      .getAttendanceList(
                                      user.user!.userHRCode, monthNumber);

                                  if(state is BlocGetTheAttendanceErrorState){
                                    AttendanceTicketWidget(const []);

                                  }else if (state is BlocGetTheAttendanceLoadingState){
                                    AttendanceTicketWidget(const []);
                                  }
                                },
                                child: Text('prev'),

                              ),
                            ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ignore: deprecated_member_use
                                RaisedButton(
                                  onPressed: () {
                                    monthNumber++;
                                    if (monthNumber > 12) {
                                      monthNumber = 1;
                                    }
                                    BlocProvider.of<AttendanceCubit>(context)
                                        .getAttendanceList(
                                        user.user!.userHRCode, monthNumber);
                                    if(state is BlocGetTheAttendanceErrorState){
                                      AttendanceTicketWidget(const []);

                                    }else if (state is BlocGetTheAttendanceLoadingState){
                                      AttendanceTicketWidget(const []);
                                    }
                                  },
                                  child: Text('next'),
                                ),
                              ],
                            ),
                          ],
                        ),


                        Text(
                          DateFormat('MMMM').format(DateTime(0, monthNumber)),
                          style: TextStyle(fontSize: 20, color: Colors.black),),

                        SafeArea(child: Container(
                          child: state is BlocGetTheAttendanceSuccessState
                              ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                height: deviceSize.height,
                                child: AttendanceTicketWidget(state.getAttendanceList),
                              )
                          )
                              : const Center(
                            child: CircularProgressIndicator(),),
                        )
                        ),

                      ])
                  );
                }
            )
        )
    );
  }
}


