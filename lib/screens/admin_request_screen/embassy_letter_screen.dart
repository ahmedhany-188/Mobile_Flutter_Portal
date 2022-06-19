import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/embassy_letter_request/embassy_letter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';

import '../../constants/enums.dart';

class EmbassyLetterScreen extends StatefulWidget{

  static const routeName = "embassy-letter-screen";
  static const requestNoKey = 'request-No';

  const EmbassyLetterScreen({Key? key,this.requestNo}) : super(key: key);

  final requestNo;

  @override
  State<EmbassyLetterScreen> createState() => _EmbassyLetterScreen();

}

class _EmbassyLetterScreen extends State<EmbassyLetterScreen> {




  List<String> addSalaryList = [
    "Yes",
    "No"
  ];


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;


    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);

    final currentRequestNo = widget.requestNo;
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(DateTime.now());

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
        create: (embassyContext) =>
        currentRequestNo == null ? (EmbassyLetterCubit(
            RequestRepository(userMainData))
          ..getRequestData(RequestStatus.newRequest, ""))
            : (EmbassyLetterCubit(RequestRepository(userMainData))
          ..getRequestData(RequestStatus.oldRequest,
              currentRequestNo[EmbassyLetterScreen.requestNoKey])),
        child: BlocBuilder<EmbassyLetterCubit,EmbassyLetterInitial>(
            builder: (context,state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Embassy Letter"),
                  centerTitle: true,
                ),
                floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(state.requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.verified),
                        label: const Text('Accept'),
                      ),
                      const SizedBox(height: 12),
                      if(state.requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        backgroundColor: Colors.red,
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.dangerous),

                        label: const Text('Reject'),
                      ),
                      const SizedBox(height: 12),
                      if(state.requestStatus == RequestStatus.newRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<EmbassyLetterCubit>()
                                .submitEmbassyLetter();
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
                            if(state.requestStatus ==
                                RequestStatus.oldRequest)Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  EmbassyLetterCubit,
                                  EmbassyLetterInitial>(

                                  builder: (context, state) {
                                    return Text(state.statusAction ?? "Pending",
                                      // style: TextStyle(decoration: BoxDecoration(
                                      //   // labelText: 'Request Date',
                                      //   errorText: state.requestDate.invalid
                                      //       ? 'invalid request date'
                                      //       : null,
                                      //   prefixIcon: const Icon(
                                      //       Icons.date_range),
                                      // ),),

                                    );
                                  }
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:state.requestDate.value,
                                key: UniqueKey(),
                                readOnly: true,
                                enabled: false,
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
                                    child: IgnorePointer(
                                      ignoring: state.requestStatus == RequestStatus.oldRequest ? true :false,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: 'Purpose',
                                          prefixIcon: Icon(
                                              Icons.calendar_today),
                                        ),
                                        value: state.purpose,
                                        items: GlobalConstants.embassyLetterPurposeList.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item, child: Text(item,
                                              style: const TextStyle(fontSize: 14,),
                                            ),
                                            )).toList(),
                                        onChanged: (value) => context.read<EmbassyLetterCubit>()
                                                .addSelectedPurpose(
                                                value.toString()),
                                      ),
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
                                    child: IgnorePointer(
                                      ignoring: state.requestStatus == RequestStatus.oldRequest ? true :false,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: 'Embassy',
                                          prefixIcon: Icon(
                                              Icons.calendar_today),
                                        ),
                                        value: state.embassy,
                                        hint: Text(state.embassy,

                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),

                                        items: GlobalConstants.embassyLetterList.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item, child: Text(item,
                                              style: const TextStyle(fontSize: 14,),
                                            ),
                                            )).toList(),
                                        onChanged: (value) {
                                            context.read<EmbassyLetterCubit>()
                                                .addSelectedEmbassy(
                                                value.toString());
                                        },
                                      ),
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
                                        context.read<EmbassyLetterCubit>().
                                        selectDate(context, "to");
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
                                        onChanged: (value) {
                                          context.read<EmbassyLetterCubit>()
                                              .passportNo(value);
                                        },
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
                                      // hint: Text(state.salary,
                                      //   style: const TextStyle(
                                      //     fontSize: 14,
                                      //     color: Colors.black,
                                      //   ),
                                      // ),
                                        decoration: const InputDecoration(
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: "Add Salary",
                                          prefixIcon: Icon(Icons.money),
                                        ),
                                      items: addSalaryList.map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item, child: Text(item,
                                            style: const TextStyle(fontSize: 14,),
                                          ),
                                          )).toList(),
                                      value: state.salary,
                                      onChanged: (value) {
                                          context.read<EmbassyLetterCubit>()
                                              .addSelectedSalary(
                                              value.toString());
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
                                        // controller: commentController,
                                        onChanged: (value) {
                                          context.read<EmbassyLetterCubit>()
                                              .comments(value);
                                        },
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