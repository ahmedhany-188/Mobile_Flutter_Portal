
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants/enums.dart';

class AccessUserAccountScreen extends StatefulWidget{

  static const routeName = "/access-user-account-screen";
  const AccessUserAccountScreen({Key? key,required this.accessRightModel,required this.objectValidation}) : super(key: key);


  final bool objectValidation;
  final AccessRightModel accessRightModel;

  @override
  State<AccessUserAccountScreen> createState() => _AccessUserAccountScreen();

}

class _AccessUserAccountScreen extends State<AccessUserAccountScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var deviceSize = MediaQuery
        .of(context)
        .size;

    final user = context.select((AppBloc bloc) => bloc.state.userData);
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(DateTime.now());
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

    // if (widget.objectValidation) {
    //   commentController.text = widget.accessRightModel.comments.toString();
    // }


    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: BlocProvider<AccessRightCubit>(
        create: (accessRightContext) =>
            AccessRightCubit(),
        child: Builder(
            builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Access Right"),
                    centerTitle: true,
                  ),
                  // resizeToAvoidBottomInset: false,
                  floatingActionButton:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(context
                          .read<AccessRightCubit>()
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
                          .read<AccessRightCubit>()
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
                          .read<AccessRightCubit>()
                          .state
                          .requestStatus == RequestStatus.newRequest)
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {
                            context.read<AccessRightCubit>()
                                    .getSubmitAccessRight(
                                    user, selectedTypes);
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

                              TextFormField(
                                initialValue: (widget.objectValidation)
                                    ? widget
                                    .accessRightModel.requestDate
                                    : "",
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

                              Container(height: 10),

                              const Text("Request Type"),

                              Container(height: 10),

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
                                          groupValue: (widget.objectValidation)
                                              ? null
                                              : state.requestType,

                                          selected: (widget.accessRightModel
                                              .requestType == 1) ? true : false,
                                          onChanged: (permissionType) =>
                                          {
                                            context.read<AccessRightCubit>()
                                                .accessRightChanged(1),
                                          },
                                        ),
                                        RadioListTile<int>(
                                          value: 2,
                                          // dense: true,
                                          title: const Text("Disable"),

                                          groupValue: (widget.objectValidation)
                                              ? null
                                              : state.requestType,
                                          selected: (widget.accessRightModel
                                              .requestType == 2) ? true : false,
                                          onChanged: (permissionType) =>
                                          {
                                            context.read<AccessRightCubit>()
                                                .accessRightChanged(2),
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              ),

                              Container(height: 10,),

                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
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

                              Container(height: 10,),

                              const Text(
                                "* If you choose a USB Exception please download this file Download and upload after signatuer",
                                style: TextStyle(color: Colors.red),),

                              Container(height: 10,),

                              FloatingActionButton.extended(
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

                              Container(height: 10,),

                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
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

                              Container(height: 10,),
                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    initialValue: (widget.objectValidation)
                                        ? widget.accessRightModel.fromDate
                                        .toString()
                                        : state.fromDate.value,
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
                                      if (!widget.objectValidation) {
                                        context.read<AccessRightCubit>().
                                        selectDate(context, "from");
                                      }
                                    },
                                  );
                                },),
                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                builder: (context, state) {
                                  return TextFormField(
                                    initialValue: (widget.objectValidation)
                                        ? widget.accessRightModel.toDate
                                        .toString()
                                        : state.toDate.value,
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
                                      if (!widget.objectValidation) {
                                        context.read<AccessRightCubit>().
                                        selectDate(context, "to");
                                      }
                                    },
                                  );
                                },),

                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
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
                                          value: (widget.objectValidation)
                                              ? widget
                                              .accessRightModel.permanent
                                              : state
                                              .permanent,
                                          onChanged: (bool? value) {
                                            if (!widget.objectValidation) {
                                              context.read<AccessRightCubit>()
                                                  .getPermanentValue(value!);
                                            }
                                          },
                                        ), //Checkbox
                                      ], //<Widget>[]
                                    ),
                                  );
                                },),

                              BlocBuilder<AccessRightCubit, AccessRightInitial>(
                                builder: (context, state) {
                                  return TextField(
                                    controller: (widget.objectValidation)
                                        ? commentController
                                        : null,
                                    onChanged: (commentValue) =>
                                        context
                                            .read<AccessRightCubit>()
                                            .commentValueChanged(commentValue),
                                    enabled: (widget.objectValidation)
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
                              Container(height: 10,),



                              Container(height: 10,),

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