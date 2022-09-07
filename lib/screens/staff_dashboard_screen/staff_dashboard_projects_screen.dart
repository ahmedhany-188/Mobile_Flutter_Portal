import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_project_bloc/staff_dashboard_project_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_projects_widget.dart';

class StaffDashBoardProjectScreen extends StatefulWidget{

  static const companyID="/company-id";
  static const project="/project";
  static const director="/director";
  static const date="/date";

  static const routeName = "/staff-dashboard-project-screen";

  const StaffDashBoardProjectScreen({Key? key, this.requestData}) : super(key: key);
  final dynamic requestData;

  @override
  State<StaffDashBoardProjectScreen> createState() => StaffDashBoardProjectScreenClass();

}

class StaffDashBoardProjectScreenClass extends State<StaffDashBoardProjectScreen> {

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
              image: Assets.images.staffdashboard.dashboardbgsub
                  .image()
                  .image,
              fit: BoxFit.contain,
            ),),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: ConstantsColors.petrolTextAttendance,
              elevation: 0,
              title: const Text("Projects"),
              // title: Text('Dashboard $formattedDateTitle'),
              centerTitle: true,
            ),

            body: BlocProvider.value(
                value: StaffDashboardProjectCubit.get(context)
                  ..getFirstStaffBoardProjects(
                      currentRequestData[StaffDashBoardProjectScreen
                          .companyID],
                      currentRequestData[StaffDashBoardProjectScreen
                          .project],
                      currentRequestData[StaffDashBoardProjectScreen
                          .director],
                      currentRequestData[StaffDashBoardProjectScreen
                          .date]),
                child: BlocConsumer<StaffDashboardProjectCubit,
                    StaffDashboardProjectState>(
                  listener: (context, state) {
                    if (state.projectStaffDashBoardEnumStates ==
                        ProjectStaffDashBoardEnumStates.success) {
                      EasyLoading.dismiss(animation: true);
                    }
                    else if (state.projectStaffDashBoardEnumStates ==
                        ProjectStaffDashBoardEnumStates.loading) {
                      EasyLoading.show(status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                        dismissOnTap: false,);
                    }
                    else if (state.projectStaffDashBoardEnumStates ==
                        ProjectStaffDashBoardEnumStates.failed) {
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
                      child: state.projectStaffDashBoardEnumStates ==
                          ProjectStaffDashBoardEnumStates.success
                          ? StaffDashboardProjectWidget(
                          state.projectStaffDashBoardList, state.date)
                          : const Center(child: Text("No Data Found")),);
                  },
                )
            ),
          ),
        )
    );
  }
}

