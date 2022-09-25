import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_job_bloc/staff_dashboard_job_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/jobsStaffDashBoard_model.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_jobs_widget.dart';

class StaffDashboardJobScreen extends StatefulWidget {
  static const routeName = "/staff-dashboard-job-screen";

  static const List<JobStaffDashboardModel> staffDashboardJobList = [];

  static const projectCode = "/project-code";
  static const director = "/director";
  static const jobTitle = "/job-title";
  static const fromDay = "/from-day";
  static const toDay = "/to-day";

  const StaffDashboardJobScreen({Key? key, this.requestData}) : super(key: key);
  final dynamic requestData;

  @override
  State<StaffDashboardJobScreen> createState() =>
      StaffDashboardJobScreenClass();
}

class StaffDashboardJobScreenClass extends State<StaffDashboardJobScreen> {
  @override
  Widget build(BuildContext context) {
    final currentRequestData = widget.requestData;

    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.staffdashboard.dashboardbgsub.image().image,
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: ConstantsColors.petrolTextAttendance,
                elevation: 0,
                title: Text(
                    "Jobs ${currentRequestData[StaffDashboardJobScreen.fromDay]}"),
                // title: Text('Dashboard $formattedDateTitle'),
                centerTitle: true,
                actions: <Widget>[
                  BlocProvider.value(
                    value: StaffDashboardJobCubit.get(context),
                    child: BlocBuilder<StaffDashboardJobCubit,
                        StaffDashboardJobState>(
                      builder: (context, state) {
                        return IconButton(
                            icon: const Icon(
                              Icons.filter_list_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              StaffDashboardJobCubit.get(context)
                                  .showJobsFilter(context);
                            });
                      },
                    ),
                  )
                ]),
            body: BlocProvider.value(
                value: StaffDashboardJobCubit.get(context)
                  ..getFirstStaffBoardJobs(
                      currentRequestData[StaffDashboardJobScreen.projectCode],
                      currentRequestData[StaffDashboardJobScreen.director],
                      currentRequestData[StaffDashboardJobScreen.jobTitle],
                      currentRequestData[StaffDashboardJobScreen.fromDay],
                      currentRequestData[StaffDashboardJobScreen.toDay])
                  ..clearFilters(),
                child: BlocConsumer<StaffDashboardJobCubit,
                    StaffDashboardJobState>(
                  listener: (context, state) {
                    if (state.jobStaffDashBoardEnumStates ==
                        JobStaffDashBoardEnumStates.success) {
                      EasyLoading.dismiss(animation: true);
                    } else if (state.jobStaffDashBoardEnumStates ==
                        JobStaffDashBoardEnumStates.loading) {
                      EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                        dismissOnTap: false,
                      );
                    } else if (state.jobStaffDashBoardEnumStates ==
                        JobStaffDashBoardEnumStates.failed) {
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
                    return state.jobStaffDashBoardEnumStates ==
                            JobStaffDashBoardEnumStates.success
                        ? state.isFiltered
                            ? StaffDashboardJobWidget(
                                state.jobStaffDashBoardSearchList)
                            : StaffDashboardJobWidget(
                                state.jobStaffDashBoardList)
                        : Center(child: (EasyLoading.isShow)? const SizedBox() :const CircularProgressIndicator());
                  },
                )),
          ),
        ));
  }
}
