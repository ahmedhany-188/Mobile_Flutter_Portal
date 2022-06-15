import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/embassy_letter_request/embassy_letter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';

class EmbassyLetterScreen extends StatefulWidget{

  static const routeName = "/embassy-letter-screen";
  static const requestNoKey = 'request-No';

  const EmbassyLetterScreen({Key? key,this.requestNo}) : super(key: key);

  final requestNo;

  @override
  State<EmbassyLetterScreen> createState() => _EmbassyLetterScreen();

}

class _EmbassyLetterScreen extends State<EmbassyLetterScreen> {


  List<String> purposeList = [
    "Tourism",
    "Business",
  ];
  List<String> embassyList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antigua",
    "Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia",
    "Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Cape Verde",
    "Cayman Islands",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D Ivoire",
    "Croatia",
    "Cruise Ship",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Polynesia",
    "French West Indies",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyz Republic",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Namibia",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Pierre",
    "Miquelon",
    "Samoa",
    "San Marino",
    "Satellite",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "St Kitts",
    "Nevis",
    "St Lucia",
    "St Vincent",
    "St. Lucia",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor L'Este",
    "Togo",
    "Tonga",
    "Trinidad",
    "Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks",
    "Caicos",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Virgin Islands (US)",
    "Yemen",
    "Zambia",
    "Zimbabwe"

  ];
  List<String> addSalaryList = [
    "Yes",
    "No"
  ];


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;


    final user = context.select((AppBloc bloc) => bloc.state.userData);
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.now());

    final TextEditingController passportController = TextEditingController();
    final TextEditingController commentController = TextEditingController();

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: BlocProvider<EmbassyLetterCubit>(
        create: (embassyLetterContext) =>
            EmbassyLetterCubit(RequestRepository(user)),
        child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Embassy Letter"),
                  centerTitle: true,
                ),
                resizeToAvoidBottomInset: false,

                /*
                floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.verified),
                        label: const Text('Accept'),
                      ),
                      const SizedBox(height: 12),
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        backgroundColor: Colors.red,
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.dangerous),

                        label: const Text('Reject'),
                      ),
                      const SizedBox(height: 12),
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus == RequestStatus.newRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<AccessRightCubit>()
                                .getSubmitAccessRight(selectedTypes);
                          },
                          // formBloc.state.status.isValidated
                          //       ? () => formBloc.submitPermissionRequest()
                          //       : null,
                          // formBloc.submitPermissionRequest();

                          icon: const Icon(Icons.send),
                          label: const Text('SUBMIT'),
                        ),
                      const SizedBox(height: 12),
                    ],
                  ),
                 */


                body: BlocListener<EmbassyLetterCubit, EmbassyLetterInitial>(
                  listener: (context, state) {
                    if (state.status.isSubmissionSuccess) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Success"),
                        ),
                      );
                    }
                    else if (state.status.isSubmissionInProgress) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
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


                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(

                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:formattedDate,
                                key: UniqueKey(),
                                readOnly: true,
                                decoration: const InputDecoration(
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                                  labelText: 'Request Date',
                                  prefixIcon: Icon(
                                      Icons.calendar_today),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                builder: (context, state) {
                                  return DropdownButtonHideUnderline(

                                    child: DropdownButtonFormField(


                                      hint: Text(
                                        state.purpose,
                                        style: const TextStyle(
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
                                          context.read<EmbassyLetterCubit>()
                                              .addSelectedPurpose(
                                              value.toString());
                                        });
                                      },
                                    ),
                                  );
                                },),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                builder: (context, state) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      hint: Text(state.embassy,

                                        style: const TextStyle(
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
                                          context.read<EmbassyLetterCubit>()
                                              .addSelectedEmbassy(
                                              value.toString());
                                        });
                                      },
                                    ),
                                  );
                                },),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                builder: (context, state) {
                                  return TextFormField(

                                    initialValue:state.dateFrom.value,

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
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    initialValue:state.dateTo.value,

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
                                      // if (!widget.objectValidation) {
                                      //   context.read<EmbassyLetterCubit>().
                                      //   selectDate(context, "to");
                                      // }
                                    },
                                  );
                                },),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return TextField(
                                        controller: passportController,
                                        onChanged: (value) {
                                          context.read<EmbassyLetterCubit>()
                                              .passportNo(value);
                                        },
                                        // enabled: (widget.objectValidation)
                                        //     ? false
                                        //     : true,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(

                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: "Passport NO",
                                          prefixIcon: const Icon(Icons.book),

                                          errorText: state.passportNumber.invalid
                                              ? 'invalid Passport NO'
                                              : null,
                                        )
                                    );
                                  }
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                builder: (context, state) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      hint: Text(state.salary,
                                        style: const TextStyle(
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
                                          context.read<EmbassyLetterCubit>()
                                              .addSelectedSalary(
                                              value.toString());
                                        });
                                      },
                                    ),
                                  );
                                },),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<EmbassyLetterCubit,
                                  EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return TextField(
                                        controller: commentController,
                                        onChanged: (value) {
                                          context.read<EmbassyLetterCubit>()
                                              .comments(value);
                                        },
                                        // enabled: (widget.objectValidation)
                                        //     ? false
                                        //     : true,
                                        decoration: InputDecoration(
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: "Comments",
                                          prefixIcon: const Icon(Icons.comment),
                                          border: myinputborder(),
                                        )
                                    );
                                  }
                              ),
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
                                  Icons.thumb_up_alt_outlined,
                                  color: Colors.black),
                              backgroundColor: Colors.white,),


                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              );
            }
        ),
      ),
    );
  }
  BoxDecoration outlineboxTypes() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 3, color: Colors.black)
    );
  }

}