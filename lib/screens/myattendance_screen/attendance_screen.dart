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


  List<List<MyAttendanceModel>> getAttendanceListSuccess=[];

  List<MyAttendanceModel> getAttendanceListSuccess0=[];
  List<MyAttendanceModel> getAttendanceListSuccess1=[];
  List<MyAttendanceModel> getAttendanceListSuccess2=[];
  List<MyAttendanceModel> getAttendanceListSuccess3=[];
  List<MyAttendanceModel> getAttendanceListSuccess4=[];
  List<MyAttendanceModel> getAttendanceListSuccess5=[];
  List<MyAttendanceModel> getAttendanceListSuccess6=[];
  List<MyAttendanceModel> getAttendanceListSuccess7=[];
  List<MyAttendanceModel> getAttendanceListSuccess8=[];
  List<MyAttendanceModel> getAttendanceListSuccess9=[];
  List<MyAttendanceModel> getAttendanceListSuccess10=[];
  List<MyAttendanceModel> getAttendanceListSuccess11=[];


  int selectedPage = DateTime
      .now()
      .month - 1;

  int dayNumber = DateTime.now().day;

  @override
  Widget build(BuildContext context) {


     int monthNumber = DateTime.now().month;

    getAttendanceListSuccess = [
      getAttendanceListSuccess0,
      getAttendanceListSuccess1, getAttendanceListSuccess2,
      getAttendanceListSuccess3, getAttendanceListSuccess4,
      getAttendanceListSuccess5, getAttendanceListSuccess6,
      getAttendanceListSuccess7, getAttendanceListSuccess8,
      getAttendanceListSuccess9, getAttendanceListSuccess10,
      getAttendanceListSuccess11
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

            body:
            // RefreshIndicator(
            //     onRefresh: () async {
            //       await AttendanceCubit(user.user!.userHRCode.toString())
            //           ..getAttendanceList(user.user!.userHRCode.toString());
            //       // await Future.delayed(const Duration(milliseconds: 1000));
            //       return Future(() => null);
            //     },
            //     child:

                BlocProvider.value(value: AttendanceCubit.get(context)
                  ..getFirstAttendanceList(user.user!.userHRCode.toString(),monthNumber),
                  child: BlocConsumer<AttendanceCubit, AttendanceState>(
                      listener: (context, state) {
                        if (state.attendanceDataEnumStates == AttendanceDataEnumStates.success) {}
                        else if (state.attendanceDataEnumStates == AttendanceDataEnumStates.fullSuccess) {
                        }

                        else if (state.attendanceDataEnumStates == AttendanceDataEnumStates.loading) {}
                        else if (state.attendanceDataEnumStates == AttendanceDataEnumStates.failed) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("error"),
                            ),
                          );
                        }
                      },

                      builder: (context, state) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                      onPressed: () {
                                        if(state.attendanceDataEnumStates == AttendanceDataEnumStates.success
                                            || state.attendanceDataEnumStates == AttendanceDataEnumStates.fullSuccess){
                                          monthNumber--;
                                          pageController.jumpToPage(monthNumber - 1);
                                          if (monthNumber < 1) {
                                            monthNumber = 12;
                                            pageController.jumpToPage(11);
                                          };
                                          context.read<AttendanceCubit>().monthValueChanged(monthNumber);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      label: const Text("")),
                                  Text(
                                    DateFormat('MMMM')
                                        .format(DateTime(0,state.month)),
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.white),

                                ),
                                  TextButton.icon(
                                      onPressed: () {
                                        if(state.attendanceDataEnumStates == AttendanceDataEnumStates.success
                                        || state.attendanceDataEnumStates == AttendanceDataEnumStates.fullSuccess){
                                          monthNumber++;
                                          pageController.jumpToPage(
                                              monthNumber - 1);
                                          if (monthNumber > 12) {
                                            monthNumber = 1;
                                            pageController.jumpToPage(0);
                                          }
                                          context.read<AttendanceCubit>().monthValueChanged(monthNumber);
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
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.70,
                              child : state.attendanceDataEnumStates ==
                                      AttendanceDataEnumStates.success
                                  || state.attendanceDataEnumStates ==
                                      AttendanceDataEnumStates.fullSuccess?
                              PageView(
                                onPageChanged: (index) {
                                  monthNumber = index + 1;
                                  context.read<AttendanceCubit>().monthValueChanged(monthNumber);
                                  if(state.getAttendanceList[monthNumber-1].toString()=="[]"){
                                    BlocProvider.of<AttendanceCubit>(context)
                                        .getAllAttendanceList(user.user!.userHRCode);
                                    selectedPage=monthNumber-1;
                                     pageController = PageController(initialPage: selectedPage);

                                  }
                                },
                                controller: pageController,
                                children: [
                                  attendanceLoad(
                                      state.getAttendanceList[0], user),
                                  attendanceLoad(
                                      state.getAttendanceList[1], user),
                                  attendanceLoad(
                                      state.getAttendanceList[2], user),
                                  attendanceLoad(
                                      state.getAttendanceList[3], user),
                                  attendanceLoad(
                                      state.getAttendanceList[4], user),
                                  attendanceLoad(
                                      state.getAttendanceList[5], user),

                                  attendanceLoad(
                                      state.getAttendanceList[6], user),
                                  attendanceLoad(
                                      state.getAttendanceList[7], user),
                                  attendanceLoad(
                                      state.getAttendanceList[8], user),
                                  attendanceLoad(
                                      state.getAttendanceList[9], user),
                                  attendanceLoad(
                                      state.getAttendanceList[10], user),
                                  attendanceLoad(
                                      state.getAttendanceList[11], user),

                                ],
                              ):
                              attendanceShimmer()

                            ),
                          ]),
                        );
                      }),
                )
        )
    );
    //   ),
    // );
  }

  Container attendanceLoad(List<MyAttendanceModel> list,MainUserData user,){
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              SizedBox(
                child: DayOfTheWeek(list),
              ),
              SizedBox(
                child: AttendanceTicketWidget(list,user.user!.userHRCode.toString()),
              ),
            ],)
        )
    );
  }

  Container attendanceShimmer(){
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