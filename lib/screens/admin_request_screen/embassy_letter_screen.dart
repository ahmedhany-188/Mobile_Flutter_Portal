

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/embassy_letter_request/embassy_letter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';

class EmbassyLetterScreen extends StatefulWidget{

  static const routeName = "/embassy-letter-screen";
  const EmbassyLetterScreen({Key? key}) : super(key: key);

  @override
  State<EmbassyLetterScreen> createState() => _EmbassyLetterScreen();

}

class _EmbassyLetterScreen extends State<EmbassyLetterScreen>{

  List<String> purposeList = [
    "Tourism",
    "Business",
  ];
  List<String> embassyList = [
  "Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua","Barbuda","Argentina","Armenia","Aruba",
    "Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin",
    "Bermuda","Bhutan","Bolivia","Bosnia","Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria",
    "Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo",
    "Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti",
    "Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands",
    "Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana",
    "Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras",
    "Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Italy","Jamaica","Japan", "Jersey","Jordan",
    "Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein", "Lithuania",
    "Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius", "Mexico","Moldova",
    "Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles", "New Caledonia",
    "New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay", "Peru",
    "Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre","Miquelon","Samoa", "San Marino",
    "Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea", "Spain",
    "Sri Lanka","St Kitts","Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland", "Syria", "Taiwan",
    "Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad","Tobago","Tunisia","Turkey","Turkmenistan", "Turks","Caicos",
    "Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)", "Yemen","Zambia","Zimbabwe"

  ];
  List<String> addSalaryList = [
    "Yes",
    "No"
  ];

  String selectedPurpose="",selectedEmbassy="",selectedSalary="";

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    final user = context.select((AppBloc bloc) => bloc.state.userData);
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text("Embassy Letter"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,

      drawer: MainDrawer(),

      body: BlocListener<EmbassyLetterCubit,EmbassyLetterInitial>(
        listener: (context,state){

          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Success"),
              ),
            );
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    TextFormField(
                      initialValue: formattedDate,
                      key: UniqueKey(),
                      readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelAlignment:
                        FloatingLabelAlignment.start,
                        labelText: 'Request Date',
                        prefixIcon: const Icon(
                            Icons.calendar_today),
                      ),
                    ),


                    Container(height: 10),

                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                      builder: (context, state) {
                        return Container(
                            decoration: outlineboxTypes(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                hint: Text(
                                  selectedPurpose,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                items: purposeList.map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item, child: Text(item,
                                        style: const TextStyle(fontSize: 14,),
                                      ),
                                    )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedPurpose = value.toString();
                                  });
                                  context.read<EmbassyLetterCubit>().addSelectedPurpose(
                                      selectedPurpose);
                                },
                              ),
                            ),
                          );
                      },),

                    Container(height: 10,),

                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                      builder: (context, state) {
                        return Container(
                          decoration: outlineboxTypes(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: Text(
                                selectedEmbassy,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              items: embassyList.map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item, child: Text(item,
                                    style: const TextStyle(fontSize: 14,),
                                  ),
                                  )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedEmbassy = value.toString();
                                });
                                context.read<EmbassyLetterCubit>().addSelectedEmbassy(
                                    selectedEmbassy);
                              },
                            ),
                          ),
                        );
                      },),

                    Container(height: 10,),


                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.dateFrom.value,
                          key: UniqueKey(),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'From Date',
                            errorText: state.dateFrom.invalid
                                ? 'invalid Date'
                                : null,
                            prefixIcon: const Icon(
                                Icons.calendar_today),
                          ),
                          onTap: () async {
                            context.read<EmbassyLetterCubit>().
                            selectDate(context, "from");
                          },
                        );
                      },),

                    Container(height: 10,),

                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.dateTo.value,
                          key: UniqueKey(),
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            labelText: 'To Date',
                            errorText: state.dateTo.invalid
                                ? 'invalid Date'
                                : null,
                            prefixIcon: const Icon(
                                Icons.calendar_today),
                          ),
                          onTap: () async {
                            context.read<EmbassyLetterCubit>().
                            selectDate(context, "to");
                          },
                        );
                      },),


                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                        builder: (context, state) {
                          return TextField(
                              onChanged: (value) {
                                context.read<EmbassyLetterCubit>()
                                    .passportNo(value);
                              },
                              decoration: InputDecoration(
                                labelText: "Passport NO",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                prefixIcon: Icon(Icons.people),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                                errorText: state.passportNumber.invalid
                                    ? 'invalid No'
                                    : null,
                              )
                          );
                        }
                    ),

                    Container(height: 10,),

                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                      builder: (context, state) {
                        return Container(
                          decoration: outlineboxTypes(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: Text(
                                selectedSalary,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              items: addSalaryList.map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item, child: Text(item,
                                    style: const TextStyle(fontSize: 14,),
                                  ),
                                  )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedSalary = value.toString();
                                });
                                context.read<EmbassyLetterCubit>().addSelectedSalary(
                                    selectedSalary);
                              },
                            ),
                          ),
                        );
                      },),

                    Container(height: 10,),


                    BlocBuilder<EmbassyLetterCubit, EmbassyLetterInitial>(
                        builder: (context, state) {
                          return TextField(
                              onChanged: (value) {
                                context.read<EmbassyLetterCubit>()
                                    .comments(value);
                              },
                              decoration: InputDecoration(
                                labelText: "Comments",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                prefixIcon: Icon(Icons.people),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                              )
                          );
                        }
                    ),

                    FloatingActionButton.extended(
                      onPressed: () {
                        context.read<EmbassyLetterCubit>()
                            .getSubmitEmbassyLetter(
                            user, formattedDate);
                      },
                      label: const Text('Submit', style: TextStyle(
                          color: Colors.black
                      )),
                      icon: const Icon(
                          Icons.thumb_up_alt_outlined, color: Colors.black),
                      backgroundColor: Colors.white,),

                    Container(height: 10,),

                  ],
                ),
              ),
            ),
          ),

        ),

      ),
    );



  }

  BoxDecoration outlineboxTypes() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 3, color: Colors.black)
    );
  }

}