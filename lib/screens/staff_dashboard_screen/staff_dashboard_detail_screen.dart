import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_ticket_widget.dart';

import '../../gen/assets.gen.dart';

class StaffDashBoardDetailScreen extends StatefulWidget {
  static const List<CompanyStaffDashBoard> staffDashboardList = [];
  static const date = "/date";
  static const routeName = "/staff-dashboard-detail-screen";

  // List<CompanyStaffDashBoard> staffDashboardList;
  const StaffDashBoardDetailScreen({Key? key, this.requestData})
      : super(key: key);
  final dynamic requestData;

  @override
  State<StaffDashBoardDetailScreen> createState() =>
      StaffDashBoardDetailScreenClass();
}

class StaffDashBoardDetailScreenClass
    extends State<StaffDashBoardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final currentRequestData = widget.requestData;

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.staffdashboard.dashboardbgsub.image().image,
              fit: BoxFit.fill,
            ),
          ),

          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: ConstantsColors.petrolTextAttendance,
                elevation: 0,
                title: const Text("Subsidiaries"),
                // +currentRequestData[StaffDashBoardDetailScreen.date]
                // title: Text('Dashboard $formattedDateTitle'),
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
            body: BlocProvider.value(
                value: StaffDashboardCubit.get(context),
                child: BlocConsumer<StaffDashboardCubit, StaffDashboardState>(
                  listener: (context, state) {
                    if (state.companyStaffDashBoardEnumStates ==
                        CompanyStaffDashBoardEnumStates.success) {
                      EasyLoading.dismiss(animation: true);
                      currentRequestData[
                              StaffDashBoardDetailScreen.staffDashboardList] =
                          state.companyStaffDashBoardList;
                      currentRequestData[StaffDashBoardDetailScreen.date] =
                          state.date;
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
                  },
                  builder: (context, state) {
                    return
                        // Column(
                        // children: [
                        // Center(
                        //   child: Text(
                        //     state.companyStaffDashBoardEnumStates ==
                        //         CompanyStaffDashBoardEnumStates.success ?
                        //     state.date : "Day",
                        //     style: const TextStyle(
                        //         color: Colors.white, fontSize: 20),),
                        // ),
                        StaffDashBoardTicketWidget(
                            currentRequestData[
                                StaffDashBoardDetailScreen.staffDashboardList],
                            state.date);
                  },
                )),
          ),
          // )
        ));
  }
}
