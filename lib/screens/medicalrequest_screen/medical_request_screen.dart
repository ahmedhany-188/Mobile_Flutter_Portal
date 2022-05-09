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



  String selectedValueLab = "" ;
  String selectedValueService = "" ;

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

  Future<void> _sendSubmit(BuildContext context) async{

    final user = context.select((AppBloc bloc) => bloc.state.user);
    String HR_code=user.userHRCode.toString();

    if(selectedValueService=="" || selectedValueLab=="" || Patientname_MedicalRequest.text=="" || HAHuser_MedicalRequest.text==""){


      Fluttertoast.showToast(
          msg: "Fill all the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );

    }else{

      BlocProvider.of<MedicalRequestCubit>(context)
        .getSuccessMessage(HR_code,HAHuser_MedicalRequest.text,Patientname_MedicalRequest.text,selectedValueLab,selectedValueService,"${selectedDate.toLocal()}".split(' ')[0]+"T12:39:19.532Z");

    }




  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),

      body: BlocConsumer<MedicalRequestCubit, MedicalRequestState>(
          listener: (context, state) {
            if (state is BlocgetTheMedicalRequestSuccesState) {

              launch(jsonDecode(state.getMedicalRequestMessage)['link']);

            }
          },

          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                      controller: Patientname_MedicalRequest,
                      decoration: InputDecoration(
                        labelText: "Patient Name",
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
                        labelText: "HAH User",
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      )
                  ),

                  Container(height: 20),

                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select ticket date'),
                  ),

                  Container(height: 20),

                  Text("${selectedDate.toLocal()}".split(' ')[0]),

                  Text("${selectedDate.toLocal()}"),

                  Text("Lab Type"),

                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        selectedValueLab,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme
                              .of(context)
                              .hintColor,
                        ),
                      ),
                      items: LabsType
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
                          selectedValueLab = value.toString();
                        });
                      },
                      // value: selectedValueLab,
                    ),
                  ),

                  Text("Service Type"),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        selectedValueService,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme
                              .of(context)
                              .hintColor,
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
                      // value: selectedValueLab,
                    ),
                  ),

                  RaisedButton(
                    onPressed: () => _sendSubmit(context),
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          },
        ),

    );
  }

  OutlineInputBorder myinputborder() {
    // return type is OutlineInputBorder
    return const OutlineInputBorder( // Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        )
    );
  }

}

