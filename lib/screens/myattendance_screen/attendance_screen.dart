import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/myattendance_screen_bloc/attendance_cubit.dart';
import 'package:hassanallamportalflutter/data/models/myattendance_model.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/DaysOfTheWeek.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'AttendanceTicketWidgetDefault.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = '/myattendance-list-screen';
  const AttendanceScreen({Key? key}) : super(key: key);
  @override
  State<AttendanceScreen> createState() => AttendanceScreenStateClass();
}

class AttendanceScreenStateClass extends State<AttendanceScreen> {
  int monthNumber = DateTime.now().month;

  List<MyAttendanceModel> getAttendanceListSuccess = [];

  int selectedPage = DateTime.now().month - 1;

  int dayNumber = DateTime.now().day;

  bool transition = false;
  bool found = false;

  @override
  Widget build(BuildContext context) {
    // new month
    if (dayNumber > 15) {
      monthNumber = monthNumber + 1;
      selectedPage = selectedPage + 1;
    }

    var pageController = PageController(initialPage: selectedPage);

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return CustomBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('My attendance'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            onRefresh: () async {
              await AttendanceCubit(user.user!.userHRCode.toString())
                  .getAttendanceList(
                      user.user!.userHRCode.toString(), monthNumber);
              // await Future.delayed(const Duration(milliseconds: 1000));
              return Future(() => null);
            },
            child: BlocProvider<AttendanceCubit>(
                create: (context) =>
                    AttendanceCubit(user.user!.userHRCode.toString())
                      ..getAttendanceList(
                          user.user!.userHRCode.toString(), monthNumber),
                child: BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {
                  if (state.attendanceDataEnumStates ==
                      AttendanceDataEnumStates.success) {
                  } else if (state.attendanceDataEnumStates ==
                      AttendanceDataEnumStates.loading) {
                  } else if (state.attendanceDataEnumStates ==
                      AttendanceDataEnumStates.failed) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("error"),
                      ),
                    );
                  }
                }, builder: (context, state) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  if (!transition) {
                                    transition = true;
                                    monthNumber--;
                                    pageController.jumpToPage(monthNumber - 1);

                                    if (monthNumber < 1) {
                                      monthNumber = 12;
                                      pageController.jumpToPage(11);
                                    }
                                    BlocProvider.of<AttendanceCubit>(context)
                                        .getAttendanceList(
                                            user.user!.userHRCode, monthNumber);
                                    found = false;
                                  } else {
                                    null;
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                label: const Text("")),
                            Text(
                              DateFormat('MMMM')
                                  .format(DateTime(0, monthNumber)),
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  if (!transition) {
                                    transition = true;
                                    monthNumber++;
                                    pageController.jumpToPage(monthNumber - 1);

                                    if (monthNumber > 12) {
                                      monthNumber = 1;
                                      pageController.jumpToPage(0);
                                    }
                                    BlocProvider.of<AttendanceCubit>(context)
                                        .getAttendanceList(
                                            user.user!.userHRCode, monthNumber);
                                    found = false;
                                  } else {
                                    null;
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                label: const Text(""))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: PageView(
                          onPageChanged: (index) {
                            BlocProvider.of<AttendanceCubit>(context)
                                .getAttendanceList(
                                    user.user!.userHRCode, index + 1);
                            monthNumber = index + 1;
                            found = false;
                          },
                          controller: pageController,
                          children: [
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                            getMonth(state, user),
                          ],
                        ),
                      ),
                    ]),
                  );
                })),
          )),
    );
  }

  getMonth(AttendanceState state, MainUserData user) {
    if (state.attendanceDataEnumStates == AttendanceDataEnumStates.success &&
        state.month == monthNumber) {
      transition = false;
      found = true;
      getAttendanceListSuccess = state.getAttendanceList;
      return attendanceLoad(getAttendanceListSuccess, user);
    } else if (state.attendanceDataEnumStates ==
            AttendanceDataEnumStates.success &&
        state.month != monthNumber) {
      if (found) {
        return attendanceLoad(getAttendanceListSuccess, user);
      } else {
        return attendanceShimmer();
      }
    } else {
      return attendanceShimmer();
    }
  }

  attendanceLoad(List<MyAttendanceModel> list, MainUserData user) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              child: DayOfTheWeek(list),
            ),
            SizedBox(
              child: AttendanceTicketWidget(
                  list, user.user!.userHRCode.toString()),
            ),
          ],
        ));
  }

  attendanceShimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
          child: Column(
        children: [
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
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
