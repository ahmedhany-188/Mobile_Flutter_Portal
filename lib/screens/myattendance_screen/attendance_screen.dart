
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';

class attendance_screen extends StatefulWidget {

  static const routeName = '/myattendance-list-screen';
  const attendance_screen({Key? key}) : super(key: key);

  @override
  State<attendance_screen> createState() => _attendance_sreenState();

}

class _attendance_sreenState extends State<attendance_screen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(resizeToAvoidBottomInset: true,
        body: BlocProvider<AttendanceCubit>(
        create: (context) => AttendanceCubit()..getAttendanceList(),
        child: BlocConsumer<AttendanceCubit,AttendanceState>(
        listener: (context, state){},
        builder: (context,state){

          return SizedBox(height: 10);
    },
        ),
    ),
    );
  }
}

