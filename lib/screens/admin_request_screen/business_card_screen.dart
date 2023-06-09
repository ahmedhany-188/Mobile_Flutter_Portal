import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/business_card_request/business_card_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../../widgets/success/success_request_widget.dart';
import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../widgets/requester_data_widget/requested_status.dart';
import '../../widgets/requester_data_widget/requester_data_widget.dart';

class BusinessCardScreen extends StatefulWidget {

  static const routeName = "/business-account-screen";
  static const requestNoKey = 'request-No';
  static const requesterHRCode = 'request-HrCode';

  const BusinessCardScreen({Key? key, this.requestData}) : super(key: key);
  final dynamic requestData;

  @override
  State<BusinessCardScreen> createState() => _BusinessCardScreen();

}


class _BusinessCardScreen extends State<BusinessCardScreen> {

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    final user = context.select((AppBloc bloc) => bloc.state.userData);
    var formatter = GlobalConstants.dateFormatViewed;

    final currentRequestData = widget.requestData;

    return
      WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: CustomBackground(
          child: CustomTheme(
            child: BlocProvider<BusinessCardCubit>(
              create: (businessCardContext) =>
              currentRequestData [BusinessCardScreen.requestNoKey] == "0"
                  ? (BusinessCardCubit(
                  RequestRepository(user))
                ..getRequestData(
                    requestStatus: RequestStatus.newRequest, requestNo: ""))
                  : (BusinessCardCubit(RequestRepository(user))
                ..getRequestData(requestStatus: RequestStatus.oldRequest,
                    requestNo: currentRequestData[BusinessCardScreen
                        .requestNoKey],
                    requesterHRCode: currentRequestData[BusinessCardScreen
                        .requesterHRCode])),
              child: BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                  builder: (context, state) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text("Business Card ${state.requestStatus ==
                            RequestStatus.oldRequest
                            ? "#${currentRequestData[BusinessMissionScreen
                            .requestNoKey]}"
                            : "Request"}"),
                        actions: [
                          if (BusinessCardCubit.get(context).state.requestStatus ==
                              RequestStatus.oldRequest)
                            BlocBuilder<BusinessCardCubit, BusinessCardInitial>(
                              builder: (context, state) {
                                return SizedBox(
                                    width: 60,
                                    child: myRequestStatusString(state.statusAction));
                              },
                            ),
                        ],
                        centerTitle: true,
                      ),

                      floatingActionButton: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if(
                          state.requestStatus ==
                              RequestStatus.oldRequest &&
                              state.takeActionStatus ==
                                  TakeActionStatus
                                      .takeAction )FloatingActionButton
                              .extended(
                            heroTag: null,
                            onPressed: () {
                              context.read<BusinessCardCubit>()
                                  .submitAction(ActionValueStatus.accept,currentRequestData[BusinessCardScreen.requestNoKey]);
                            },
                            icon: const Icon(Icons.verified),
                            label: const Text('Accept'),
                          ),
                          const SizedBox(height: 12),
                          if(state.requestStatus ==
                              RequestStatus.oldRequest &&
                              state.takeActionStatus ==
                                  TakeActionStatus
                                      .takeAction)FloatingActionButton
                              .extended(
                            backgroundColor: Colors.white,
                            heroTag: null,
                            onPressed: () {
                              context.read<BusinessCardCubit>()
                                  .submitAction(ActionValueStatus.reject,currentRequestData[BusinessCardScreen.requestNoKey]);
                            },
                            icon: const Icon(Icons.dangerous,
                              color: ConstantsColors.buttonColors,),
                            label: const Text('Reject', style: TextStyle(
                                color: ConstantsColors.buttonColors),),
                          ),
                          const SizedBox(height: 12),
                          if(state.requestStatus == RequestStatus.newRequest)
                            FloatingActionButton.extended(
                              heroTag: null,
                              onPressed: () {
                                context.read<BusinessCardCubit>()
                                    .getSubmitBusinessCard(user);
                              },
                              // formBloc.state.status.isValidated
                              //       ? () => formBloc.submitPermis`sionRequest()
                              //       : null,
                              // formBloc.submitPermissionRequest();

                              icon: const Icon(Icons.send),
                              label: const Text('SUBMIT'),
                            ),
                          const SizedBox(height: 12),
                        ],

                      ),


                      body: BlocListener<BusinessCardCubit,
                          BusinessCardInitial>(
                        listener: (context, state) {
                          if (state.status.isSubmissionSuccess) {
                            // LoadingDialog.hide(context);
                            EasyLoading.dismiss(animation: true);
                            if (state.requestStatus == RequestStatus
                                .newRequest) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) =>
                                      SuccessScreen(
                                        text: state.successMessage ??
                                            "Error Number",
                                        routName: BusinessCardScreen.routeName,
                                        requestName: 'Business Card',)));
                            }
                            else if (state.requestStatus == RequestStatus.oldRequest){
                              EasyLoading.showSuccess(state.successMessage ?? "").then((value) {
                                if (Navigator.of(context).canPop()) {
                                  Navigator.of(context,rootNavigator: true).pop();
                                }else{
                                  SystemNavigator.pop();
                                }
                              });
                              BlocProvider.of<UserNotificationApiCubit>(context).getNotifications(user);}
                          }
                          else if (state.status.isSubmissionInProgress) {
                            EasyLoading.show(status: 'loading...',
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: false,);
                          }
                          else if (state.status.isSubmissionFailure) {
                            EasyLoading.showError(
                              state.errorMessage ??
                                  'Request Failed');
                          }
                          else if (state.status.isValid) {
                            EasyLoading.dismiss(animation: true);
                          }

                        },

                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                          child: Form(
                            child: SingleChildScrollView(
                              child: Column(

                                children: [

                                  // if(state.requestStatus ==
                                  //     RequestStatus.oldRequest)Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 8, vertical: 8),
                                  //
                                  //   child: BlocBuilder<
                                  //       BusinessCardCubit,
                                  //       BusinessCardInitial>(
                                  //
                                  //       builder: (context, state) {
                                  //         return Text(
                                  //           state.statusAction ?? "Pending",
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
                                          BusinessCardCubit,
                                          BusinessCardInitial>(
                                          buildWhen: (previous, current) {
                                            return (previous.requesterData !=
                                                current.requesterData);
                                          },
                                          builder: (context, state) {
                                            return RequesterDataWidget(
                                              requesterData: state
                                                  .requesterData,
                                              actionComment: ActionCommentWidget(
                                                  onChanged: (commentValue) =>
                                                      context
                                                          .read<
                                                          BusinessCardCubit>()
                                                          .commentRequesterChanged(
                                                          commentValue)),);
                                          }
                                      ),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(

                                      initialValue: state.requestDate.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Request Date',
                                        prefixIcon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white70,),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(
                                        8.0),
                                    child: BlocBuilder<BusinessCardCubit,
                                        BusinessCardInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state
                                              .employeeNameCard
                                              .value,

                                          readOnly: state
                                              .requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            context.read<
                                                BusinessCardCubit>()
                                                .nameCard(value);
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: 'Employee Name on Card',
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.white70,),
                                            errorText: state
                                                .employeeNameCard
                                                .invalid
                                                ? 'invalid Name'
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        8.0),
                                    child:
                                    BlocBuilder<
                                        BusinessCardCubit,
                                        BusinessCardInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state
                                              .employeeMobile
                                              .value,
                                          readOnly: state
                                              .requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            context.read<
                                                BusinessCardCubit>()
                                                .employeeMobile(value);
                                          },
                                          keyboardType: TextInputType
                                              .phone,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: 'Mobile',
                                            prefixIcon: const Icon(
                                              Icons.mobile_friendly,
                                              color: Colors.white70,),
                                            errorText: state
                                                .employeeMobile
                                                .invalid
                                                ? 'invalid Phone Number'
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        8.0),
                                    child: BlocBuilder<BusinessCardCubit,
                                        BusinessCardInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state
                                              .employeeExt,
                                          readOnly: state
                                              .requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            context.read<
                                                BusinessCardCubit>()
                                                .employeeExt(value);
                                          },
                                          keyboardType: TextInputType
                                              .number,
                                          decoration: const InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: 'Ext #',
                                            prefixIcon: Icon(
                                              Icons.phone,
                                              color: Colors.white70,),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        8.0),
                                    child: BlocBuilder<BusinessCardCubit,
                                        BusinessCardInitial>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          initialValue: state
                                              .employeeFaxNO,
                                          readOnly: state
                                              .requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            context.read<
                                                BusinessCardCubit>()
                                                .employeeFaxNO(value);
                                          },
                                          keyboardType: TextInputType
                                              .number,
                                          decoration: const InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: 'FAX NO',
                                            prefixIcon: Icon(
                                              Icons.fax,
                                              color: Colors.white70,),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        8.0),
                                    child: BlocBuilder<BusinessCardCubit,
                                        BusinessCardInitial>(
                                      builder: (context, state) {
                                        return TextFormField(

                                          initialValue: state.comment,
                                          readOnly: state
                                              .requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          onChanged: (value) =>
                                              context.read<
                                                  BusinessCardCubit>()
                                                  .employeeComment(
                                                  value),
                                          keyboardType: TextInputType
                                              .text,
                                          decoration: const InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: 'Comments',
                                            prefixIcon: Icon(
                                              Icons.comment,
                                              color: Colors.white70,),
                                          ),
                                        );
                                      },
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

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) =>
      showDialog<void>(
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

