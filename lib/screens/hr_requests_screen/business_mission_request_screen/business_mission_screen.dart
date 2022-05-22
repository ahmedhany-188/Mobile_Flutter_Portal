import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../bloc/hr_request_bloc/business_mission_request/business_mission_cubit.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';

class BusinessMissionScreen extends StatefulWidget {
  static const routeName = 'business-mission-page';

  const BusinessMissionScreen({Key? key}) : super(key: key);

  @override
  State<BusinessMissionScreen> createState() => _BusinessMissionScreenState();
}

class _BusinessMissionScreenState extends State<BusinessMissionScreen> {
  @override
  Widget build(BuildContext context) {
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
      child: BlocProvider<BusinessMissionCubit>(
        create: (permissionContext) =>
        BusinessMissionCubit(RequestRepository())
          ..getRequestData(RequestStatus.newRequest),
        child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Business Mission Request')),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(context
                        .read<BusinessMissionCubit>()
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
                        .read<BusinessMissionCubit>()
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
                        .read<BusinessMissionCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<BusinessMissionCubit>()
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
                body: BlocListener<BusinessMissionCubit, BusinessMissionInitial>(
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
                              child: BlocBuilder<BusinessMissionCubit,
                                  BusinessMissionInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.requestDate !=
                                        current.requestDate);
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
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
                                  labelText: 'Mission Location',
                                  floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                                  prefixIcon: Icon(Icons.event),
                                ),
                                child: BlocBuilder<BusinessMissionCubit,
                                    BusinessMissionInitial>(
                                    buildWhen: (previous, current) {
                                      return (previous.missionType !=
                                          current.missionType);
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
                                            title: Text("Meeting"),
                                            groupValue: state.missionType,
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    permissionType!),
                                          ),
                                          RadioListTile<int>(
                                            value: 2,
                                            // dense: true,
                                            title: Text("Site Visit"),
                                            groupValue: state.missionType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    permissionType!),
                                          ),
                                          RadioListTile<int>(
                                            value: 3,
                                            // dense: true,
                                            title: Text("Training"),
                                            groupValue: state.missionType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    permissionType!),
                                          ),
                                          RadioListTile<int>(
                                            value: 4,
                                            // dense: true,
                                            title: Text("Others"),
                                            groupValue: state.missionType,
                                            // radioClickState: (mstate) => mstate.value),
                                            onChanged: (permissionType) =>
                                                context
                                                    .read<BusinessMissionCubit>()
                                                    .missionTypeChanged(
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
                                  BusinessMissionCubit,
                                  BusinessMissionInitial>(
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
                                              .read<BusinessMissionCubit>()
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
                                            .read<BusinessMissionCubit>()
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
                              child: BlocBuilder<
                                  BusinessMissionCubit,
                                  BusinessMissionInitial>(
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
                                            .read<BusinessMissionCubit>()
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
                                  BusinessMissionCubit,
                                  BusinessMissionInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      onChanged: (commentValue) =>
                                          context
                                              .read<BusinessMissionCubit>()
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
                  MaterialPageRoute(builder: (_) => const BusinessMissionScreen())),
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
