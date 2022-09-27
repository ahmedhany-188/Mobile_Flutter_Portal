import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/employee_appraisal_screen_bloc/employee_appraisal_bloc_cubit.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/object_appraisal_model.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_ticket_widget.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import '../../constants/url_links.dart';

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

    var imageProfile = user.employeeData?.imgProfile ?? "";

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
                  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text("error"),
                  //   ),
                  // );
                } else if (state
                is BlocGetEmployeeAppraisalBlocInitialLoadingState) {}
              },
              builder: (context, state) {
                if (state is BlocGetEmployeeAppraisalBlocInitialSuccessState) {
                  employeeAppraisalModel = state.employeeAppraisaleList;
                  dataEmployeeAppraisalModel = employeeAppraisalModel?.data?[0];

                  if (dataEmployeeAppraisalModel != null) {
                    List<String> dateData = dataEmployeeAppraisalModel!.inDate!
                        .split('-');
                    int appraisalStatus = dataEmployeeAppraisalModel
                        ?.status ?? 0;

                    int appraisalMonth = int.parse(dateData[1]);

                    appraisalDataList.add(ObjectAppraisalModel(
                        "Company", dataEmployeeAppraisalModel!.companyScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Department",
                        dataEmployeeAppraisalModel!.departmentScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Individual",
                        dataEmployeeAppraisalModel!.individualScore!));
                    appraisalDataList.add(ObjectAppraisalModel("Competence",
                        dataEmployeeAppraisalModel!.competencescore!));

                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: imageProfile.isNotEmpty
                                    ? CachedNetworkImage(
                                  imageUrl: getUserProfilePicture(
                                      user.employeeData!.imgProfile!),
                                  imageBuilder:
                                      (context, imageProvider) =>
                                      Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      Assets
                                          .images.logo
                                          .image(height: 80),
                                  errorWidget: (context, url, error) =>
                                      Assets.images.logo
                                          .image(height: 80),
                                )
                                    : Assets.images.logo.image(height: 80),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(user.employeeData!.name.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15.0),),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text("Appraisal ${DateFormat('MMMM').format(
                                    DateTime(0,
                                        appraisalMonth))} ${dateData[0]} - #1-${dateData[0]}-${dataEmployeeAppraisalModel!
                                    .appID!}-${dataEmployeeAppraisalModel!.id!}",
                                  style: const TextStyle(color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getCircle(appraisalStatus, 1, Icons.start),
                                  SizedBox(width: 15,
                                      child: Divider(color: appraisalStatus >= 1 ?
                                      Colors.white : Colors.white70,
                                          thickness: 3.0)),
                                  getCircle(appraisalStatus, 2, Icons.person),
                                  SizedBox(width: 15,
                                      child: Divider(color: appraisalStatus >= 2 ?
                                      Colors.white : Colors.white70,
                                          thickness: 3.0)),
                                  getCircle(appraisalStatus, 3, Icons.handshake),
                                  SizedBox(width: 15,
                                      child: Divider(color: appraisalStatus >= 3 ?
                                      Colors.white : Colors.white70,
                                          thickness: 3.0)),
                                  getCircle(appraisalStatus, 4, Icons.person_add),
                                  SizedBox(width: 15,
                                      child: Divider(color: appraisalStatus >= 4 ?
                                      Colors.white : Colors.white70,
                                          thickness: 3.0)),
                                  getCircle(appraisalStatus, 5, Icons.handshake),
                                  SizedBox(width: 15,
                                      child: Divider(color: appraisalStatus >= 5 ?
                                      Colors.white : Colors.white70,
                                          thickness: 3.0)),
                                  getCircle(
                                      appraisalStatus, 6, Icons.tag_faces_rounded),
                                ],),
                            ),

                            Text(getHrMessage(appraisalStatus)),
                            getOverallContainer("Overall Score", dataEmployeeAppraisalModel!.overallscore!),

                            EmployeeAppraisalTicketWidget(appraisalDataList),

                          ],
                        ),
                      ),
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

  Container getCircle(appraisalStatus, step, icon) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: appraisalStatus >= step
                  ? Colors.white
                  : Colors.white70,
            ),
            shape: BoxShape.circle
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(
            icon,
            color: appraisalStatus >= step
                ? Colors.white
                : Colors.white70,
          ),
        ),
    );
  }

  String getHrMessage(status){

    switch(status) {
      case 0: {  return "Start Appraisal"; }
      case 1: {  return "Line Manager Approval"; }
      case 2: {  return "First Acknowledge"; }
      case 3: {  return "Director Approval"; }
      case 4: {  return "Acknowledge"; }
      case 5: {  return "Line Manager Approval"; }
      case 6: {  return "Sent to HR"; }
      default: { return "Start Appraisal"; }
    }
  }

  Column getOverallContainer(String name, double value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: LinearPercentIndicator(
            width: MediaQuery
                .of(context)
                .size
                .width - 40,
            animation: true,
            lineHeight: 25.0,
            animationDuration: 2500,
            percent: value / 100,
            center: Text(value.toString()),
            // linearStrokeCap: LinearStrokeCap.roundAll,
            barRadius: const Radius.circular(10),
            progressColor: ConstantsColors.backgroundStartColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 17.0),
          ),
        ),
      ],
    );
  }
}
