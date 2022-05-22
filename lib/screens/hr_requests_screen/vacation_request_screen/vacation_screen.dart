import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/hr_request_bloc/vacation_request/vacation_cubit.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';


class VacationScreen extends StatefulWidget {
  static const routeName = 'vacation-page';

  const VacationScreen({Key? key}) : super(key: key);

  @override
  State<VacationScreen> createState() => _VacationScreenState();
}

class _VacationScreenState extends State<VacationScreen> {
  @override
  Widget build(BuildContext context) {
    // final formBloc = context.select((PermissionFormBloc bloc) => bloc.state);

    TextEditingController vacationDateFromController = TextEditingController();
    TextEditingController vacationDateToController = TextEditingController();
    TextEditingController permissionTimeController = TextEditingController();
    final user = context.select((AppBloc bloc) =>
    bloc.state.userData.employeeData);

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: BlocProvider<VacationCubit>(
        create: (permissionContext) =>
        VacationCubit(RequestRepository())
          ..getRequestData(RequestStatus.newRequest),
        child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Vacation Request')),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(context
                        .read<VacationCubit>()
                        .state
                        .requestStatus ==
                        RequestStatus.oldRequest)FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {},
                      icon: const Icon(Icons.verified),
                      label: const Text('Accept'),
                    ),
                    const SizedBox(height: 12),
                    if(context
                        .read<VacationCubit>()
                        .state
                        .requestStatus ==
                        RequestStatus.oldRequest)FloatingActionButton.extended(
                      backgroundColor: Colors.red,
                      heroTag: null,
                      onPressed: () {},
                      icon: const Icon(Icons.dangerous),

                      label: const Text('Reject'),
                    ),
                    const SizedBox(height: 12),
                    if(context
                        .read<VacationCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<VacationCubit>()
                              .submitPermissionRequest(user?.userHrCode ?? "0");
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
                body: BlocListener<VacationCubit, VacationInitial>(
                  listener: (context, state) {
                    if (state.status.isSubmissionInProgress){
                      LoadingDialog.show(context);
                    }
                    if(state.status.isSubmissionSuccess){
                      LoadingDialog.hide(context);
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen(text: state.successMessage ?? "Error Number",)));

                    }
                    if (state.status.isSubmissionFailure) {
                      LoadingDialog.hide(context);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                state.errorMessage ?? 'Request Failed'),
                          ),
                        );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.requestDate !=
                                        current.requestDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: const Key(
                                          'loginForm_usernameInput_textField'),
                                      initialValue: state.requestDate.value,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Request Date',
                                        errorText: state.requestDate.invalid
                                            ? 'invalid request date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  labelText: 'Vacation Type',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                                  prefixIcon: Icon(Icons.event),
                                ),
                                child: BlocBuilder<VacationCubit,
                                    VacationInitial>(
                                    buildWhen: (previous, current) {
                                      return (previous.vacationType !=
                                          current.vacationType);
                                    },
                                    builder: (context, state) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          RadioListTile<int>(
                                            value: 1,
                                            title: Text("Annual"),
                                            groupValue: state.vacationType,
                                            onChanged: (vacationType) =>
                                                context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1),
                                          ),
                                          RadioListTile<int>(
                                            value: 2,
                                            // dense: true,
                                            title: Text("Casual"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                                context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1),
                                          ),
                                          RadioListTile<int>(
                                            value: 3,
                                            // dense: true,
                                            title: Text("Holiday Replacement"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                                context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1),
                                          ),
                                          RadioListTile<int>(
                                            value: 4,
                                            // dense: true,
                                            title: Text("Maternity"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                                context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1),
                                          ),
                                          RadioListTile<int>(
                                            value: 5,
                                            // dense: true,
                                            title: Text("Haj"),
                                            groupValue: state.vacationType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (vacationType) =>
                                                context
                                                    .read<VacationCubit>()
                                                    .vacationTypeChanged(
                                                    vacationType ?? 1),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.vacationFromDate !=
                                        current.vacationFromDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (vacationDate) =>
                                          context
                                              .read<VacationCubit>()
                                              .vacationFromDateChanged(
                                              vacationDate),
                                      readOnly: true,
                                      controller: vacationDateFromController,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Vacation From Date',
                                        errorText: state.vacationFromDate.invalid
                                            ? 'invalid permission date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),
                                      onTap: () async {
                                        DateTime? date = DateTime.now();
                                        FocusScope.of(context).requestFocus(
                                            FocusNode());
                                        date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100));
                                        var formatter = DateFormat(
                                            'EEEE dd-MM-yyyy');
                                        String formattedDate = formatter.format(
                                            date ?? DateTime.now());
                                        vacationDateFromController.text =
                                            formattedDate;
                                        // (permissionDate) =>
                                        context
                                            .read<VacationCubit>()
                                            .vacationFromDateChanged(
                                            formattedDate);
                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.vacationToDate !=
                                        current.vacationToDate) ||
                                        previous.status != current.status ||
                                    previous.vacationFromDate != current.vacationFromDate;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (vacationDate) =>
                                          context
                                              .read<VacationCubit>()
                                              .vacationToDateChanged(
                                              vacationDate),
                                      readOnly: true,
                                      controller: vacationDateToController,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Vacation To Date',
                                        errorText: state.vacationToDate.invalid
                                            ? 'invalid permission date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),
                                      onTap: () async {
                                        DateTime? date = DateTime.now();
                                        FocusScope.of(context).requestFocus(
                                            FocusNode());
                                        date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100));
                                        var formatter = DateFormat(
                                            'EEEE dd-MM-yyyy');
                                        String formattedDate = formatter.format(
                                            date ?? DateTime.now());
                                        vacationDateToController.text =
                                            formattedDate;
                                        // (permissionDate) =>
                                        context
                                            .read<VacationCubit>()
                                            .vacationToDateChanged(
                                            formattedDate);
                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  buildWhen: (previous, current) {

                                    print(previous.vacationDuration);
                                    print(current.vacationDuration);

                                    return (previous.vacationDuration !=
                                        current.vacationDuration);
                                  },
                                  builder: (context, state) {
                                    print("from Screen${state.vacationDuration}");
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.vacationDuration,
                                      readOnly : true,
                                      decoration: InputDecoration(
                                        labelText: 'Vacation Duration',
                                        prefixIcon: const Icon(
                                            Icons.date_range),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  VacationCubit,
                                  VacationInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (commentValue) =>
                                          context
                                              .read<VacationCubit>()
                                              .commentChanged(commentValue),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800]),
                                        labelText: "Add your comment",
                                        fillColor: Colors.white70,
                                        prefixIcon: Icon(Icons.comment),
                                        enabled: true,
                                      ),

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
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const VacationScreen())),
              icon: const Icon(Icons.replay),
              label: const Text('Create Another Permission Request'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}