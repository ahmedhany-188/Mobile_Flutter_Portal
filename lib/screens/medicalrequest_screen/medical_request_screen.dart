import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

// ignore: camel_case_types
class MedicalRequestScreen extends StatefulWidget{

  static const routeName = "/medical-request-screen";

  const MedicalRequestScreen({Key? key}) : super(key: key);
  @override
  State<MedicalRequestScreen> createState() => _medical_request_state();
}

class _medical_request_state extends State<MedicalRequestScreen> {


  TextEditingController hrUserMedicalRequest = TextEditingController();


  String selectedValueLab = "";
  String selectedValueService = "";
  List<String> LabsType = [
    "ELmokhtaber",
    "ELBORG",
  ];
  List<String> ServiceTypeElborg = [
    "Lab",
    "Scan",
  ];
  List<String> ServiceTypeElmokhtabr = [
    "Lab",
  ];
  String DateAdded = "";


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    final user = context.select((AppBloc bloc) => bloc.state.userData);
    hrUserMedicalRequest.text = user.employeeData!.userHrCode!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Request"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),

      body: BlocListener<MedicalRequestCubit, MedicalRequestInitial>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success"),
              ),
            );
            _launchUrl(jsonDecode(state.successMessage.toString())['link']);
          }
          else if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Loading"),
              ),
            );
          }
          else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.toString()),
              ),
            );
          }
        },

        child: Container(

          // decoration: const BoxDecoration(
          //     image: DecorationImage(image: AssetImage(
          //         "assets/images/S_Background.png"),
          //         fit: BoxFit.cover)
          // ),

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    BlocBuilder<MedicalRequestCubit, MedicalRequestInitial>(
                        builder: (context, state) {
                          return TextField(
                              onChanged: (name) {
                                context.read<MedicalRequestCubit>()
                                    .patientName(name);
                              },
                              decoration: InputDecoration(
                                labelText: "Patient Name",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                prefixIcon: Icon(Icons.people),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),

                                errorText: state.patientnameMedicalRequest
                                    .invalid
                                    ? 'invalid Name'
                                    : null,

                              )
                          );
                        }
                    ),


                    Container(height: 20),

                    TextField(
                        enabled: false,

                        controller: hrUserMedicalRequest,
                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.lock),
                          labelStyle: TextStyle(
                              color: Colors.white, fontSize: 15),
                          labelText: "Hr code:",
                          enabledBorder: myinputborder(),
                          focusedBorder: myfocusborder(),

                        )
                    ),

                    Container(height: 20),


                    BlocBuilder<MedicalRequestCubit, MedicalRequestInitial>(
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.requestDate.value,
                          key: UniqueKey(),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'Select Date',
                            errorText: state.requestDate.invalid
                                ? 'invalid Date'
                                : null,
                            prefixIcon: const Icon(
                                Icons.calendar_today),
                          ),
                          onTap: () async {
                            context.read<MedicalRequestCubit>().
                            selectDate(context);
                          },
                        );
                      },),

                    Container(height: 10),

                    Text("Lab Type",
                        style: TextStyle(color: Colors.black, fontSize: 15,
                          fontFamily: 'Nunito',)),


                    BlocBuilder<MedicalRequestCubit, MedicalRequestInitial>(
                      builder: (context, state) {
                        return
                          Container(
                            decoration: outlineboxTypes(),
                            child: DropdownButtonHideUnderline(

                              child: DropdownButtonFormField(

                                decoration: InputDecoration(
                                  errorText: state.selectedValueLab.invalid
                                      ? 'select lab'
                                      : null,
                                ),
                                hint: Text(
                                  selectedValueLab,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),

                                ),
                                items: LabsType.map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                onChanged: (value) {

                                  setState(() {
                                    selectedValueLab = value.toString();
                                  });
                                  context.read<MedicalRequestCubit>().addSelectedLab(
                                      selectedValueLab);
                                },
                              ),

                            ),
                          );
                      },),


                    Text("Service Type",
                        style: TextStyle(color: Colors.black, fontSize: 15,
                          fontFamily: 'Nunito',)),

                    BlocBuilder<MedicalRequestCubit, MedicalRequestInitial>(
                      builder: (context, state) {
                        return
                          Container(
                            decoration: outlineboxTypes(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(

                                decoration: InputDecoration(
                                  errorText: state.selectedValueService.invalid
                                      ? 'select service'
                                      : null,
                                ),
                                hint: Text(
                                  selectedValueService,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                items: ServiceTypeElborg
                                    .map((item) =>
                                    DropdownMenuItem<String>(
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
                                  context.read<MedicalRequestCubit>().addSelectedService(
                                      selectedValueService);
                                },
                              ),

                            ),
                          );
                      },),
                    Container(height: 10),

                    FloatingActionButton.extended(
                      onPressed: () {
                        String HR_code = user.user!.userHRCode.toString();
                        context.read<MedicalRequestCubit>().getSuccessMessage(
                            HR_code);
                      },
                      label: const Text('Submit', style: TextStyle(
                          color: Colors.black
                      )),
                      icon: const Icon(
                          Icons.thumb_up_alt_outlined, color: Colors.black),
                      backgroundColor: Colors.white,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

  OutlineInputBorder myinputborder() {
    // return type is OutlineInputBorder
    return const OutlineInputBorder( // Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        )
    );
  }

  BoxDecoration outlineboxTypes() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 3, color: Colors.black)
    );
  }

void _launchUrl(_url) async {

  FlutterWebBrowser.openWebPage(
    url: _url,
    customTabsOptions: const CustomTabsOptions(
      colorScheme: CustomTabsColorScheme.dark,
      toolbarColor: Colors.blue,
      secondaryToolbarColor: Colors.green,
      navigationBarColor: Colors.amber,
      shareState: CustomTabsShareState.on,
      instantAppsEnabled: true,
      showTitle: true,
      urlBarHidingEnabled: true,
    ),
    safariVCOptions: const SafariViewControllerOptions(
      barCollapsingEnabled: true,
      preferredBarTintColor: Colors.green,
      preferredControlTintColor: Colors.amber,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );

}



