import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/employee_appraisal_screen_bloc/employee_appraisal_bloc_cubit.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class EmployeeAppraisal_Screen extends StatefulWidget {

  static const routeName = "/employee-appraisal-list";
  const EmployeeAppraisal_Screen({Key? key}) : super(key: key);


  @override
  State<EmployeeAppraisal_Screen> createState() => _EmployeeAppraisal_ScreenState();
}
  class _EmployeeAppraisal_ScreenState extends State<EmployeeAppraisal_Screen> {


    List<dynamic> ?employeeAppraisaleList;


    @override
    Widget build(BuildContext context) {
      var deviceSize = MediaQuery
          .of(context)
          .size;
      final user = context.select((AppBloc bloc) => bloc.state.userData);

      List<dynamic> employeeArraisaleDat = [39, 33, 3, 42];


      return Scaffold(

        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        drawer: MainDrawer(),

        body: SingleChildScrollView(

          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: BlocProvider<EmployeeAppraisalBlocCubit>(

              create: (context) =>
              EmployeeAppraisalBlocCubit()
                ..getEmployeeAppraisalList(user.user!.userHRCode.toString()),

              child: BlocConsumer<
                  EmployeeAppraisalBlocCubit,
                  EmployeeAppraisalBlocState>(
                listener: (context, state) {
                  if (state is BlocgetEmployeeAppraisalBlocInitialSuccessState) {
                    employeeAppraisaleList =
                    jsonDecode(state.employeeAppraisaleList)["data"];

                    print(employeeAppraisaleList);
                    // employeeArraisaleData?.add(employeeAppraisaleList!.elementAt(0)["companyScore"]);
                    // employeeArraisaleData?.add(employeeAppraisaleList!.elementAt(0)["departmentScore"]);
                    // employeeArraisaleData?.add(employeeAppraisaleList!.elementAt(0)["individualScore"]);
                    // employeeArraisaleData?.add(employeeAppraisaleList!.elementAt(0)["overallscore"]);


                    // print(employeeAppraisaleList!.elementAt(0)["id"]);

                  } else
                  if (state is BlocgetEmployeeAppraisalBlocInitialErrorState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("error"),
                      ),
                    );
                  } else
                  if (state is BlocgetEmployeeAppraisalBlocInitialLoadingState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Loading"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return

                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: deviceSize.height - ((deviceSize.height *
                                0.24) -
                                MediaQuery
                                    .of(context)
                                    .viewPadding
                                    .top),
                            child: EmployeeAppraisalTicketWidget(const [
                              30.3,
                              43.3,
                              82.1,
                              95.1
                            ]),
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage(
                                    "assets/images/backgroundattendance.jpg"),
                                    fit: BoxFit.cover)
                            ),
                          )

                        ],),
                    );
                },
              ),
            ),
          ),
        ),
      );
    }
  }

