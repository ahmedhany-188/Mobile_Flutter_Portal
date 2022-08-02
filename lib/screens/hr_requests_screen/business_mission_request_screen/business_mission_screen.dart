import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_business_mission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../bloc/hr_request_bloc/hr_request_export.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';
import '../../../widgets/success/success_request_widget.dart';

class BusinessMissionScreen extends StatefulWidget {

  static const routeName = 'business-mission-page';
  static const requestNoKey = 'request-No';
  static const requestDateAttendance = 'date-attendance';
  static const requesterHRCode = 'requester-HRCode';

  const BusinessMissionScreen({Key? key, this.requestData}) : super(key: key);

  final requestData;

@override
  State<BusinessMissionScreen> createState() => _BusinessMissionScreenState();
}

class _BusinessMissionScreenState extends State<BusinessMissionScreen> {
  @override
  Widget build(BuildContext context) {

    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);

    final currentRequestData = widget.requestData;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: BlocProvider<BusinessMissionCubit>(
        create: (businessMissionContext) =>
        currentRequestData[BusinessMissionScreen.requestNoKey] == "0"?
        (BusinessMissionCubit(RequestRepository(userMainData))..getRequestData(requestStatus:RequestStatus.newRequest, date:currentRequestData[BusinessMissionScreen.requestDateAttendance])) :
        (BusinessMissionCubit(RequestRepository(userMainData))..getRequestData(requestStatus:RequestStatus.oldRequest, requestNo:currentRequestData[BusinessMissionScreen.requestNoKey])),
        child: BlocBuilder<BusinessMissionCubit, BusinessMissionInitial>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(title: const Text('Business Mission Request')),
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(state
                        .requestStatus ==
                        RequestStatus.oldRequest && state.takeActionStatus ==
                        TakeActionStatus.takeAction)FloatingActionButton
                        .extended(
                      heroTag: null,
                      onPressed: () {},
                      icon: const Icon(Icons.verified),
                      label: const Text('Accept'),
                    ),
                    const SizedBox(height: 12),
                    if(state
                        .requestStatus ==
                        RequestStatus.oldRequest && state.takeActionStatus ==
                        TakeActionStatus.takeAction)FloatingActionButton
                        .extended(
                      backgroundColor: Colors.red,
                      heroTag: null,
                      onPressed: () {},
                      icon: const Icon(Icons.dangerous),

                      label: const Text('Reject'),
                    ),
                    const SizedBox(height: 12),
                    if(state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<BusinessMissionCubit>()
                              .submitBusinessMissionRequest();
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('SUBMIT'),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
                body: BlocListener<BusinessMissionCubit,
                    BusinessMissionInitial>(
                  listener: (context, state) {
                    if (state.status.isSubmissionInProgress) {
                      LoadingDialog.show(context);
                    }
                    if (state.status.isSubmissionSuccess) {
                      // LoadingDialog.hide(context);
                      if(state.requestStatus == RequestStatus.newRequest){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) =>
                                SuccessScreen(text: state.successMessage ??
                                    "Error Number",routName: BusinessMissionScreen.routeName, requestName: 'Vacation',)));
                      }
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
                            if(state.requestStatus ==
                                RequestStatus.oldRequest)Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BlocBuilder<
                                  BusinessMissionCubit,
                                  BusinessMissionInitial>(

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
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    permissionType!) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 2,
                                            title: Text("Site Visit"),
                                            groupValue: state.missionType,
                                            onChanged: (missionType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType!) : null,
                                          ),
                                          RadioListTile<int>(
                                            value: 3,
                                            title: Text("Training"),
                                            groupValue: state.missionType,
                                            onChanged: (missionType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType!):null,
                                          ),
                                          RadioListTile<int>(
                                            value: 4,
                                            title: const Text("Others"),
                                            groupValue: state.missionType,
                                            onChanged: (missionType) =>
                                            state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<
                                                    BusinessMissionCubit>()
                                                    .missionTypeChanged(
                                                    missionType!):null,
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
                                    return (previous.dateFrom !=
                                        current.dateFrom) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    print(state.dateFrom.value);
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.dateFrom.value,
                                      onChanged: (vacationDate) =>
                                          context
                                              .read<BusinessMissionCubit>()
                                              .businessDateFromChanged(
                                              context),
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Mission From Date',
                                        errorText: state.dateFrom
                                            .invalid
                                            ? 'invalid date from'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),
                                      onTap: () {
                                        context
                                            .read<BusinessMissionCubit>()
                                            .businessDateFromChanged(
                                            context);
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
                                // buildWhen: (previous, current) => previous.permissionDate != current.permissionDate,
                                  buildWhen: (previous, current) {
                                    return (previous.dateTo !=
                                        current.dateTo) ||
                                        previous.status != current.status ||
                                        previous.dateFrom !=
                                            current.dateFrom;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.dateTo.value,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Mission To Date',
                                        errorText: state.dateTo.invalid ? (state
                                            .dateTo.error == DateToError.empty
                                            ? "Empty Date To or Date From"
                                            : (state.dateTo.error ==
                                            DateToError.isBefore)
                                            ? "Date From must be before Date To"
                                            : null) : null,
                                        prefixIcon: const Icon(
                                            Icons.date_range_outlined),
                                      ),
                                      onTap: () {
                                        context
                                            .read<BusinessMissionCubit>()
                                            .businessToDateChanged(
                                            context);
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
                                  previous.timeFrom !=
                                      current.timeFrom,
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.timeFrom.value,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Time From',
                                        errorText: state.timeFrom.invalid
                                            ? 'invalid permission time'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.access_time),
                                      ),
                                      onTap: () async {
                                        // if (!widget.objectValidation) {
                                        context
                                            .read<BusinessMissionCubit>()
                                            .businessTimeFromChanged(
                                            context);
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
                                  buildWhen: (previous, current) =>
                                  previous.timeTo !=
                                      current.timeTo,
                                  builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.timeTo.value,
                                      readOnly: true,
                                      enabled: state.requestStatus == RequestStatus.newRequest ? true : false,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Time To',
                                        errorText: state.timeTo.invalid
                                            ? 'invalid time'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.access_time),
                                      ),
                                      onTap: () async {
                                        // if (!widget.objectValidation) {
                                        context
                                            .read<BusinessMissionCubit>()
                                            .businessTimeToChanged(
                                            context);
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
                                      key: state.requestStatus ==
                                          RequestStatus.oldRequest
                                          ? UniqueKey()
                                          : null,
                                      initialValue: state.requestStatus ==
                                          RequestStatus.oldRequest ? state
                                          .comment : "",
                                      enabled: state.requestStatus ==
                                          RequestStatus.newRequest
                                          ? true
                                          : false,
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

