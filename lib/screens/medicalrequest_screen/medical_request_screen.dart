import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/medical_request_screen_bloc/medical_request_cubit.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class MedicalRequestScreen extends StatefulWidget{

  static const routeName = "/medical-request-screen";

  const MedicalRequestScreen({Key? key}) : super(key: key);
  @override
  State<MedicalRequestScreen> createState() => _medical_request_state();
}

class _medical_request_state extends State<MedicalRequestScreen> {

  TextEditingController Patientname_MedicalRequest = TextEditingController();
  TextEditingController HAHuser_MedicalRequest = TextEditingController();


  String selectedValueLab = "";

  String selectedValueService = "";

  List<String> LabsType = [
    "Al mokhtabar",
    "Al borg",
  ];

  List<String> ServiceTypeElborg = [
    "Analysis",
    "X-Ray",
  ];

  List<String> ServiceTypeElmokhtabr = [
    "Analysis",
  ];

  DateTime selectedDate = DateTime.now();

  // set the new date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;


    final user = context.select((AppBloc bloc) => bloc.state.userData);

    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Request"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,


      drawer: MainDrawer(),

      body: BlocConsumer<MedicalRequestCubit, MedicalRequestState>(
        listener: (context, state) {
          if (state is BlocgetTheMedicalRequestSuccesState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.getMedicalRequestMessage),
              ),
            );
            launch(jsonDecode(state.getMedicalRequestMessage)['link']);
          }
          else if (state is BlocGetTheMedicalRequestLoadingState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Loading"),
              ),
            );
          }
          else if (state is BlocgetTheMedicalRequestErrorState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMedicalRequestMessage),
              ),
            );
          }
          // else if (state is BlocGetTheMedicalRequestDownloadState) {
          //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.getMedicalRequestDownloadMessage),
          //     ),
          //   );
          // }
        },

        builder: (context, state) {
          return Container(

            // decoration: const BoxDecoration(
            //     image: DecorationImage(image: AssetImage(
            //         "assets/images/S_Background.png"),
            //         fit: BoxFit.cover)
            // ),


            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                    controller: Patientname_MedicalRequest,
                    decoration: InputDecoration(
                      labelText: "Patient Name",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.people),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    )
                ),


                Container(height: 20),

                TextField(
                    controller: HAHuser_MedicalRequest,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "HAH User",
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    )
                ),

                Container(height: 20),

                Container(

                  constraints: BoxConstraints(
                      maxWidth: double.infinity, minHeight: 50.0),
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Select ticket date',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Container(height: 10),

                Text("${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.black, fontSize: 15,
                      fontFamily: 'Nisebuschgardens'),
                ),

                Text("${selectedDate.toLocal()}",
                  style: TextStyle(color: Colors.black, fontSize: 15,
                      fontFamily: 'Nisebuschgardens'),),

                Text("Lab Type",
                    style: TextStyle(color: Colors.black, fontSize: 15,
                      fontFamily: 'Nunito',)),

                DropdownButtonHideUnderline(
                  child: DropdownButton2(

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
                    },

                  ),
                ),

                Text("Service Type",
                    style: TextStyle(color: Colors.black, fontSize: 15,
                      fontFamily: 'Nunito',)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
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
                    },
                    // buttonDecoration: outlineboxTypes(),
                    // value: selectedValueLab,
                  ),
                ),

                FloatingActionButton.extended(
                  onPressed: () {
                    String HR_code = user.user!.userHRCode.toString();
                    if (selectedValueService == "" ||
                        selectedValueLab == "" ||
                        Patientname_MedicalRequest.text == "" ||
                        HAHuser_MedicalRequest.text == "") {
                      Fluttertoast.showToast(
                          msg: "Fill all the fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      BlocProvider.of<MedicalRequestCubit>(context)
                          .getSuccessMessage(
                          HR_code, HAHuser_MedicalRequest.text,
                          Patientname_MedicalRequest.text, selectedValueLab,
                          selectedValueService,
                          "${selectedDate.toLocal()}".split(' ')[0] +
                              "T12:39:19.532Z");
                    }
                  },
                  label: const Text('Submit'),
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  backgroundColor: Colors.indigo,)
              ],
            ),
          );
        },
      ),
    );
  }

  }

  OutlineInputBorder myinputborder() {
    // return type is OutlineInputBorder
    return const OutlineInputBorder( // Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.indigo,
          width: 3,
        )
    );
  }

  BoxDecoration outlineboxTypes() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Colors.white)
    );
  }


