import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/request_input_widgets.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../bloc/hr_request_bloc/permission_cubit.dart';
import '../../../data/repositories/request_repository.dart';

// import '../../../bloc/hr_request_bloc/hr_permission_form_bloc.dart';

class PermissionScreen extends StatefulWidget {
  static const routeName = 'permission-page';

  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    // final formBloc = context.select((PermissionFormBloc bloc) => bloc.state);

    TextEditingController permissionDateController = TextEditingController();
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
      child: BlocProvider<PermissionCubit>(
        create: (permissionContext) =>
        PermissionCubit(RequestRepository())
          ..getRequestData(RequestStatus.newRequest),
        child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Permission Request')),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(context
                        .read<PermissionCubit>()
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
                        .read<PermissionCubit>()
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
                        .read<PermissionCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<PermissionCubit>()
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
                body: BlocListener<PermissionCubit, PermissionInitial>(
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
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  PermissionCubit,
                                  PermissionInitial>(
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
                              child: BlocBuilder<
                                  PermissionCubit,
                                  PermissionInitial>(
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.permissionDate !=
                                        current.permissionDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (permissionDate) =>
                                          context
                                              .read<PermissionCubit>()
                                              .permissionDateChanged(
                                              permissionDate),
                                      readOnly: true,
                                      controller: permissionDateController,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Permission Date',
                                        errorText: state.permissionDate.invalid
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
                                        permissionDateController.text =
                                            formattedDate;
                                        // (permissionDate) =>
                                        context
                                            .read<PermissionCubit>()
                                            .permissionDateChanged(
                                            formattedDate);
                                      },
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
                                  labelText: 'Permission Type',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                                  prefixIcon: Icon(Icons.event),
                                ),
                                child: BlocBuilder<PermissionCubit,
                                    PermissionInitial>(
                                    buildWhen: (previous, current) {
                                      return (previous.permissionType !=
                                          current.permissionType);
                                    },
                                    builder: (context, state) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          RadioListTile<int>(
                                            value: 2,
                                            title: Text("2 hours"),
                                            groupValue: state.permissionType,
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<PermissionCubit>()
                                                    .permissionTypeChanged(
                                                    permissionType!),
                                          ),
                                          RadioListTile<int>(
                                            value: 4,
                                            // dense: true,
                                            title: Text("4 hours"),
                                            groupValue: state.permissionType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<PermissionCubit>()
                                                    .permissionTypeChanged(
                                                    permissionType!),
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
                                  PermissionCubit,
                                  PermissionInitial>(
                                  buildWhen: (previous, current) =>
                                  previous.permissionTime !=
                                      current.permissionTime,
                                  builder: (context, state) {
                                    return TextFormField(
                                      // onChanged: null,
                                      readOnly: true,
                                      controller: permissionTimeController,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Permission Time',
                                        errorText: state.permissionTime.invalid
                                            ? 'invalid permission time'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.access_time),
                                      ),
                                      onTap: () async {
                                        TimeOfDay? time = TimeOfDay.now();
                                        FocusScope.of(context).requestFocus(
                                            FocusNode());
                                        time =
                                        await showTimePicker(context: context,
                                            initialTime: TimeOfDay.now());
                                        // if (time != null){
                                        final localizations = MaterialLocalizations
                                            .of(context);
                                        final formattedTimeOfDay = localizations
                                            .formatTimeOfDay(
                                            time ?? TimeOfDay.now());
                                        permissionTimeController.text =
                                            formattedTimeOfDay;
                                        context
                                            .read<PermissionCubit>()
                                            .permissionTimeChanged(
                                            formattedTimeOfDay);
                                        // }

                                      },
                                    );
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  PermissionCubit,
                                  PermissionInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (commentValue) =>
                                          context
                                              .read<PermissionCubit>()
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
                  MaterialPageRoute(builder: (_) => const PermissionScreen())),
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
