import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
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

  List<List<MyAttendanceModel>> getAttendanceListSuccess = [];

  List<MyAttendanceModel> getAttendanceListEmpty = [];

  int selectedPage = DateTime
      .now()
      .month - 1;

  int dayNumber = DateTime
      .now()
      .day;

  @override
  Widget build(BuildContext context) {

    int monthNumber = DateTime
        .now()
        .month;

    getAttendanceListSuccess = [
      getAttendanceListEmpty,
      getAttendanceListEmpty, getAttendanceListEmpty,
      getAttendanceListEmpty, getAttendanceListEmpty,
      getAttendanceListEmpty, getAttendanceListEmpty,
      getAttendanceListEmpty, getAttendanceListEmpty,
      getAttendanceListEmpty, getAttendanceListEmpty,
      getAttendanceListEmpty
    ];

    if (dayNumber > 15) {
      monthNumber += 1;
      selectedPage += 1;
    }

    var pageController = PageController(initialPage: selectedPage);

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    context.read<AttendanceCubit>().monthValueChanged(monthNumber);

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

            body: BlocProvider.value(value: AttendanceCubit.get(context)
              ..getFirstAttendanceList(
                  user.user!.userHRCode.toString(), monthNumber),

              child: BlocConsumer<AttendanceCubit, AttendanceState>(
                  listener: (context, state) {
                    if (state.attendanceDataEnumStates ==
                        AttendanceDataEnumStates.success) {}
                    else if (state.attendanceDataEnumStates ==
                        AttendanceDataEnumStates.fullSuccess) {}

                    else if (state.attendanceDataEnumStates ==
                        AttendanceDataEnumStates.loading) {}
                    else if (state.attendanceDataEnumStates ==
                        AttendanceDataEnumStates.failed) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("error"),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return
                      // SingleChildScrollView(
                      //   child:
                        Column(
                        children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          if (state
                                              .attendanceDataEnumStates ==
                                              AttendanceDataEnumStates
                                                  .success
                                              || state
                                                  .attendanceDataEnumStates ==
                                                  AttendanceDataEnumStates
                                                      .fullSuccess) {
                                            monthNumber--;
                                            pageController.jumpToPage(
                                                monthNumber - 1);
                                            if (monthNumber < 1) {
                                              monthNumber = 12;
                                              pageController.jumpToPage(
                                                  11);
                                            }
                                            context.read<
                                                AttendanceCubit>()
                                                .monthValueChanged(
                                                monthNumber);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                        label: const Text("")),
                                    Text(
                                      DateFormat('MMMM')
                                          .format(
                                          DateTime(0, state.month)),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                    TextButton.icon(
                                        onPressed: () {
                                          if (state
                                              .attendanceDataEnumStates ==
                                              AttendanceDataEnumStates
                                                  .success
                                              || state
                                                  .attendanceDataEnumStates ==
                                                  AttendanceDataEnumStates
                                                      .fullSuccess) {
                                            monthNumber++;
                                            pageController.jumpToPage(
                                                monthNumber - 1);
                                            if (monthNumber > 12) {
                                              monthNumber = 1;
                                              pageController.jumpToPage(
                                                  0);
                                            }
                                            context.read<
                                                AttendanceCubit>()
                                                .monthValueChanged(
                                                monthNumber);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                        label: const Text(""))
                                  ],
                                ),
                                Expanded(
                                    child: state
                                        .attendanceDataEnumStates ==
                                        AttendanceDataEnumStates.success
                                        ||
                                        state.attendanceDataEnumStates ==
                                            AttendanceDataEnumStates
                                                .fullSuccess ?
                                    PageView(
                                      onPageChanged: (index) {
                                        monthNumber = index + 1;
                                        context.read<AttendanceCubit>()
                                            .monthValueChanged(
                                            monthNumber);
                                        if (state
                                            .getAttendanceList[monthNumber -
                                            1]
                                            .toString() == "[]") {
                                          BlocProvider.of<
                                              AttendanceCubit>(context)
                                              .getAllAttendanceList(
                                              user.user!.userHRCode);
                                          selectedPage = monthNumber - 1;
                                          pageController =
                                              PageController(
                                                  initialPage: selectedPage);
                                        }
                                      },
                                      controller: pageController,
                                      children: [

                                        getShimmer(state, 0, user),
                                        getShimmer(state, 1, user),
                                        getShimmer(state, 2, user),
                                        getShimmer(state, 3, user),
                                        getShimmer(state, 4, user),
                                        getShimmer(state, 5, user),
                                        getShimmer(state, 6, user),
                                        getShimmer(state, 7, user),
                                        getShimmer(state, 8, user),
                                        getShimmer(state, 9, user),
                                        getShimmer(state, 10, user),
                                        getShimmer(state, 11, user),

                                      ],
                                    ) :
                                    PageView(
                                      onPageChanged: (index) {
                                        monthNumber = index + 1;
                                        context.read<AttendanceCubit>()
                                            .monthValueChanged(
                                            monthNumber);
                                        selectedPage = monthNumber - 1;
                                        pageController =
                                            PageController(
                                                initialPage: selectedPage);
                                      },
                                      controller: pageController,
                                      children: [

                                        getShimmer(state, 0, user),
                                        getShimmer(state, 1, user),
                                        getShimmer(state, 2, user),
                                        getShimmer(state, 3, user),
                                        getShimmer(state, 4, user),
                                        getShimmer(state, 5, user),
                                        getShimmer(state, 6, user),
                                        getShimmer(state, 7, user),
                                        getShimmer(state, 8, user),
                                        getShimmer(state, 9, user),
                                        getShimmer(state, 10, user),
                                        getShimmer(state, 11, user),
                                      ],
                                    )

                                ),
                        ],
                      // )
                      );
                  }),
            )
        )
    );
  }

  Container getShimmer(AttendanceState state,int number, MainUserData user) {
    if (state.getAttendanceList.isEmpty) {
      return attendanceShimmer();
    } else {
      if (state.getAttendanceList[number]
          .toString() == "[]") {
        return attendanceShimmer();
      } else {
        return attendanceLoad(state.getAttendanceList[number], user);
      }
    }
  }

  Container attendanceLoad(List<MyAttendanceModel> list, MainUserData user) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              SizedBox(
                child: DayOfTheWeek(list),
              ),
              SizedBox(
                child: AttendanceTicketWidget(
                    list, user.user!.userHRCode.toString()),
              ),
            ],)
        )
    );
  }

  Container attendanceShimmer() {
    return Container(
        child: Padding(
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
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}