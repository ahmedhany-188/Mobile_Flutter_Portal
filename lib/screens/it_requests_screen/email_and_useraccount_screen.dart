import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../../widgets/success/success_request_widget.dart';
import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../widgets/requester_data_widget/requested_status.dart';
import '../../widgets/requester_data_widget/requester_data_widget.dart';

class EmailAndUserAccountScreen  extends StatefulWidget{

  static const routeName = "/email-user-account-screen";
  static const requestNoKey = 'request-No';
  static const requesterHRCode = 'request-HrCode';

  const EmailAndUserAccountScreen({Key? key,this.requestData}) : super(key: key);

  final dynamic requestData;

  @override
  State<EmailAndUserAccountScreen> createState() => _EmailAndUserAccountScreen();

}

class _EmailAndUserAccountScreen extends State<EmailAndUserAccountScreen> {

  var mobileKeyClear = true;
  String hrCodeEmail = "";

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    final currentRequestData = widget.requestData;

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },

      child: CustomBackground(
        child: CustomTheme(
          child: BlocProvider<EmailUserAccountCubit>(
            create: (emailUserContext) =>
            currentRequestData [EmailAndUserAccountScreen.requestNoKey] == "0"
                ? (EmailUserAccountCubit(
                RequestRepository(user))
              ..getRequestData(requestStatus: RequestStatus.newRequest, requestNo: ""))
                : (EmailUserAccountCubit(RequestRepository(user))
              ..getRequestData(requestStatus: RequestStatus.oldRequest,
                  requestNo: currentRequestData[EmailAndUserAccountScreen.requestNoKey],
                  requesterHRCode: currentRequestData[EmailAndUserAccountScreen
                      .requesterHRCode])),

            child: BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
                builder: (context, state) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title:  Text("Email Account ${state.requestStatus ==
                          RequestStatus.oldRequest
                          ? "#${currentRequestData[EmailAndUserAccountScreen
                          .requestNoKey]}"
                          : "Request"}"),
                      actions: [
                        if (EmailUserAccountCubit.get(context).state.requestStatus ==
                            RequestStatus.oldRequest)
                          BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
                            builder: (context, state) {
                              return SizedBox(
                                  width: 60,
                                  child: myRequestStatusString(state.statusAction));
                            },
                          ),
                      ],
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    floatingActionButton: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if(
                        state.requestStatus ==
                            RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus
                                    .takeAction)FloatingActionButton
                            .extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<EmailUserAccountCubit>()
                                .submitAction(ActionValueStatus.accept,currentRequestData[EmailAndUserAccountScreen.requestNoKey]);
                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Accept'),
                        ),
                        const SizedBox(height: 12),
                        if(state.requestStatus ==
                            RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          backgroundColor: Colors.white,
                          heroTag: null,
                          onPressed: () {
                            context.read<EmailUserAccountCubit>()
                                .submitAction(ActionValueStatus.reject,currentRequestData[EmailAndUserAccountScreen.requestNoKey]);
                          },
                          icon: const Icon(Icons.dangerous,color: ConstantsColors.buttonColors,),
                          label: const Text('Reject',style: TextStyle(color: ConstantsColors.buttonColors),),
                        ),
                        const SizedBox(height: 12),
                        if(context
                            .read<EmailUserAccountCubit>()
                            .state
                            .requestStatus == RequestStatus.newRequest)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              // TODO validation from cubit ! ya ahmed hany :D
                              if (user.employeeData?.userHrCode ==
                                  state.hrCodeUser.value) {
                                EasyLoading.showError("Invalid same hr code",);
                              }
                              else if (state.hrcodeUpdated) {
                                EasyLoading.showError("User data not submitted");
                              }
                              else {
                                // if (user.employeeData!.userHrCode !=
                                //   state.hrCodeUser.value) {
                                context.read<EmailUserAccountCubit>()
                                    .submitEmailAccount();
                              // }
                              // else {
                              //   EasyLoading.showError("error",);
                              }
                            },
                            icon: const Icon(Icons.send),
                            label: const Text('SUBMIT'),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),

                    body: BlocListener<
                        EmailUserAccountCubit,
                        EmailUserAccountInitial>(
                      listener: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          EasyLoading.show(status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,);
                        }
                        if (state.status.isSubmissionSuccess) {
                          // LoadingDialog.hide(context);
                          EasyLoading.dismiss(animation: true);
                          if (state.requestStatus == RequestStatus.newRequest) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) =>
                                    SuccessScreen(text: state.successMessage ??
                                        "Error Number",
                                      routName: EmailAndUserAccountScreen
                                          .routeName,
                                      requestName: 'User Account',)));
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
                        if(state.mobileKey){
                          mobileKeyClear=true;
                          if (kDebugMode) {
                            print("here33");
                          }
                        }else{
                          mobileKeyClear=false;
                          if (kDebugMode) {
                            print("here44");
                          }
                        }
                        if (state.status.isSubmissionFailure) {
                          EasyLoading.showError(state.errorMessage.toString(),);
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

                              children: [
                                // if(state.requestStatus ==
                                //     RequestStatus.oldRequest)Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8, vertical: 8),
                                //
                                //   child: BlocBuilder<
                                //       EmailUserAccountCubit,
                                //       EmailUserAccountInitial>(
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
                                        EmailUserAccountCubit,
                                        EmailUserAccountInitial>(
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
                                                        .read<
                                                        EmailUserAccountCubit>()
                                                        .commentRequesterChanged(
                                                        commentValue)),);
                                        }
                                    ),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<
                                      EmailUserAccountCubit,
                                      EmailUserAccountInitial>(
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
                                  padding: const EdgeInsets.all(8.0),

                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 5),
                                      labelText: 'Request Type',
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      prefixIcon: Icon(
                                        Icons.event, color: Colors.white70,),
                                    ),
                                    child: BlocBuilder<EmailUserAccountCubit,
                                        EmailUserAccountInitial>(
                                        buildWhen: (previous, current) {
                                          return (previous.requestType !=
                                              current.requestType);
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
                                                activeColor: Colors.white,
                                                title: const Text("Create"),
                                                groupValue: state.requestType,
                                                onChanged: (permissionType) =>
                                                {

                                                  state.requestStatus ==
                                                      RequestStatus.newRequest
                                                      ? context
                                                      .read<
                                                      EmailUserAccountCubit>()
                                                      .accessRightChanged(
                                                      permissionType ?? 1)
                                                      : null,
                                                },
                                                // selected: (widget.emailUserAccount
                                                //     .requestType == 1) ? true : false,
                                              ),
                                              RadioListTile<int>(
                                                value: 2,
                                                activeColor: Colors.white,
                                                title: const Text("Disable"),
                                                groupValue: state.requestType,
                                                onChanged: (permissionType) =>
                                                {
                                                  state.requestStatus ==
                                                      RequestStatus.newRequest
                                                      ? context
                                                      .read<
                                                      EmailUserAccountCubit>()
                                                      .accessRightChanged(
                                                      permissionType ?? 2)
                                                      : null,
                                                },
                                                // selected: (widget.emailUserAccount
                                                //     .requestType == 2) ? true : false,
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<
                                      EmailUserAccountCubit,
                                      EmailUserAccountInitial>(
                                      buildWhen: (previous, current) {
                                        return (previous.requestDate !=
                                            current.requestDate) ||
                                            previous.status != current.status;
                                      },
                                      builder: (context, state) {
                                        return TextFormField(
                                          initialValue: state.hrCodeUser.value,
                                          onChanged: (hrCode) =>
                                          {
                                            if(state.mobileKey==false){
                                              context.read<
                                                  EmailUserAccountCubit>()
                                                  .clearMobileField(),
                                            },
                                            context.read<
                                                EmailUserAccountCubit>()
                                                .clearStateHRCode(),
                                            hrCodeEmail = hrCode.toString()
                                          },
                                          onFieldSubmitted: (value) {
                                            hrCodeEmail = value.toString();
                                            context.read<
                                                EmailUserAccountCubit>()
                                                .hrCodeSubmittedGetData(
                                                hrCodeEmail);
                                          },
                                          keyboardType: TextInputType.phone,
                                          readOnly: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            errorText: state.hrCodeUser.invalid
                                                ? 'invalid Hr Code '
                                                : null,
                                            floatingLabelAlignment: FloatingLabelAlignment
                                                .start,

                                            prefixIcon: const Icon(
                                              Icons.search,
                                              color: Colors.white70,),
                                            suffixIcon: state.requestStatus ==
                                                RequestStatus.newRequest ?IconButton(
                                              icon: Icon(Icons.done,color: Colors.white70,),
                                              onPressed: () {
                                                context.read<EmailUserAccountCubit>().hrCodeSubmittedGetData(hrCodeEmail);
                                              },):null,
                                            labelText: 'Search hr Code',
                                          ),
                                        );
                                      }
                                  ),
                                ),


                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        labelText: '   Requested To',
                                        // floatingLabelAlignment:
                                        // FloatingLabelAlignment.start,
                                        // prefixIcon: Icon(Icons.usb),
                                      ),
                                      child: Column(children: [

                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: BlocBuilder<
                                                EmailUserAccountCubit,
                                                EmailUserAccountInitial>(
                                              buildWhen: (previous, current) {
                                                return (state.requestStatus ==
                                                    RequestStatus.newRequest);
                                              },
                                              builder: (context, state) {
                                                return TextFormField(
                                                  initialValue: state.fullName.toTitleCase(),

                                                  key: UniqueKey(),
                                                  // state.requestStatus ==
                                                  //     RequestStatus.oldRequest
                                                  //     ? true: false,
                                                  readOnly: true,
                                                  decoration: const InputDecoration(
                                                    floatingLabelAlignment:
                                                    FloatingLabelAlignment
                                                        .start,
                                                    labelText: 'Full Name',
                                                    prefixIcon: Icon(
                                                      Icons.person,
                                                      color: Colors.white70,),
                                                  ),
                                                );
                                              },)
                                        ),


                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            BlocBuilder<EmailUserAccountCubit,
                                                EmailUserAccountInitial>(
                                              buildWhen: (previous, current) {
                                                return (state.requestStatus ==
                                                    RequestStatus.newRequest);
                                              },
                                              builder: (context, state) {
                                                return TextFormField(
                                                  initialValue: state.userTitle,
                                                  key: UniqueKey(),
                                                  // state.requestStatus ==
                                                  //     RequestStatus.oldRequest
                                                  //     ? true: false,
                                                  readOnly: true,
                                                  decoration: const InputDecoration(
                                                    floatingLabelAlignment:
                                                    FloatingLabelAlignment
                                                        .start,
                                                    labelText: 'Title',
                                                    prefixIcon: Icon(
                                                      Icons.desk_outlined,
                                                      color: Colors.white70,),
                                                  ),
                                                );
                                              },)

                                        ),


                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: BlocBuilder<
                                                EmailUserAccountCubit,
                                                EmailUserAccountInitial>(
                                                buildWhen: (previous, current) {
                                                  return (state.requestStatus ==
                                                      RequestStatus.newRequest);
                                                },
                                                builder: (context, state) {
                                                  return TextFormField(
                                                    initialValue: state
                                                        .userLocation,
                                                    key: UniqueKey(),
                                                    // state.requestStatus ==
                                                    //     RequestStatus.oldRequest
                                                    //     ? true: false,
                                                    readOnly: true,
                                                    decoration: const InputDecoration(
                                                      floatingLabelAlignment:
                                                      FloatingLabelAlignment
                                                          .start,
                                                      labelText: 'Location',
                                                      prefixIcon: Icon(
                                                        Icons.business_center,
                                                        color: Colors.white70,),
                                                    ),
                                                  );
                                                })
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BlocBuilder<
                                              EmailUserAccountCubit,
                                              EmailUserAccountInitial>(
                                            buildWhen: (previous, current) {
                                              // return (previous.requestDate !=
                                              //     current.requestDate) ||
                                              //     previous.status != current.status;
                                              return (state.requestStatus == RequestStatus.newRequest) ;
                                            },
                                            builder: (context, state) {
                                              return TextFormField(
                                                key: mobileKeyClear
                                                    ? null :  UniqueKey(),
                                                initialValue: state.userMobile
                                                    .value,
                                                onChanged: (phoneValue) =>
                                                {
                                                  if(state.mobileKey==false){
                                                context.read<
                                                EmailUserAccountCubit>()
                                                    .clearMobileField(),
                                                },
                                                  context.read<
                                                      EmailUserAccountCubit>()
                                                      .phoneNumberChanged(
                                                      phoneValue.toString()),
                                                },
                                                keyboardType: TextInputType
                                                    .phone,
                                                readOnly: state.requestStatus ==
                                                    RequestStatus.oldRequest
                                                    ? true
                                                    : false,
                                                decoration: InputDecoration(
                                                  floatingLabelAlignment:
                                                  FloatingLabelAlignment.start,
                                                  labelText: 'Mobile',
                                                  prefixIcon: const Icon(
                                                    Icons.mobile_friendly,
                                                    color: Colors.white70,),
                                                  errorText: state.userMobile
                                                      .invalid
                                                      ? 'invalid Phone Number'
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ]),
                                    )

                                ),


                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0,
                                      left: 8.0,
                                      top: 8.0,
                                      bottom: 80.0),
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 5),
                                      labelText: 'Email Type ',
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      prefixIcon: Icon(
                                        Icons.event, color: Colors.white70,),
                                    ),
                                    child: BlocBuilder<
                                        EmailUserAccountCubit,
                                        EmailUserAccountInitial>(
                                      builder: (context, state) {
                                        return Row(children: [
                                          const Text('Email Account'),
                                          Checkbox(
                                            // activeColor: Colors.white,
                                            value: state.accountType,
                                            onChanged: (bool? value) {
                                              state.requestStatus ==
                                                  RequestStatus.newRequest ?
                                              context.read<
                                                  EmailUserAccountCubit>()
                                                  .getEmailValue(value??false)
                                                  : null;
                                            },
                                          )
                                        ],); //Check
                                      },),
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



