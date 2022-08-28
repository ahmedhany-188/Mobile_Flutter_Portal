
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/employee_appraisal_screen_bloc/employee_appraisal_bloc_cubit.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/object_appraisal_model.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EmployeeAppraisalScreen extends StatefulWidget {
  static const routeName = "/employee-appraisal-list";
  const EmployeeAppraisalScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeAppraisalScreen> createState() =>
      EmployeeAppraisalScreenState();
}

class EmployeeAppraisalScreenState extends State<EmployeeAppraisalScreen> {

  EmployeeAppraisalModel? employeeAppraisalModel;
  DataEmployeeAppraisalModel? dataEmployeeAppraisalModel;
  List<ObjectAppraisalModel> appraisalDataList = [];

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Appraisal'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          resizeToAvoidBottomInset: false,
          // drawer: MainDrawer(),

          body: BlocProvider<EmployeeAppraisalBlocCubit>(
            create: (context) =>
            EmployeeAppraisalBlocCubit()
              ..getEmployeeAppraisalList(user.user!.userHRCode!),
            child: BlocConsumer<EmployeeAppraisalBlocCubit,
                EmployeeAppraisalBlocState>(
              listener: (context, state) {
                if (state is BlocGetEmployeeAppraisalBlocInitialSuccessState) {}
                else
                if (state is BlocGetEmployeeAppraisalBlocInitialErrorState) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("error"),
                    ),
                  );
                } else if (state
                is BlocGetEmployeeAppraisalBlocInitialLoadingState) {}
              },
              builder: (context, state) {
                if (state is BlocGetEmployeeAppraisalBlocInitialSuccessState) {
                  employeeAppraisalModel = state.employeeAppraisaleList;
                  dataEmployeeAppraisalModel = employeeAppraisalModel?.data![0];

                  if (dataEmployeeAppraisalModel != null) {
                    appraisalDataList.add(ObjectAppraisalModel(
                        "Company", dataEmployeeAppraisalModel!.companyScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Department",
                        dataEmployeeAppraisalModel!.departmentScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Individual",
                        dataEmployeeAppraisalModel!.individualScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Competence",
                        dataEmployeeAppraisalModel!.competencescore!));

                    return Column(
                      children: [
                        getOverallContainer("Overall Score",
                            dataEmployeeAppraisalModel!.overallscore!),
                        EmployeeAppraisalTicketWidget(appraisalDataList),
                      ],
                    );
                  } else {
                    return const Center(child: Text("No Data Found",
                        style: TextStyle(fontSize: 20, color: Colors.white)));
                  }
                }
                else {
                  return const Center(child: Text("Failed to found data",
                      style: TextStyle(fontSize: 20, color: Colors.white)));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column getOverallContainer(String name, double value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: LinearPercentIndicator(
            width: MediaQuery
                .of(context)
                .size
                .width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: value / 100,
            center: Text(value.toString()),
            linearStrokeCap: LinearStrokeCap.roundAll,
            barRadius: Radius.circular(10),
            progressColor: Colors.indigo,
          ),
        ),
        Text(name),
      ],
    );
  }
}
