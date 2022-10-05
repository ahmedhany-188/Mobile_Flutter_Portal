import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../../bloc/hr_request_bloc/permission_request/permission_cubit.dart';
import '../../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../../constants/enums.dart';
import '../../../data/repositories/request_repository.dart';
import '../../../widgets/requester_data_widget/requested_status.dart';
import '../../../widgets/requester_data_widget/requester_data_widget.dart';
import '../../../widgets/success/success_request_widget.dart';

class PermissionScreen extends StatefulWidget {


  static const requestNoKey = 'request-No';
  static const requestDateAttendance = 'date-Attendance';
  static const routeName = 'permission-page';
  static const requesterHRCode = 'requester-HRCode';

  const PermissionScreen({Key? key,this.requestData}) : super(key: key);

  final dynamic requestData;


  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

  @override
  Widget build(BuildContext context) {
    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);
    final currentRequestData = widget.requestData;
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
        child: CustomTheme(
          child: BlocProvider<PermissionCubit>(
            create: (permissionContext) =>
            currentRequestData[PermissionScreen.requestNoKey] == "0" ?
            (PermissionCubit(RequestRepository(userMainData))
              ..getRequestData(requestStatus: RequestStatus.newRequest,
                  date: currentRequestData[PermissionScreen
                      .requestDateAttendance])) :
            (PermissionCubit(RequestRepository(userMainData))
              ..getRequestData(requestStatus: RequestStatus.oldRequest,
                  requestNo: currentRequestData[PermissionScreen.requestNoKey],
                  requesterHRCode: currentRequestData[PermissionScreen
                      .requesterHRCode])),
            child: BlocBuilder<PermissionCubit, PermissionInitial>(
                builder: (context, state) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(title: Text("Permission ${state.requestStatus ==
                      RequestStatus.oldRequest
                      ? "#${currentRequestData[PermissionScreen.requestNoKey]}"
                          : ""}"),
                      actions: [
                        if (PermissionCubit.get(context).state.requestStatus ==
                            RequestStatus.oldRequest)
                          BlocBuilder<PermissionCubit, PermissionInitial>(
                            builder: (context, state) {
                              return SizedBox(
                                  width: 60,
                                  child:
                                  myRequestStatusString(state.statusAction));
                            },
                          ),
                      ],
                      backgroundColor: Colors.transparent,
                      elevation: 0,),
                    floatingActionButton: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if(state
                            .requestStatus ==
                            RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<PermissionCubit>()
                                .submitAction(ActionValueStatus.accept,currentRequestData[PermissionScreen.requestNoKey]);

                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Accept'),
                        ),
                        const SizedBox(height: 12),
                        if(state
                            .requestStatus ==
                            RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          backgroundColor: Colors.white,
                          heroTag: null,
                          onPressed: () {
                            context.read<PermissionCubit>()
                                .submitAction(ActionValueStatus.reject,currentRequestData[PermissionScreen.requestNoKey]);

                          },
                          icon: const Icon(Icons.dangerous,color: ConstantsColors.buttonColors,),
                          label: const Text('Reject',style: TextStyle(color: ConstantsColors.buttonColors),),
                        ),
                        const SizedBox(height: 12),
                        if(state
                            .requestStatus == RequestStatus.newRequest)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              context.read<PermissionCubit>()
                                  .submitPermissionRequest();
                            },
                            icon: const Icon(Icons.send),
                            label: const Text('SUBMIT'),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    body: BlocListener<PermissionCubit, PermissionInitial>(
                      listener: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          EasyLoading.show(status: 'Loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,);
                          // LoadingDialog.show(context);
                        }
                        if (state.status.isSubmissionSuccess) {
                          EasyLoading.dismiss(animation: true);
                          if (state.requestStatus == RequestStatus.newRequest) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) =>
                                    SuccessScreen(text: state.successMessage ??
                                        "Error Number",
                                      routName: PermissionScreen.routeName,
                                      requestName: 'Permission',)));
                          }
                          else if (state.requestStatus == RequestStatus.oldRequest){
                            EasyLoading.showSuccess(state.successMessage ?? "").then((value) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context,rootNavigator: true).pop();
                              }else{
                                SystemNavigator.pop();
                              }
                            });
                            BlocProvider.of<UserNotificationApiCubit>(context).getNotifications(userMainData);
                          }
                        }
                        if (state.status.isSubmissionFailure) {
                          EasyLoading.showError(state.errorMessage ??
                              'Request Failed');
                          // LoadingDialog.hide(context);
                          // ScaffoldMessenger.of(context)
                          //   ..hideCurrentSnackBar()
                          //   ..showSnackBar(
                          //     SnackBar(
                          //       content: Text(
                          //           state.errorMessage ?? 'Request Failed'),
                          //     ),
                          //   );
                        }
                        if (state.status.isValid) {
                          EasyLoading.dismiss(animation: true);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                // if(state.requestStatus ==
                                //     RequestStatus.oldRequest)Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8, vertical: 8),
                                //   child: BlocBuilder<
                                //       PermissionCubit,
                                //       PermissionInitial>(
                                //
                                //       builder: (context, state) {
                                //         return Text(
                                //           state.statusAction ?? "Pending",
                                //           // style: TextStyle(decoration: BoxDecoration(
                                //           //   // labelText: 'Request Date',
                                //           //   errorText: state.requestDate.invalid
                                //           //       ? 'invalid request date'
                                //           //       : null,
                                //           //   prefixIcon: const Icon(
                                //           //       Icons.date_range),
                                //           // ),),
                                //
                                //         );
                                //       }
                                //   ),
                                // ),

                                if(state.requestStatus ==
                                    RequestStatus.oldRequest &&
                                    state.takeActionStatus ==
                                        TakeActionStatus.takeAction)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: BlocBuilder<
                                        PermissionCubit,
                                        PermissionInitial>(
                                        buildWhen: (previous, current) {
                                          return (previous.requesterData !=
                                              current.requesterData);
                                        },
                                        builder: (context, state) {
                                          return RequesterDataWidget(
                                            requesterData: state.requesterData,
                                            actionComment: ActionCommentWidget(
                                                onChanged: (commentValue) =>
                                                    context
                                                        .read<PermissionCubit>()
                                                        .commentRequesterChanged(
                                                        commentValue)),);
                                        }
                                    ),
                                  ),

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
                                  child: BlocBuilder<
                                      PermissionCubit,
                                      PermissionInitial>(
                                      buildWhen: (previous, current) {
                                        return (previous.permissionDate !=
                                            current.permissionDate) ||
                                            previous.status != current.status;
                                      },
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: UniqueKey(),
                                          initialValue: state.permissionDate
                                              .value,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Permission Date',
                                            errorText: state.permissionDate
                                                .invalid
                                                ? 'invalid permission date'
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.date_range_outlined,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () async {
                                            context.read<PermissionCubit>()
                                                .permissionDateChanged(context);
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
                                      prefixIcon: Icon(
                                        Icons.event, color: Colors.white70,),
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
                                                activeColor: Colors.white,
                                                value: 0,
                                                title: const Text("2 hours"),
                                                groupValue: state
                                                    .permissionType,
                                                onChanged: (permissionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<PermissionCubit>()
                                                    .permissionTypeChanged(
                                                    permissionType??0)
                                                    : null,
                                              ),
                                              RadioListTile<int>(
                                                activeColor: Colors.white,
                                                value: 1,
                                                // dense: true,
                                                title: const Text("4 hours"),
                                                groupValue: state
                                                    .permissionType,
                                                // selected: (widget.permissionFormModelData.type== 2)
                                                //     ? true : false,
                                                // radioClickState: (mstate) => mstate.value),
                                                onChanged: (permissionType) =>
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<PermissionCubit>()
                                                    .permissionTypeChanged(
                                                    permissionType??0)
                                                    : null,
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
                                          initialValue: state.permissionTime
                                              .value,
                                          key: UniqueKey(),
                                          readOnly: true,
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Permission Time',
                                            errorText: state.permissionTime
                                                .invalid
                                                ? 'invalid permission time'
                                                : null,
                                            prefixIcon: const Icon(
                                              Icons.access_time,
                                              color: Colors.white70,),
                                          ),
                                          onTap: () async {
                                            context
                                                .read<PermissionCubit>()
                                                .permissionTimeChanged(
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
                                      PermissionCubit,
                                      PermissionInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          // controller: commentController,
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
                                                  .read<PermissionCubit>()
                                                  .commentChanged(commentValue),
                                          keyboardType: TextInputType.multiline,
                                          // enabled: (widget.objectValidation) ? false : true,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  20.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[800]),
                                            labelText: "Add your comment",
                                            // fillColor: Colors.white70,
                                            prefixIcon: const Icon(
                                              Icons.comment,
                                              color: Colors.white70,),
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
        ),
      ),
    );
  }

}




