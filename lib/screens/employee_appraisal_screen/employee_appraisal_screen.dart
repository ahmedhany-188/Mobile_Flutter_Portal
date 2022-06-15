import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/employee_appraisal_screen_bloc/employee_appraisal_bloc_cubit.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/object_appraisal_model.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class EmployeeAppraisalScreen extends StatefulWidget {

  static const routeName = "/employee-appraisal-list";
  const EmployeeAppraisalScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeAppraisalScreen> createState() => EmployeeAppraisalScreenState();
}
  class EmployeeAppraisalScreenState extends State<EmployeeAppraisalScreen> {

    List<dynamic> ?employeeAppraisalList;
    List <ObjectAppraisalModel> appraisalDataList = [];
    EmployeeAppraisalModel ?employeeAppraisalModel;

    @override
    Widget build(BuildContext context) {
      var deviceSize = MediaQuery
          .of(context)
          .size;

      final user = context.select((AppBloc bloc) => bloc.state.userData);

      return Scaffold(

        appBar: AppBar(
          title: const Text('Appraisal'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        drawer: MainDrawer(),

        body: BlocProvider<EmployeeAppraisalBlocCubit>(
          create: (context) =>
          EmployeeAppraisalBlocCubit()
            ..getEmployeeAppraisalList(user.user!.userHRCode!),

          child: BlocConsumer<
              EmployeeAppraisalBlocCubit,
              EmployeeAppraisalBlocState>(
            listener: (context, state) {
              if (state is BlocGetEmployeeAppraisalBlocInitialSuccessState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Success"),
                  ),
                );

                employeeAppraisalList = jsonDecode(state.employeeAppraisaleList)["data"];

                // employee_appraisal_model!.overallscore = employeeAppraisaleList!.elementAt(0)["overallscore"];

                appraisalDataList.add(ObjectAppraisalModel("Company", employeeAppraisalList!.elementAt(0)["companyScore"]));
                appraisalDataList.add( ObjectAppraisalModel("Department", employeeAppraisalList!.elementAt(0)["departmentScore"]));
                appraisalDataList.add( ObjectAppraisalModel("Individual", employeeAppraisalList!.elementAt(0)["individualScore"]));
                appraisalDataList.add( ObjectAppraisalModel("Competence", employeeAppraisalList!.elementAt(0)["competencescore"]));

              } else
              if (state is BlocGetEmployeeAppraisalBlocInitialErrorState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("error"),
                  ),
                );
              } else
              if (state is BlocGetEmployeeAppraisalBlocInitialLoadingState) {
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(
                          "assets/images/S_Background.png"),
                          fit: BoxFit.cover)
                  ),
                  child: Column(
                    children: [
                      EmployeeAppraisalTicketWidget(appraisalDataList)

                    ],),
                );
            },
          ),
        ),
      );
    }
  }

