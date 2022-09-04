

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/staff_dashboard_bloc/staff_dashboard_cubit.dart';
import 'package:hassanallamportalflutter/data/models/staff_dashboard_models/companystaffdashboard_model.dart';
import 'package:hassanallamportalflutter/screens/staff_dashboard_screen/staff_dashboard_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

class StaffDashBoardDetailScreen extends StatefulWidget{


  static const List<CompanyStaffDashBoard> staffDashboardList=[];
  static const routeName = "/staff-dashboard-detail-screen";

  // List<CompanyStaffDashBoard> staffDashboardList;
   const StaffDashBoardDetailScreen({Key? key, this.requestData}) : super(key: key);

   final dynamic requestData;
  @override
  State<StaffDashBoardDetailScreen> createState() => StaffDashBoardDetailScreenClass();

}

class StaffDashBoardDetailScreenClass extends State<StaffDashBoardDetailScreen> {

  @override
  Widget build(BuildContext context) {

    final currentRequestData = widget.requestData;

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child:

      CustomBackground(
        child: CustomTheme(
          child:
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text("Subsidiaries"),
                // title: Text('Dashboard $formattedDateTitle'),
                centerTitle: true,
                // actions: <Widget>[
                //   IconButton(
                //       icon: const Icon(
                //         Icons.date_range,
                //         color: Colors.white,
                //       ),
                //       onPressed: () {
                //         // context.read<StaffDashboardCubit>()
                //         //     .staffDashBoardDateChanged(context);
                //       }
                //   )
                // ]
            ),

            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StaffDashBoardTicketWidget(currentRequestData[StaffDashBoardDetailScreen.staffDashboardList]),
            ),


          ),
        ),
      ),
    );

  }

}