import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_detail_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StaffDashBoardScreen extends StatefulWidget {

  static const routeName = "/staff-dashboard-screen";
  const StaffDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<StaffDashBoardScreen> createState() => StaffDashBoardScreenClass();
}

class StaffDashBoardScreenClass extends State<StaffDashBoardScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child:

      CustomBackground(
          child: CustomTheme(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("Dashboard"),
                  // title: Text('Dashboard $formattedDateTitle'),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                        icon: const Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.read<StaffDashboardCubit>()
                              .staffDashBoardDateChanged(context);
                        }
                    )
                  ]
              ),

              body: BlocProvider.value(value: StaffDashboardCubit.get(context)
                ..getFirstStaffBoardCompanies(
                  // TODO: --------------change hr,date
                    "10203520",
                    GlobalConstants.dateFormatServerDashBoard.format(
                        DateTime.now())),

                  child: BlocConsumer<StaffDashboardCubit, StaffDashboardState>(
                      listener: (context, state) {
                        if (state.companyStaffDashBoardEnumStates ==
                            CompanyStaffDashBoardEnumStates.success) {
                          EasyLoading.dismiss(animation: true);
                        }
                        else if (state.companyStaffDashBoardEnumStates ==
                            CompanyStaffDashBoardEnumStates.loading) {
                          EasyLoading.show(status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,);
                        }
                        else if (state.companyStaffDashBoardEnumStates ==
                            CompanyStaffDashBoardEnumStates.failed) {
                          EasyLoading.dismiss(animation: true);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("error"),
                            ),
                          );
                        }
                      },

                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  state.companyStaffDashBoardEnumStates ==
                                      CompanyStaffDashBoardEnumStates.success ?
                                  state.date : "Day",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),),
                              ),
                              const SizedBox(height: 50),
                              InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  labelText: 'Hassan Allam Holding',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                                  prefixIcon: Icon(Icons.stacked_bar_chart,
                                      color: Colors.white70),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(children: [
                                        Text(
                                          state
                                              .companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success ?
                                          getAllAttendanceHolding(
                                              state.companyStaffDashBoardList)
                                              .toString() : "----",
                                          style: const TextStyle(
                                              color: Colors.white),),
                                        whiteText("Attendance"),
                                      ],),
                                      Column(children: [
                                        Text(
                                          state
                                              .companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success ?
                                          getAllAbsentHolding(
                                              state.companyStaffDashBoardList)
                                              .toString() : "----",
                                          style: const TextStyle(
                                              color: Colors.white),),
                                        whiteText("Absents"),
                                      ],),
                                      Column(children: [
                                        Text(
                                          state
                                              .companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success ?
                                          getAllContrator(
                                              state.companyStaffDashBoardList)
                                              .toString() : "----",
                                          style: const TextStyle(
                                              color: Colors.white),),
                                        whiteText("Contractors"),
                                      ],),
                                    ],),
                                ),
                              ),

                              const SizedBox(height: 25),

                              InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  labelText: 'Total Manpower \n ',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [

                                      Center(
                                        child: Text(
                                          state
                                              .companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success ?
                                          getAllManPower(
                                              state.companyStaffDashBoardList)
                                              .toString() : "----",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [

                                          Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Text(
                                                state
                                                    .companyStaffDashBoardEnumStates ==
                                                    CompanyStaffDashBoardEnumStates
                                                        .success ?
                                                getTotalStaff(state
                                                    .companyStaffDashBoardList)
                                                    .toString() : "----",
                                                style: const TextStyle(
                                                    color: Colors.white),),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: whiteText("Total Staff"),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: state
                                                  .companyStaffDashBoardEnumStates ==
                                                  CompanyStaffDashBoardEnumStates
                                                      .success ?
                                              getAttendancePercentage(
                                                  getAllAttendanceStaff(state
                                                      .companyStaffDashBoardList) +
                                                      0.0, getTotalStaff(state
                                                  .companyStaffDashBoardList) +
                                                  0.0) :
                                              getAttendancePercentage(1.0, 1.0),
                                            ),
                                          ],),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Text(
                                                  state
                                                      .companyStaffDashBoardEnumStates ==
                                                      CompanyStaffDashBoardEnumStates
                                                          .success ?
                                                  getTotalLabor(state
                                                      .companyStaffDashBoardList)
                                                      .toString() : "----",
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    8.0),
                                                child: whiteText("Total Labor"),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: state
                                                    .companyStaffDashBoardEnumStates ==
                                                    CompanyStaffDashBoardEnumStates
                                                        .success ?
                                                getAttendancePercentage(
                                                    getAllAttendanceLabor(state
                                                        .companyStaffDashBoardList) +
                                                        0.0, getTotalLabor(state
                                                    .companyStaffDashBoardList) +
                                                    0.0) :
                                                getAttendancePercentage(
                                                    1.0, 1.0),),
                                            ],),
                                        ],
                                      ),
                                    ],),
                                ),
                              ),
                              //     icon: const Icon(Icons.arrow_forward_ios),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (state.companyStaffDashBoardEnumStates ==
                                        CompanyStaffDashBoardEnumStates
                                            .success) {
                                      Navigator.of(context).pushNamed(
                                          StaffDashBoardDetailScreen.routeName,
                                          arguments: {
                                            StaffDashBoardDetailScreen.staffDashboardList: state.companyStaffDashBoardList
                                          });
                                    }
                                  },
                                  child: Text('Subsidiaries', style: TextStyle(fontSize: 20)),
                                  // color: Colors.blue,
                                  // textColor: ConstantsColors.backgroundStartColor,
                                  // elevation: 5,
                                ),
                              ),
                            ],),
                        );
                      }
                  )
              ),
            ),
          )
      ),
    );
  }


  int getAllAttendanceHolding(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += (dataList[i].laborAttend! + dataList[i].staffAttend!);
    }
    return sum.round();
  }

  int getAllAttendanceStaff(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += dataList[i].staffAttend!;
    }
    return sum.round();
  }

  int getAllAttendanceLabor(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += dataList[i].laborAttend!;
    }
    return sum.round();
  }

  int getAllAbsentHolding(List<CompanyStaffDashBoard> dataList) {
    double absent = 0;
    for (int i = 0; i < dataList.length; i++) {
      absent += (dataList[i].staffCount! - dataList[i].staffAttend!) +
          (dataList[i].laborCount! - dataList[i].laborAttend!);
    }
    return absent.round();
  }

  int getAllContrator(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += dataList[i].subContractor!;
    }
    return sum.round();
  }

  int getAllManPower(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += (dataList[i].laborCount! + dataList[i].staffCount!);
    }
    return sum.round();
  }

  int getTotalStaff(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += dataList[i].staffCount!;
    }
    return sum.round();
  }

  int getTotalLabor(List<CompanyStaffDashBoard> dataList) {
    double sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      sum += dataList[i].laborCount!;
    }
    return sum.round();
  }

  Padding getAttendancePercentage(double attendance, double total) {
    int percentage = ((attendance / total) * 100).round();
    int attendanceNumber = attendance.round();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularPercentIndicator(
        radius: 70.0,
        lineWidth: 13.0,
        animation: true,
        animationDuration: 2500,
        percent: attendance / total,
        center: Text("$percentage%\n$attendanceNumber",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: ConstantsColors.backgroundEndColor,
      ),
    );
  }

  Text whiteText(String text) {
    return Text(text, style: const TextStyle(
        color: Colors.white, fontSize: 15),);
  }

}