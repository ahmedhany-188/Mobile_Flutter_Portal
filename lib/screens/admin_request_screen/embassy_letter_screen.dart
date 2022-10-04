import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/admin_requests_screen_bloc/embassy_letter_request/embassy_letter_cubit.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';


import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../constants/enums.dart';
import '../../../widgets/success/success_request_widget.dart';
import '../../widgets/requester_data_widget/requester_data_widget.dart';

class EmbassyLetterScreen extends StatefulWidget{

  static const routeName = "embassy-letter-screen";
  static const requestNoKey = 'request-No';
  static const requesterHRCode = 'requester-HRCode';

  const EmbassyLetterScreen({Key? key,this.requestData}) : super(key: key);

  final dynamic requestData;

  @override
  State<EmbassyLetterScreen> createState() => _EmbassyLetterScreen();

}

class _EmbassyLetterScreen extends State<EmbassyLetterScreen> {

  List<String> addSalaryList = [
    "Yes",
    "No"
  ];


  @override
  Widget build(BuildContext context) {

    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);

    final currentRequestData = widget.requestData;

    return CustomBackground(
      child: CustomTheme(
        child: BlocProvider<EmbassyLetterCubit>(
          create: (embassyContext) =>
          currentRequestData [EmbassyLetterScreen.requestNoKey] == "0"? (EmbassyLetterCubit(
              RequestRepository(userMainData))
            ..getRequestData(requestStatus: RequestStatus.newRequest))
              : (EmbassyLetterCubit(RequestRepository(userMainData))
            ..getRequestData(requestStatus: RequestStatus.oldRequest,
                requestNo: currentRequestData[EmbassyLetterScreen.requestNoKey],
                requesterHRCode: currentRequestData[EmbassyLetterScreen
                    .requesterHRCode])),
          child: BlocBuilder<EmbassyLetterCubit,EmbassyLetterInitial>(
              builder: (context,state) {
                return  WillPopScope(
                    onWillPop: () async {
                  await EasyLoading.dismiss(animation: true);
                  return true;
                }, child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title:  Text("Embassy Letter ${state.requestStatus ==
                        RequestStatus.oldRequest
                        ? "#${currentRequestData[BusinessMissionScreen
                        .requestNoKey]}"
                        : "Request"}"),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    // centerTitle: true,
                  ),
                  floatingActionButton: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if(state.requestStatus ==
                            RequestStatus.oldRequest && state.takeActionStatus ==
                            TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<EmbassyLetterCubit>()
                                .submitAction(ActionValueStatus.accept,currentRequestData[EmbassyLetterScreen.requestNoKey]);

                          },
                          icon: const Icon(Icons.verified),
                          label: const Text('Accept'),
                        ),
                        const SizedBox(height: 12),
                        if(state.requestStatus ==
                            RequestStatus.oldRequest && state.takeActionStatus ==
                            TakeActionStatus.takeAction)FloatingActionButton
                            .extended(
                          backgroundColor: Colors.white,
                          heroTag: null,
                          onPressed: () {
                            context.read<EmbassyLetterCubit>()
                                .submitAction(ActionValueStatus.reject,currentRequestData[EmbassyLetterScreen.requestNoKey]);

                          },
                          icon: const Icon(Icons.dangerous,color: ConstantsColors.buttonColors,),

                          label: const Text('Reject',style: TextStyle(color: ConstantsColors.buttonColors,),),
                        ),
                        const SizedBox(height: 12),
                        if(state.requestStatus == RequestStatus.newRequest)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              context.read<EmbassyLetterCubit>()
                                  .submitEmbassyLetter();
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


                  body: BlocListener<EmbassyLetterCubit, EmbassyLetterInitial>(
                    listener: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        // LoadingDialog.hide(context);
                        EasyLoading.dismiss(animation: true);
                        if(state.requestStatus == RequestStatus.newRequest){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) =>
                                  SuccessScreen(text: state.successMessage ??
                                      "Error Number",routName: EmbassyLetterScreen.routeName, requestName: 'Embassy Letter',)));
                        }
                        else if (state.requestStatus == RequestStatus.oldRequest){
                          EasyLoading.showSuccess(state.successMessage ?? "").then((value) {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context,rootNavigator: true).pop();
                            }else{
                              SystemNavigator.pop();
                            }
                          });
                          BlocProvider.of<UserNotificationApiCubit>(context).getNotifications();}
                      }
                      else if (state.status.isSubmissionInProgress) {
                        EasyLoading.show(status: 'loading...',maskType: EasyLoadingMaskType.black,dismissOnTap: false,);

                      }
                      else if (state.status.isSubmissionFailure) {
                        EasyLoading.showError(state.errorMessage.toString(),);

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
                              if(state.requestStatus ==
                                  RequestStatus.oldRequest)Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<
                                    EmbassyLetterCubit,
                                    EmbassyLetterInitial>(

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

                              if(state.requestStatus ==
                                  RequestStatus.oldRequest &&
                                  state.takeActionStatus ==
                                      TakeActionStatus.takeAction)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<
                                      EmbassyLetterCubit,
                                      EmbassyLetterInitial>(
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
                                                      EmbassyLetterCubit>()
                                                      .commentRequesterChanged(
                                                      commentValue)),);
                                      }
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue:state.requestDate.value,
                                  key: UniqueKey(),
                                  readOnly: true,
                                  enabled: false,
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
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return DropdownButtonHideUnderline(
                                      child: IgnorePointer(
                                        ignoring: state.requestStatus == RequestStatus.oldRequest ? true :false,
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Purpose',
                                            prefixIcon: Icon(
                                                Icons.calendar_today,color: Colors.white70,),
                                          ),
                                          value: state.purpose,
                                          items: GlobalConstants.embassyLetterPurposeList.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item, child: Text(item,
                                                style: const TextStyle(fontSize: 14,),
                                              ),
                                              )).toList(),
                                          onChanged: (value) => context.read<EmbassyLetterCubit>()
                                                  .addSelectedPurpose(
                                                  value.toString()),
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return DropdownButtonHideUnderline(
                                      child: IgnorePointer(
                                        ignoring: state.requestStatus == RequestStatus.oldRequest ? true :false,
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: 'Embassy',
                                            prefixIcon: Icon(
                                                Icons.calendar_today,color: Colors.white70,),
                                          ),
                                          //value: state.embassy,
                                          value :state.requestStatus == RequestStatus.oldRequest? GlobalConstants.embassyLetterList[int.parse(state.embassy)-1]:
                                          GlobalConstants.embassyLetterList[int.parse(state.embassy)],
                                          hint: Text(state.embassy,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          items: GlobalConstants.embassyLetterList.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item, child: Text(item,
                                                style: const TextStyle(fontSize: 14,),
                                              ),
                                              )).toList(),
                                          onChanged: (value) {

                                              context.read<EmbassyLetterCubit>()
                                                  .addSelectedEmbassy(
                                                   GlobalConstants.embassyLetterList.indexOf((value).toString()),
                                              );
                                          },
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue:state.dateFrom.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'From Date',
                                        errorText: state.dateFrom.invalid
                                            ? 'invalid Date'
                                            : null,
                                        enabled: state.requestStatus ==
                                            RequestStatus.newRequest
                                            ? true
                                            : false,
                                        prefixIcon: const Icon(
                                            Icons.calendar_today,color: Colors.white70,),
                                      ),
                                      onTap: () async {
                                          context.read<EmbassyLetterCubit>().
                                          selectDate(context, "from");
                                      },
                                    );
                                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue:state.dateTo.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'To Date',
                                        enabled: state.requestStatus ==
                                            RequestStatus.newRequest
                                            ? true
                                            : false,
                                        errorText: state.dateTo.invalid
                                            ? 'invalid Date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.calendar_today,color: Colors.white70,),
                                      ),
                                      onTap: () async {
                                          context.read<EmbassyLetterCubit>().
                                          selectDate(context, "to");
                                      },
                                    );
                                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  buildWhen: (curr,prev){
                                    return curr.passportNumber != prev.passportNumber;
                                  },
                                    builder: (context, state) {
                                      return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state.requestStatus ==
                                              RequestStatus.oldRequest ? state
                                              .passportNumber.value : "",
                                          // initialValue:state.passportNumber.value,
                                          keyboardType: TextInputType.number,
                                          readOnly: state.requestStatus ==
                                              RequestStatus.oldRequest ? true : false,
                                          onChanged: (value) {
                                            context.read<EmbassyLetterCubit>()
                                                .passportNo(value);
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: "Passport NO",
                                            prefixIcon: const Icon(Icons.book,color: Colors.white70,),
                                            errorText: state.passportNumber.invalid
                                                ? 'invalid Passport NO'
                                                : null,
                                          )
                                      );
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                  builder: (context, state) {
                                    return DropdownButtonHideUnderline(
                                      child: IgnorePointer(
                                        ignoring: state.requestStatus == RequestStatus.oldRequest ? true :false,
                                        child: DropdownButtonFormField(
                                          // hint: Text(state.salary,
                                          //   style: const TextStyle(
                                          //     fontSize: 14,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                            decoration: const InputDecoration(
                                              floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                              labelText: "Add Salary",
                                              prefixIcon: Icon(Icons.money,color: Colors.white70,),
                                            ),
                                          items: addSalaryList.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item, child: Text(item,
                                                style: const TextStyle(fontSize: 14,),
                                              ),
                                              )).toList(),
                                          value: state.salary,
                                          onChanged: (value) {
                                              context.read<EmbassyLetterCubit>()
                                                  .addSelectedSalary(
                                                  value.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<EmbassyLetterCubit,
                                    EmbassyLetterInitial>(
                                    builder: (context, state) {
                                      return TextFormField(
                                          key: state.requestStatus ==
                                              RequestStatus.oldRequest
                                              ? UniqueKey()
                                              : null,
                                          initialValue: state.requestStatus ==
                                              RequestStatus.oldRequest ? state
                                              .comments : "",
                                          // initialValue:state.comments,
                                          onChanged: (value) {
                                            context.read<EmbassyLetterCubit>()
                                                .comments(value);
                                          },
                                          enabled: state.requestStatus ==
                                              RequestStatus.newRequest
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                            labelText: "Comments",
                                            prefixIcon: const Icon(Icons.comment,color: Colors.white70,),
                                            border: myInputBorder(),
                                          )
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
                ),
                );
              }
          ),
        ),
      ),
    );
  }
  BoxDecoration outlineboxTypes() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 3, color: Colors.black)
    );
  }

}