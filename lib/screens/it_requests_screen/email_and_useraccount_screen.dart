import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';


class EmailAndUserAccountScreen  extends StatefulWidget{

  static const routeName = "/email-user-account-screen";
  static const requestNoKey = 'request-No';

  const EmailAndUserAccountScreen({Key? key,this.requestNo }) : super(key: key);


  final requestNo;
  @override
  State<EmailAndUserAccountScreen> createState() => _EmailAndUserAccountScreen();

}

class _EmailAndUserAccountScreen extends State<EmailAndUserAccountScreen> {


  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);


    final currentRequestNo = widget.requestNo;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmailUserAccountCubit>(create: (emailUserContext) =>
          currentRequestNo == null ? (EmailUserAccountCubit(
              RequestRepository(user))
            ..getRequestData(RequestStatus.newRequest, ""))
              : (EmailUserAccountCubit(RequestRepository(user))
            ..getRequestData(RequestStatus.oldRequest,
                currentRequestNo[EmailAndUserAccountScreen.requestNoKey]))),
          // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])),
          // BlocProvider<ResponsibleVacationCubit>(
          //     lazy: false,
          //     create: (_) =>
          //     ResponsibleVacationCubit()
          //       ..fetchList()),
        ],


          child: BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("User Account"),
                    centerTitle: true,
                  ),
                  resizeToAvoidBottomInset: false,

                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      if(
                      state
                          .requestStatus ==
                          RequestStatus.oldRequest && state.takeActionStatus ==
                          TakeActionStatus.takeAction )FloatingActionButton
                          .extended(
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.verified),
                        label: const Text('Accept'),
                      ),
                      const SizedBox(height: 12),
                      if(state.requestStatus ==
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
                      if(context
                          .read<EmailUserAccountCubit>()
                          .state
                          .requestStatus == RequestStatus.newRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<EmailUserAccountCubit>()
                                .submitEmailAccount(user);
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

                  body: BlocListener<
                      EmailUserAccountCubit,
                      EmailUserAccountInitial>(
                    listener: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        LoadingDialog.show(context);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) =>
                                SuccessScreen(text: state.successMessage ??
                                    "Error Number",)));
                      } else if (state.status.isSubmissionInProgress) {
                        LoadingDialog.show(context);
                      }
                      else if (state.status.isSubmissionFailure) {
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

                            children: [
                              if(state.requestStatus ==
                                  RequestStatus.oldRequest)Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<
                                    EmailUserAccountCubit,
                                    EmailUserAccountInitial>(

                                    builder: (context, state) {
                                      return Text(
                                        state.statusAction ?? "Pending",
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
                                    prefixIcon: Icon(Icons.event),
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
                                              title: const Text("Create"),
                                              groupValue: state.requestType,
                                              onChanged: (permissionType) =>
                                              {

                                                state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<EmailUserAccountCubit>()
                                                    .accessRightChanged(
                                                    permissionType ?? 1) : null,
                                              },
                                              // selected: (widget.emailUserAccount
                                              //     .requestType == 1) ? true : false,
                                            ),
                                            RadioListTile<int>(
                                              value: 2,
                                              title: const Text("Disable"),
                                              groupValue: state.requestType,
                                              onChanged: (permissionType) =>
                                              {
                                                state.requestStatus == RequestStatus.newRequest ? context
                                                    .read<EmailUserAccountCubit>()
                                                    .accessRightChanged(
                                                    permissionType ?? 2) : null,
                                              },
                                              // selected: (widget.emailUserAccount
                                              //     .requestType == 2) ? true : false,
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                ),),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: user.user!.userHRCode,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    prefixIcon: Icon(
                                        Icons.qr_code),
                                    labelText: 'Hr Code',
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: user.employeeData!.name,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    labelText: 'Full Name',
                                    prefixIcon: Icon(
                                        Icons.person),
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: user.employeeData!.titleName,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    labelText: 'Title',
                                    prefixIcon: Icon(
                                        Icons.desk_outlined),
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: user.employeeData!.companyName,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    labelText: 'Location',
                                    prefixIcon: Icon(
                                        Icons.business_center),
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
                                      initialValue: state.userMobile.value,

                                      onChanged: (phoneValue) =>
                                      {
                                        context.read<EmailUserAccountCubit>()
                                            .phoneNumberChanged(phoneValue),
                                      },

                                      keyboardType: TextInputType.phone,

                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Mobile',
                                        prefixIcon: const Icon(
                                            Icons.mobile_friendly),
                                        errorText: state.userMobile.invalid
                                            ? 'invalid Phone Number'
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    labelText: 'Account Type',
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    prefixIcon: Icon(Icons.event),
                                  ),
                                  child: BlocBuilder<
                                      EmailUserAccountCubit,
                                      EmailUserAccountInitial>(
                                    builder: (context, state) {
                                      return Card(
                                        child: Row(
                                          children: <Widget>[
                                            const SizedBox(width: 10),
                                            const Text(
                                              'Email Account ',
                                              style: TextStyle(fontSize: 17.0),
                                            ),
                                            //Text
                                            const SizedBox(width: 10),
                                            //SizedBox
                                            /** Checkbox Widget **/
                                            Checkbox(
                                              value: state.accountType,
                                              onChanged: (bool? value) {
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ?
                                                context.read<
                                                    EmailUserAccountCubit>()
                                                    .getEmailValue(value!)
                                                    : null;
                                              },
                                            ),
                                            //Checkbox
                                          ], //<Widget>[]
                                        ),
                                      );
                                    },),
                                ),
                              ),


                              // FloatingActionButton.extended(
                              //   onPressed: () {
                              //     context.read<EmailUserAccountCubit>()
                              //         .getSubmitEmailAndUserAccount(
                              //       user, formattedDate,);
                              //   },
                              //   label: const Text('Submit', style: TextStyle(
                              //       color: Colors.black
                              //   )),
                              //   icon: const Icon(
                              //       Icons.thumb_up_alt_outlined,
                              //       color: Colors.black),
                              //   backgroundColor: Colors.white,),


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
                  MaterialPageRoute(builder: (_) => const EmailAndUserAccountScreen())),
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
