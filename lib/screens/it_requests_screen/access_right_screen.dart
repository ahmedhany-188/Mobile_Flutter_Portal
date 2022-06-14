import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants/enums.dart';

class AccessUserAccountScreen extends StatefulWidget {

  static const routeName = "/access-user-account-screen";
  static const requestNoKey = 'request-No';

  const AccessUserAccountScreen(
      {Key? key,this.requestNo})
      : super(key: key);

  final requestNo;

  @override
  State<AccessUserAccountScreen> createState() => _AccessUserAccountScreen();

}

class _AccessUserAccountScreen extends State<AccessUserAccountScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    final TextEditingController commentController = TextEditingController();

    List<String> selectedTypes = [];

    List<dynamic> accountsTypesList = [
      {
        "value": "USB Exception",
        "display": "USB Exception",
      },
      {
        "value": "VPN Account",
        "display": "VPN Account",
      },
      {
        "value": "IP Phone",
        "display": "IP Phone",
      },
      {
        "value": "Local Admin",
        "display": "Local Admin",
      },
      {
        "value": "Color Printing",
        "display": "Color Printing",
      },
    ];

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
          BlocProvider<AccessRightCubit>(create: (vacationContext) =>
          currentRequestNo == null ? (AccessRightCubit(RequestRepository(user))..getRequestData(RequestStatus.newRequest, ""))
              :(AccessRightCubit(RequestRepository(user))..getRequestData(RequestStatus.oldRequest, currentRequestNo[AccessUserAccountScreen.requestNoKey]))),
          // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])),
        ],
        child: BlocBuilder<AccessRightCubit,AccessRightInitial>(
            builder: (context,state) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Access Right"),
                    centerTitle: true,
                  ),
                  // resizeToAvoidBottomInset: false,
                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.verified),
                        label: const Text('Accept'),
                      ),
                      const SizedBox(height: 12),
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus ==
                          RequestStatus.oldRequest)FloatingActionButton
                          .extended(
                        backgroundColor: Colors.red,
                        heroTag: null,
                        onPressed: () {},
                        icon: const Icon(Icons.dangerous),

                        label: const Text('Reject'),
                      ),
                      const SizedBox(height: 12),
                      if(context
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus == RequestStatus.newRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<AccessRightCubit>()
                                .getSubmitAccessRight(selectedTypes);
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
                  drawer: MainDrawer(),
                  body: BlocListener<AccessRightCubit, AccessRightInitial>(
                    listener: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Success"),
                          ),
                        );
                      }
                      else if (state.status.isSubmissionInProgress) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Loading"),
                          ),
                        );
                      }
                      else if (state.status.isSubmissionFailure) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage.toString()),
                          ),
                        );
                      }
                    },

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  buildWhen: (previous, current) {
                                    return (previous.requestDate !=
                                        current.requestDate) ||
                                        previous.status != current.status;
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue: state.requestDate.value,
                                      key: UniqueKey(),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Request Date',
                                        prefixIcon: Icon(
                                            Icons.calendar_today),
                                      ),
                                    );
                                  },
                                ),
                              ),


                              const Text("Request Type"),


                              BlocBuilder<AccessRightCubit,
                                  AccessRightInitial>(
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        RadioListTile<int>(
                                          value: 1,
                                          title: const Text("Access Right"),
                                          groupValue: state.requestType,
                                          // selected: (state.requestType == 1) ? true : false,
                                          onChanged: (accessType) =>
                                          {
                                            // state.requestStatus == RequestStatus.newRequest ?
                                            context.read<AccessRightCubit>()
                                                .accessRightChanged(
                                                accessType!),
                                          },
                                        ),
                                        RadioListTile<int>(
                                          value: 2,
                                          title: const Text("Disable"),
                                          groupValue: state.requestType,
                                          // selected: (state.requestType == 2) ? true : false,
                                          onChanged: (accessType) =>
                                          {
                                            // state.requestStatus == RequestStatus.newRequest ?
                                            context.read<AccessRightCubit>()
                                                .accessRightChanged(
                                                accessType!),
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                    builder: (context, state) {
                                      return MultiSelect(
                                          selectedOptionsBoxColor: Colors
                                              .transparent,
                                          //--------customization selection modal-----------
                                          titleText: "Items",
                                          checkBoxColor: Colors.black,
                                          hintText: state.requestItems.valid
                                              ? null
                                              : "Tap to select one or more items",
                                          // optional
                                          buttonBarColor: Colors.blueGrey,
                                          cancelButtonText: "Exit",

                                          maxLengthIndicatorColor: Colors
                                              .transparent,
                                          maxLengthText: "",
                                          maxLength: 5,
                                          // optional
                                          //--------end customization selection modal------------
                                          validator: (dynamic value) {
                                            if (value == null) {
                                              return 'Please select one or more option(s)';
                                            }
                                            return null;
                                          },
                                          errorText: state.requestItems.invalid
                                              ? 'invalid items'
                                              : null,
                                          dataSource: accountsTypesList,
                                          textField: 'display',
                                          valueField: 'value',
                                          filterable: true,
                                          required: true,


                                          onSaved: (value) {
                                            selectedTypes.clear();
                                            if (value != null) {
                                              for (int i = 0; i <
                                                  value.length; i++) {
                                                selectedTypes.add(
                                                    value[i].toString());
                                              }
                                              context.read<AccessRightCubit>().
                                              getRequestValue(
                                                  selectedTypes.toString());
                                            }
                                          }

                                      );
                                    }),
                              ),


                              const Text(
                                "* If you choose a USB Exception please download this file Download and upload after signatuer",
                                style: TextStyle(color: Colors.red),),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    _launchUrl();
                                  },
                                  label: const Text(
                                      'Download file', style: TextStyle(
                                      color: Colors.black
                                  )),
                                  icon: const Icon(
                                      Icons.cloud_download_sharp,
                                      color: Colors.black),
                                  backgroundColor: Colors.white,),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  builder: (context, state) {
                                    return
                                      FloatingActionButton.extended(
                                        onPressed: () async {
                                          FilePickerResult? result = await FilePicker
                                              .platform.pickFiles();

                                          if (result != null) {
                                            Uint8List? fileBytes = result.files
                                                .first
                                                .bytes;
                                            String fileName = result.files.first
                                                .name;

                                            // Upload file
                                            // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
                                          }
                                        },
                                        label: const Text(
                                            'Upload', style: TextStyle(
                                            color: Colors.black
                                        )),
                                        icon: const Icon(
                                            Icons.cloud_upload_sharp,
                                            color: Colors.black),
                                        backgroundColor: Colors.white,);
                                  },),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue: state.fromDate.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'From Date',
                                        errorText: state.fromDate.invalid
                                            ? 'invalid Date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.calendar_today),
                                      ),
                                      onTap: () async {
                                        if ((state.requestStatus == RequestStatus.newRequest) ? false : true) {
                                          context.read<AccessRightCubit>().
                                          selectDate(context, "from");
                                        }
                                      },
                                    );
                                  },),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue:state.toDate.value,
                                      key: UniqueKey(),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'To Date',
                                        errorText: state.toDate.invalid
                                            ? 'invalid Date'
                                            : null,
                                        prefixIcon: const Icon(
                                            Icons.calendar_today),
                                      ),
                                      onTap: () async {
                                        if ((state.requestStatus == RequestStatus.newRequest)
                                            ? false
                                            : true) {
                                          context.read<AccessRightCubit>().
                                          selectDate(context, "to");
                                        }
                                      },
                                    );
                                  },),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  builder: (context, state) {
                                    return Card(
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Permanent ',
                                            style: TextStyle(fontSize: 17.0),
                                          ), //Text
                                          const SizedBox(width: 10), //SizedBox
                                          /** Checkbox Widget **/
                                          Checkbox(
                                            value: state.permanent,
                                            onChanged: (bool? value) {
                                                context.read<AccessRightCubit>()
                                                    .getPermanentValue(value!);
                                            },
                                          ), //Checkbox
                                        ], //<Widget>[]
                                      ),
                                    );
                                  },),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                  builder: (context, state) {
                                    return TextField(
                                      onChanged: (commentValue) =>
                                          context
                                              .read<AccessRightCubit>()
                                              .commentValueChanged(commentValue),
                                      enabled: (state.requestStatus == RequestStatus.newRequest)
                                          ? false
                                          : true,
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


                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              );
            }
        ),
      ),
    );
  }

  void _launchUrl() async {
    FlutterWebBrowser.openWebPage(
      url: "https://portal.hassanallam.com/Files/Hassan Allam_Confidentiality Undertaking_MBH 15 01 19.pdf",
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        // toolbarColor: Colors.blue,
        // secondaryToolbarColor: Colors.green,
        // navigationBarColor: Colors.amber,
        shareState: CustomTabsShareState.on,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.green,
        preferredControlTintColor: Colors.amber,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }


}