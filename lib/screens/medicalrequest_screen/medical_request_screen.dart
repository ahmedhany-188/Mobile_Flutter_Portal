import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/repositories/medical_request_repository.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class MedicalRequestScreen extends StatefulWidget {
  static const routeName = "/medical-request-screen";
  const MedicalRequestScreen({Key? key}) : super(key: key);
  @override
  State<MedicalRequestScreen> createState() => MedicalRequestState();
}

class MedicalRequestState extends State<MedicalRequestScreen> {
  TextEditingController hrUserMedicalRequest = TextEditingController();

  String selectedValueLab = "";
  String selectedValueService = "";

  String dateAdded = "";

  List<String> servicesListState = [];

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    hrUserMedicalRequest.text = user.employeeData?.userHrCode??"";

    return CustomBackground(
      child: CustomTheme(
        child: BlocProvider<MedicalRequestCubit>(
          create: (medicalRequestContext) => MedicalRequestCubit(MedicalRepository(user)),
          child: Builder(builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                await EasyLoading.dismiss(animation: true);
                return true;
              },
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: const Text("Medical Request"),
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),

                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        onPressed: () {
                          String hrCode = user.user?.userHRCode.toString()??"";
                          context
                              .read<MedicalRequestCubit>()
                              .getSuccessMessage(hrCode);
                        },
                        label: const Text('SUBMIT'),
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                  // drawer: MainDrawer(),

                  body:
                  BlocListener<MedicalRequestCubit, MedicalRequestInitial>(
                    listener: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        EasyLoading.showSuccess(
                          "Success",
                        );
                        try {
                          launchUrl(
                            Uri.parse(jsonDecode(
                                state.successMessage.toString())['link']),
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e, s) {
                          if (kDebugMode) {
                            print(s);
                          }
                        }
                      } else if (state.status.isSubmissionInProgress) {
                        EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                          dismissOnTap: false,
                        );
                      } else if (state.status.isSubmissionFailure) {
                        EasyLoading.showError(
                          state.errorMessage.toString(),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<MedicalRequestCubit,
                                    MedicalRequestInitial>(
                                    builder: (context, state) {
                                      return TextField(
                                          style: const TextStyle(color: Colors.white),
                                          cursorColor: Colors.white,
                                          onChanged: (name) {
                                            context
                                                .read<MedicalRequestCubit>()
                                                .patientName(name);
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Patient Name",
                                            prefixIcon: const Icon(Icons.people,color: Colors.white70,),
                                            errorText: state
                                                .patientNameMedicalRequest.invalid
                                                ? 'invalid Name'
                                                : null,
                                          ));
                                    }),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: TextField(
                                    enabled: false,
                                    style: const TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                    controller: hrUserMedicalRequest,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: "HR Code",
                                    )),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<MedicalRequestCubit,
                                    MedicalRequestInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue: state.requestDate.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      style: const TextStyle(color: Colors.white),
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Select Date',
                                        errorText: state.requestDate.invalid
                                            ? 'invalid Date'
                                            : null,
                                        prefixIcon:
                                        const Icon(Icons.calendar_today,color: Colors.white70,),
                                      ),
                                      onTap: () async {
                                        context
                                            .read<MedicalRequestCubit>()
                                            .selectDate(context);
                                      },
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<MedicalRequestCubit,
                                    MedicalRequestInitial>(
                                  builder: (context, state) {
                                    return DropdownButtonFormField(
                                      iconEnabledColor: Colors.white,
                                      dropdownColor:
                                      ConstantsColors.bottomSheetBackground,
                                      style: const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: "Lab Type",
                                        prefixIcon: const Icon(Icons.vaccines,color: Colors.white70,),
                                        errorText: state.selectedValueLab.invalid
                                            ? 'select lab'
                                            : null,
                                      ),
                                      hint: Text(
                                        selectedValueLab,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      items: GlobalConstants.labsType
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValueLab = value.toString();

                                          if (selectedValueLab == "ELmokhtaber") {
                                            servicesListState = GlobalConstants
                                                .serviceTypeElMokhtabr;
                                            selectedValueService="Lab";
                                            context.read<MedicalRequestCubit>()
                                                .addSelectedService("Lab");

                                          } else {
                                            servicesListState =
                                                GlobalConstants.serviceTypeElBorg;
                                          }
                                        });
                                        context
                                            .read<MedicalRequestCubit>()
                                            .addSelectedLab(selectedValueLab);
                                      },
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<MedicalRequestCubit,
                                    MedicalRequestInitial>(
                                  builder: (context, state) {
                                    return DropdownButtonFormField(
                                      key: UniqueKey(),
                                      iconEnabledColor: Colors.white,
                                      focusColor: Colors.white,
                                      iconDisabledColor: Colors.white,
                                      dropdownColor:
                                      ConstantsColors.bottomSheetBackground,
                                      style: const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Service Type',
                                        hintText: "Service Type",
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        prefixIcon:
                                        const Icon(Icons.design_services,color: Colors.white70,),
                                        errorText:
                                        state.selectedValueService.invalid
                                            ? 'select service'
                                            : null,
                                      ),
                                      hint: Text(
                                        selectedValueService,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      items: servicesListState
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValueService = value.toString();
                                        });
                                        context
                                            .read<MedicalRequestCubit>()
                                            .addSelectedService(
                                            selectedValueService);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

OutlineInputBorder myInputBorder() {
  // return type is OutlineInputBorder
  return const OutlineInputBorder(
    // Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 3,
      ));
}

OutlineInputBorder myFocusBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ));
}

BoxDecoration outlineBoxTypes() {
  return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(width: 3, color: Colors.black));
}