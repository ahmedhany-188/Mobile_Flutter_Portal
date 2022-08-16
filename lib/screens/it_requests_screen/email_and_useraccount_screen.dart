import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/email_useracount_request/email_useraccount_cubit.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../../widgets/success/success_request_widget.dart';


class EmailAndUserAccountScreen  extends StatefulWidget{

  static const routeName = "/email-user-account-screen";
  static const requestNoKey = 'request-No';
  static const requestHrCode = 'request-HrCode';

  const EmailAndUserAccountScreen({Key? key,this.requestNo ,this.requestedHrCode}) : super(key: key);

  final requestNo;
  final requestedHrCode;

  @override
  State<EmailAndUserAccountScreen> createState() => _EmailAndUserAccountScreen();

}

class _EmailAndUserAccountScreen extends State<EmailAndUserAccountScreen> {

  var mobileKey =false;

  bool hrCodeUpdated=false;
  String hrCodeEmail="";


  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    final currentRequestNo = widget.requestNo;

    return  WillPopScope(
        onWillPop: () async {
      await EasyLoading.dismiss(animation: true);
      return true;
    },

      child: CustomBackground(
        child: CustomTheme(
      child: BlocProvider<EmailUserAccountCubit>(create: (emailUserContext) =>
      currentRequestNo [EmailAndUserAccountScreen.requestNoKey] == "0" ? (EmailUserAccountCubit(
          RequestRepository(user))
        ..getRequestData(RequestStatus.newRequest, ""))
          : (EmailUserAccountCubit(RequestRepository(user))
        ..getRequestData(RequestStatus.oldRequest,
            currentRequestNo[EmailAndUserAccountScreen.requestNoKey])),


        child: BlocBuilder<EmailUserAccountCubit, EmailUserAccountInitial>(
            builder: (context, state) {

              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: const Text("Email Account"),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),

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
                        .read<EmailUserAccountCubit>()
                        .state
                        .requestStatus == RequestStatus.newRequest)
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          if(user.employeeData!.userHrCode == state.hrCodeUser.value){
                            EasyLoading.showError("Invalid same hr code",);
                          }else if(hrCodeUpdated){
                            EasyLoading.showError("Data not added");
                          }
                          else if(user.employeeData!.userHrCode != state.hrCodeUser.value){
                            context.read<EmailUserAccountCubit>()
                                .submitEmailAccount();
                          }else{
                            EasyLoading.showError("error",);
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
                      EasyLoading.show(status: 'loading...',maskType: EasyLoadingMaskType.black,dismissOnTap: false,);
                    }
                    if (state.status.isSubmissionSuccess) {
                      // LoadingDialog.hide(context);
                      EasyLoading.dismiss(animation: true);
                      if(state.requestStatus == RequestStatus.newRequest){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) =>
                                SuccessScreen(text: state.successMessage ??
                                    "Error Number",routName: EmailAndUserAccountScreen.routeName, requestName: 'User Account',)));
                      }
                    }
                     if (state.status.isSubmissionFailure) {
                       EasyLoading.showError(state.errorMessage.toString(),);
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
                                  prefixIcon: Icon(Icons.event,color: Colors.white70,),
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
                                                  .read<EmailUserAccountCubit>()
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
                                                  .read<EmailUserAccountCubit>()
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
                                          context.read<EmailUserAccountCubit>().hrCodeChanged(hrCode),
                                          context.read<EmailUserAccountCubit>().clearStateHRCode(),
                                          hrCodeUpdated = true,
                                          hrCodeEmail=hrCode.toString()

                                        },
                                      onFieldSubmitted: (value) {

                                        hrCodeEmail=value.toString();
                                        context.read<EmailUserAccountCubit>()
                                            // .hrCodeSubmittedGetData(state.hrCodeUser.value);
                                            .hrCodeSubmittedGetData(hrCodeEmail);
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
                                          floatingLabelAlignment: FloatingLabelAlignment.start,

                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.white70,),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.done),
                                            onPressed: () {
                                              context.read<EmailUserAccountCubit>()
                                                  .hrCodeSubmittedGetData(hrCodeEmail);
                                            },),
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
                                            return (state.requestStatus == RequestStatus.newRequest) ;
                                          },
                                          builder: (context, state) {
                                            return TextFormField(
                                              initialValue: state.fullName,

                                              key: UniqueKey(),
                                              // state.requestStatus ==
                                              //     RequestStatus.oldRequest
                                              //     ? true: false,
                                              readOnly:true,
                                              decoration: const InputDecoration(
                                                floatingLabelAlignment:
                                                FloatingLabelAlignment.start,
                                                labelText: 'Full Name',
                                                prefixIcon: Icon(
                                                    Icons.person,color: Colors.white70,),
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
                                            return (state.requestStatus == RequestStatus.newRequest) ;
                                          },
                                          builder: (context, state) {
                                            return TextFormField(
                                              initialValue: state.userTitle,
                                              key: UniqueKey(),
                                              // state.requestStatus ==
                                              //     RequestStatus.oldRequest
                                              //     ? true: false,
                                              readOnly:true,
                                              decoration: const InputDecoration(
                                                floatingLabelAlignment:
                                                FloatingLabelAlignment.start,
                                                labelText: 'Title',
                                                prefixIcon: Icon(
                                                    Icons.desk_outlined,color: Colors.white70,),
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
                                              return (state.requestStatus == RequestStatus.newRequest) ;
                                            },
                                            builder: (context, state) {
                                              return TextFormField(
                                                initialValue: state.userLocation,
                                                key: UniqueKey(),
                                                // state.requestStatus ==
                                                //     RequestStatus.oldRequest
                                                //     ? true: false,
                                                readOnly: true,
                                                decoration: const InputDecoration(
                                                  floatingLabelAlignment:
                                                  FloatingLabelAlignment.start,
                                                  labelText: 'Location',
                                                  prefixIcon: Icon(
                                                      Icons.business_center,color: Colors.white70,),
                                                ),
                                              );
                                            })
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: BlocBuilder<
                                          EmailUserAccountCubit,
                                          EmailUserAccountInitial>(
                                        // buildWhen: (previous, current) {
                                        //   // return (previous.requestDate !=
                                        //   //     current.requestDate) ||
                                        //   //     previous.status != current.status;
                                        //   return (state.requestStatus == RequestStatus.newRequest) ;
                                        // },
                                        builder: (context, state) {
                                          return TextFormField(


                                            key:mobileKey==false?UniqueKey():null,
                                            initialValue: state.userMobile.value,


                                            onChanged: (phoneValue) =>
                                            {
                                              mobileKey=true,
                                              context.read<EmailUserAccountCubit>()
                                                  .phoneNumberChanged(phoneValue.toString()),
                                            },


                                            keyboardType: TextInputType.phone,
                                            readOnly: state.requestStatus == RequestStatus.oldRequest ? true : false,
                                            decoration: InputDecoration(
                                              floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                              labelText: 'Mobile',
                                              prefixIcon: const Icon(
                                                  Icons.mobile_friendly,color: Colors.white70,),
                                              errorText: state.userMobile.invalid
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
                                  prefixIcon: Icon(Icons.event,color: Colors.white70,),
                                ),
                                child: BlocBuilder<
                                    EmailUserAccountCubit,
                                    EmailUserAccountInitial>(
                                  builder: (context, state) {
                                    return Row(children: [
                                      Text('Email Account'),
                                      Checkbox(
                                        // activeColor: Colors.white,
                                        value: state.accountType,
                                        onChanged: (bool? value) {
                                          state.requestStatus ==
                                              RequestStatus.newRequest ?
                                          context.read<EmailUserAccountCubit>()
                                              .getEmailValue(value!)
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



