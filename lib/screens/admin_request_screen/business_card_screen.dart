import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/business_card_request/business_card_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';

class BusinessCardScreen extends StatefulWidget{

  static const routeName = "/business-account-screen";
  static const requestNoKey = 'request-No';
  const BusinessCardScreen({Key? key,this.requestNo}) : super(key: key);
  final requestNo;

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
    String formattedDate = formatter.format(DateTime.now());

    final currentRequestNo = widget.requestNo;


    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      child:
      BlocProvider<BusinessCardCubit>(
        create: (businessCardContext) =>
        currentRequestNo == null ? (BusinessCardCubit(RequestRepository(user))
          ..getRequestData(RequestStatus.newRequest, ""))
            : (BusinessCardCubit(RequestRepository(user))
          ..getRequestData(RequestStatus.oldRequest,
              currentRequestNo[BusinessCardScreen.requestNoKey])),
        // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])

        child: BlocBuilder<BusinessCardCubit, BusinessCardInitial>(

            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Business Card"),
                  centerTitle: true,
                ),
                resizeToAvoidBottomInset: false,

                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    if(
                    state.requestStatus ==
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
                        .read<BusinessCardCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
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


                body: BlocListener<BusinessCardCubit, BusinessCardInitial>(
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

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: formattedDate,
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
                              child: BlocBuilder<
                                  BusinessCardCubit,
                                  BusinessCardInitial>(
                                builder: (context, state) {
                                  return TextFormField(

                                    // enabled: (widget.objectValidation)
                                    //     ? false
                                    //     : true,

                                    onChanged: (value) =>
                                        context.read<BusinessCardCubit>()
                                            .nameCard(value),
                                    // initialValue: state.userMobile.value,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      labelText: 'Employee Name on Card',
                                      prefixIcon: const Icon(
                                          Icons.person),
                                      errorText: state.employeeNameCard.invalid
                                          ? 'invalid Name'
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<
                                  BusinessCardCubit,
                                  BusinessCardInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    // enabled: (widget.objectValidation)
                                    //     ? false
                                    //     : true,


                                    onChanged: (value) =>
                                        context.read<BusinessCardCubit>()
                                            .employeeMobile(value),
                                    // initialValue: state.userMobile.value,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      labelText: 'Mobile',
                                      prefixIcon: const Icon(
                                          Icons.mobile_friendly),
                                      errorText: state.employeeMobile.invalid
                                          ? 'invalid Phone Number'
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<
                                  BusinessCardCubit,
                                  BusinessCardInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    // enabled: (widget.objectValidation)
                                    //     ? false
                                    //     : true,


                                    onChanged: (value) =>
                                        context.read<BusinessCardCubit>()
                                            .employeeExt(value),
                                    // initialValue: state.userMobile.value,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      labelText: 'Ext #',
                                      prefixIcon: Icon(
                                          Icons.phone),
                                    ),
                                  );
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<
                                  BusinessCardCubit,
                                  BusinessCardInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    // enabled: (widget.objectValidation)
                                    //     ? false
                                    //     : true,


                                    onChanged: (value) =>
                                        context.read<BusinessCardCubit>()
                                            .employeeFaxNO(value),
                                    // initialValue: state.userMobile.value,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      labelText: 'FAX NO',
                                      prefixIcon: Icon(
                                          Icons.fax),
                                    ),
                                  );
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<
                                  BusinessCardCubit,
                                  BusinessCardInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    // enabled: (widget.objectValidation)
                                    //     ? false
                                    //     : true,


                                    onChanged: (value) =>
                                        context.read<BusinessCardCubit>()
                                            .EemployeeComment(value),
                                    // initialValue: state.userMobile.value,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                      labelText: 'Comments',
                                      prefixIcon: Icon(
                                          Icons.comment),
                                    ),
                                  );
                                },
                              ),
                            ),


                            // FloatingActionButton.extended(
                            //   onPressed: () {
                            //     context.read<BusinessCardCubit>()
                            //         .getSubmitBusinessCard(
                            //       user,);
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
                  MaterialPageRoute(builder: (_) => const BusinessCardScreen())),
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