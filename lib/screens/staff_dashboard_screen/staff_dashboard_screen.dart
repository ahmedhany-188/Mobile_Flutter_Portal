import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_detail_screen.dart';
import 'package:hassanallamportalflutter/widgets/animation/page_transition_animation.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../gen/assets.gen.dart';

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
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: Assets.images.staffdashboard.dashboard3.image().image)),
        child: CustomTheme(
          child: BlocProvider.value(
            value: StaffDashboardCubit.get(context)
              ..getFirstStaffBoardCompanies(
                  // TODO: --------------change hr,date
                  user.employeeData?.userHrCode,
                  GlobalConstants.dateFormatServerDashBoard
                      .format(DateTime.now())),
            child: BlocConsumer<StaffDashboardCubit, StaffDashboardState>(
              listener: (context, state) {
                if (state.companyStaffDashBoardEnumStates ==
                    CompanyStaffDashBoardEnumStates.success) {
                  EasyLoading.dismiss(animation: true);
                } else if (state.companyStaffDashBoardEnumStates ==
                    CompanyStaffDashBoardEnumStates.loading) {
                  EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: false,
                  );
                } else if (state.companyStaffDashBoardEnumStates ==
                    CompanyStaffDashBoardEnumStates.failed) {
                  EasyLoading.dismiss(animation: true);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("error"),
                    ),
                  );
                }
                else if (state.companyStaffDashBoardEnumStates ==
                    CompanyStaffDashBoardEnumStates.noDataFound) {
                  EasyLoading.dismiss(animation: true);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  EasyLoading.showError( "Don't have access");
                }
              },
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                          "Dashboard ${StaffDashboardCubit.get(context).state.date}"),
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                            icon: const Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<StaffDashboardCubit>()
                                  .staffDashBoardDateChanged(context,user.employeeData?.userHrCode);
                            })
                      ]),
                  body: Column(
                    children: [
                      // Center(
                      //   child: Text(
                      //     state.companyStaffDashBoardEnumStates ==
                      //             CompanyStaffDashBoardEnumStates.success
                      //         ? state.date
                      //         : "Day",
                      //     style: const TextStyle(
                      //         color: Colors.white, fontSize: 20),
                      //   ),
                      // ),
                      // const SizedBox(height: 50),
                      // Assets.images.logo.image(scale: 10,),
                      SizedBox(
                        height: 100,
                        child: AspectRatio(
                            aspectRatio: 1.2,
                            child: Assets.images.logo.image(
                              scale: 1,
                              fit: BoxFit.fitWidth,
                              alignment: FractionalOffset.topCenter,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        margin:
                            const EdgeInsets.only(top: 15, bottom: 10),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                    BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            isCollapsed: true,

                            // label: Column(
                            //       children: [
                            //         Center(child: Assets.images.loginImageLogo.image(scale: 2)),
                            //         // Text('Hassan Allam Holding')
                            //       ],
                            //     ),
                            labelText: 'Hassan Allam Holding',
                            labelStyle: TextStyle(fontSize: 30),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      state.companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success
                                          ? getAllAttendanceHolding(state
                                                  .companyStaffDashBoardList)
                                              .toString()
                                          : "----",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                    whiteText("Attendance"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      state.companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success
                                          ? getAllAbsentHolding(state
                                                  .companyStaffDashBoardList)
                                              .toString()
                                          : "----",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                    whiteText("Absents"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      state.companyStaffDashBoardEnumStates ==
                                              CompanyStaffDashBoardEnumStates
                                                  .success
                                          ? getAllContrator(state
                                                  .companyStaffDashBoardList)
                                              .toString()
                                          : "----",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                    whiteText("Contractors"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Badge(
                        toAnimate: false,
                        badgeContent: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: Assets.images.staffdashboard.dashboard2
                                      .image()
                                      .image)),
                          child: Column(
                            children: [
                              const Text('Total Manpower'),
                              Text(
                                state.companyStaffDashBoardEnumStates ==
                                        CompanyStaffDashBoardEnumStates.success
                                    ? getAllManPower(
                                            state.companyStaffDashBoardList)
                                        .toString()
                                    : "----",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        badgeColor: Colors.transparent,
                        elevation: 0,
                        position: BadgePosition.topStart(
                            // top: -20,
                            start: MediaQuery.of(context).size.width / 2.9),
                        child: Assets.images.staffdashboard.dashboard1.image(),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Center(
                              //   child: Text(
                              //     state.companyStaffDashBoardEnumStates ==
                              //         CompanyStaffDashBoardEnumStates
                              //             .success
                              //         ? getAllManPower(state
                              //         .companyStaffDashBoardList)
                              //         .toString()
                              //         : "----",
                              //     style: const TextStyle(
                              //         color: Colors.white, fontSize: 20),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Assets.images.staffdashboard.empicon
                                          .image(scale: 2),
                                      whiteText("Total Staff"),
                                      Text(
                                        state.companyStaffDashBoardEnumStates ==
                                                CompanyStaffDashBoardEnumStates
                                                    .success
                                            ? getTotalStaff(state
                                                    .companyStaffDashBoardList)
                                                .toString()
                                            : "----",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: state.companyStaffDashBoardEnumStates ==
                                                CompanyStaffDashBoardEnumStates
                                                    .success
                                            ? getAttendancePercentage(
                                                getAllAttendanceStaff(state
                                                        .companyStaffDashBoardList) +
                                                    0.0,
                                                getTotalStaff(state
                                                        .companyStaffDashBoardList) +
                                                    0.0,
                                                ConstantsColors.buttonColors)
                                            : getAttendancePercentage(0.0, 1.0,
                                                ConstantsColors.buttonColors),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Assets.images.staffdashboard.laboricon
                                          .image(scale: 2),
                                      whiteText("Total Labor"),
                                      Text(
                                        state.companyStaffDashBoardEnumStates ==
                                                CompanyStaffDashBoardEnumStates
                                                    .success
                                            ? getTotalLabor(state
                                                    .companyStaffDashBoardList)
                                                .toString()
                                            : "----",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: state.companyStaffDashBoardEnumStates ==
                                                CompanyStaffDashBoardEnumStates
                                                    .success
                                            ? getAttendancePercentage(
                                                getAllAttendanceLabor(state
                                                        .companyStaffDashBoardList) +
                                                    0.0,
                                                getTotalLabor(state
                                                        .companyStaffDashBoardList) +
                                                    0.0,
                                                Colors.amber)
                                            : getAttendancePercentage(
                                                0.0, 1.0, Colors.amber),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  onPressed: () {
                                    if (state.companyStaffDashBoardEnumStates ==
                                        CompanyStaffDashBoardEnumStates
                                            .success) {
                                      PageTransitionAnimation(
                                        context: context,
                                        transitionDuration: 500,
                                        delayedDuration: 0,
                                        pageDirection:
                                            StaffDashBoardDetailScreen(
                                                requestData: {
                                              StaffDashBoardDetailScreen
                                                      .staffDashboardList:
                                                  state
                                                      .companyStaffDashBoardList,
                                              StaffDashBoardDetailScreen.date:
                                                  state.date
                                            }),
                                      ).navigateFromBottomWithoutReplace();
                                    }
                                  },
                                  child: Column(
                                    children: const [
                                      Text('SUBSIDIARIES',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: ConstantsColors
                                                  .bottomSheetBackgroundDark)),
                                      Icon(Icons.keyboard_double_arrow_down,
                                          size: 30,
                                          color: ConstantsColors
                                              .bottomSheetBackgroundDark),
                                    ],
                                  ),
                                  // color: Colors.blue,
                                  // textColor: ConstantsColors.backgroundStartColor,
                                  // elevation: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
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

  Padding getAttendancePercentage(
      double attendance, double total, Color color) {
    int percentage = ((attendance / total) * 100).round();
    int attendanceNumber = attendance.round();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: percentage,
        padding: 0.0,
        // startingAngle: 3,
        selectedColor: color,
        selectedStepSize: 7,
        stepSize: 3,

        startingAngle: 3,
        gradientColor: LinearGradient(colors: [color, color.withOpacity(0.4)]),
        child: Center(
          child: Text(
            "$percentage%\n$attendanceNumber",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
      // CircularPercentIndicator(
      //   radius: 70.0,
      //   lineWidth: 10.0,
      //   animation: true,
      //   animationDuration: 2500,
      //   percent: attendance / total,
      //   center: Text(
      //     "$percentage%\n$attendanceNumber",textAlign: TextAlign.center,
      //     style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400, fontSize: 15.0,),
      //   ),
      //   circularStrokeCap: CircularStrokeCap.round,
      //   arcType: ArcType.FULL,
      //
      //   progressColor: ConstantsColors.backgroundEndColor,
      //   arcBackgroundColor: Colors.red,
      //   backgroundWidth: 5,
      // ),
    );
  }

  Text whiteText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
    );
  }
}
