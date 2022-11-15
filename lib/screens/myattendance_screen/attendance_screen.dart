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
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../bloc/statistics_bloc/statistics_cubit.dart';
import 'AttendanceTicketWidgetDefault.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = '/myattendance-list-screen';

  const AttendanceScreen({Key? key}) : super(key: key);
  @override
  State<AttendanceScreen> createState() => AttendanceScreenStateClass();
}

class AttendanceScreenStateClass extends State<AttendanceScreen> {
  int selectedPage = DateTime.now().month - 1;

  int dayNumber = DateTime.now().day;

  int monthNumber = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    if (dayNumber > 15) {
      monthNumber += 1;
      selectedPage += 1;
    }

    var pageController = PageController(initialPage: selectedPage);

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    context.read<AttendanceCubit>().monthValueChanged(monthNumber);

    return CustomBackground(
        child: CustomTheme(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('My Attendance'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: BlocBuilder<StatisticsCubit, StatisticsInitial>(
          builder: (context, state) {
            return (state.statisticsList.isNotEmpty)
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.stacked_bar_chart_outlined,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 2.5),
                                      child: Text(
                                        'Statistics',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Vacations'),
                                          Text(
                                              '${state.statisticsList[0].balance ?? "0"} days'),
                                        ],
                                      ),
                                    ),
                                    SfSlider(
                                      value: double.parse(state
                                                  .statisticsList[0].consumed ??
                                              "0") /
                                          double.parse(
                                              state.statisticsList[0].balance ??
                                                  "1"),
                                      onChanged: (_) {},
                                      thumbIcon: Center(
                                        child: Text(
                                            '${state.statisticsList[0].consumed}',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ),
                                      activeColor: Colors.blue[200],
                                      inactiveColor: Colors.white70,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Permissions',
                                          ),
                                          Text(
                                              '${state.statisticsList[2].balance} hours'),
                                        ],
                                      ),
                                    ),
                                    SfSlider(
                                      value: double.parse(state
                                                  .statisticsList[2].consumed ??
                                              "0") /
                                          double.parse(
                                              state.statisticsList[2].balance ??
                                                  "1"),
                                      onChanged: (_) {},
                                      thumbIcon: Center(
                                        child: Text(
                                            '${state.statisticsList[2].consumed}',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ),
                                      activeColor: Colors.blue[200],
                                      inactiveColor: Colors.white70,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Business Mission',
                                          ),
                                          Text('No Limit'),
                                        ],
                                      ),
                                    ),
                                    SfSlider(
                                      value: double.parse(state
                                                  .statisticsList[1].consumed ??
                                              "0") /
                                          31,
                                      onChanged: (_) {},
                                      thumbIcon: Center(
                                        child: Text(
                                            '${state.statisticsList[1].consumed}',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ),
                                      activeColor: Colors.blue[200],
                                      inactiveColor: Colors.white70,
                                    ),
                                  ],
                                ));
                          });
                    },
                  )
                : Container();
          },
        ),
        body: BlocProvider.value(
          value: AttendanceCubit.get(context)
            ..getFirstAttendanceList(user.user?.userHRCode.toString()),
          child: BlocConsumer<AttendanceCubit, AttendanceState>(
              listener: (context, state) {
            if (state.attendanceDataEnumStates ==
                AttendanceDataEnumStates.success) {
            } else if (state.attendanceDataEnumStates ==
                AttendanceDataEnumStates.fullSuccess) {
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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          monthNumber--;
                          pageController.jumpToPage(monthNumber - 1);
                          if (monthNumber < 1) {
                            monthNumber = 12;
                            pageController.jumpToPage(11);
                          }
                          context
                              .read<AttendanceCubit>()
                              .monthValueChanged(monthNumber);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        label: const Text("")),
                    Text(
                      DateFormat('MMMM').format(DateTime(0, state.month)),
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          monthNumber++;
                          pageController.jumpToPage(monthNumber - 1);
                          if (monthNumber > 12) {
                            monthNumber = 1;
                            pageController.jumpToPage(0);
                          }
                          context
                              .read<AttendanceCubit>()
                              .monthValueChanged(monthNumber);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        label: const Text(""))
                  ],
                ),
                Expanded(
                    child: PageView(
                  onPageChanged: (index) {
                    monthNumber = index + 1;
                    context
                        .read<AttendanceCubit>()
                        .monthValueChanged(monthNumber);
                    if (state.getAttendanceList[monthNumber - 1].toString() ==
                        "[]") {
                      BlocProvider.of<AttendanceCubit>(context)
                          .getAllAttendanceList(user.user?.userHRCode);
                    }
                    selectedPage = monthNumber - 1;
                    pageController = PageController(initialPage: selectedPage);
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
                )),
              ],
            );
          }),
        ),
      ),
    ));
  }

  getShimmer(AttendanceState state, int number, MainUserData user) {
    if (state.getAttendanceList.isEmpty) {
      return attendanceShimmer();
    } else {
      if (state.getAttendanceList[number].toString() == "[]") {
        return attendanceShimmer();
      } else {
        return attendanceLoad(state.getAttendanceList[number], user);
      }
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
                  list, user.user?.userHRCode.toString() ?? ""),
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
