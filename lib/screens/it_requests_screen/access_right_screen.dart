
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:file_picker/file_picker.dart';

class AccessUserAccountScreen extends StatefulWidget{

  static const routeName = "/access-user-account-screen";
  const AccessUserAccountScreen({Key? key}) : super(key: key);

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
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.now());

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

    return Scaffold(
        appBar: AppBar(
          title: Text("Access Right"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,

        drawer: MainDrawer(),

        body: BlocListener<AccessRightCubit, AccessRightInitial>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success"),
                ),
              );

              print("---------..--" + state.successMessage.toString());
            } else if (state.status.isSubmissionInProgress) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Loading"),
                ),
              );
            } else if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.toString()),
                ),
              );
            }
          },

          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      TextFormField(
                        initialValue: formattedDate,
                        key: UniqueKey(),
                        readOnly: true,
                        decoration: InputDecoration(
                          floatingLabelAlignment:
                          FloatingLabelAlignment.start,
                          labelText: 'Request Date',
                          prefixIcon: const Icon(
                              Icons.calendar_today),
                        ),
                      ),
                      Container(height: 10),

                      Text("Request Type"),

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
                                  title: Text("Access Right"),
                                  groupValue: state.requestType,
                                  onChanged: (permissionType) =>
                                  {
                                    context.read<AccessRightCubit>()
                                        .accesRightChanged(1),
                                  },
                                ),
                                RadioListTile<int>(
                                  value: 2,
                                  // dense: true,
                                  title: Text("Disable"),
                                  groupValue: state.requestType,
                                  onChanged: (permissionType) =>
                                  {
                                    context.read<AccessRightCubit>()
                                        .accesRightChanged(2),
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
                                selectedOptionsBoxColor: Colors.transparent,
                                //--------customization selection modal-----------
                                titleText: "Items",
                                checkBoxColor: Colors.black,
                                hintText: state.requestItems.valid
                                    ? null
                                    : "Tap to select one or more items",
                                // optional
                                buttonBarColor: Colors.blueGrey,
                                cancelButtonText: "Exit",

                                maxLengthIndicatorColor: Colors.transparent,
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
                                    for (int i = 0; i < value.length; i++) {
                                      selectedTypes.add(value[i].toString());
                                    }
                                  }
                                  context.read<AccessRightCubit>().
                                  getrequestValue(selectedTypes.toString());
                                }

                            );
                          }),

                      Container(height: 10,),

                      Text(
                        "* If you choose a USB Exception please download this file Download and upload after signatuer",
                        style: TextStyle(color: Colors.red),),

                      Container(height: 10,),
                      FloatingActionButton.extended(
                        onPressed: () {
                          _launchUrl();
                        },
                        label: const Text('Download file', style: TextStyle(
                            color: Colors.black
                        )),
                        icon: const Icon(
                            Icons.cloud_download_sharp, color: Colors.black),
                        backgroundColor: Colors.white,),

                      Container(height: 10,),

                      BlocBuilder<AccessRightCubit, AccessRightInitial>(
                        builder: (context, state) {
                          return
                            FloatingActionButton.extended(
                              onPressed: () async {

                                FilePickerResult? result = await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  Uint8List? fileBytes = result.files.first.bytes;
                                  String fileName = result.files.first.name;

                                  // Upload file
                                  // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
                                }

                              },
                              label: const Text('Upload', style: TextStyle(
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
                              context.read<AccessRightCubit>().
                              selectDate(context, "from");
                            },
                          );
                        },),
                      BlocBuilder<AccessRightCubit, AccessRightInitial>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue: state.toDate.value,
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
                              context.read<AccessRightCubit>().
                              selectDate(context, "to");
                            },
                          );
                        },),

                      BlocBuilder<AccessRightCubit, AccessRightInitial>(
                        builder: (context, state) {
                          return Card(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Text(
                                  'Permanent ',
                                  style: TextStyle(fontSize: 17.0),
                                ), //Text
                                SizedBox(width: 10), //SizedBox
                                /** Checkbox Widget **/
                                Checkbox(
                                  value: state.permanent,
                                  onChanged: (bool? value) {
                                    context.read<AccessRightCubit>()
                                        .getpermanentValue(value!);
                                  },
                                ), //Checkbox
                              ], //<Widget>[]
                            ),
                          );
                        },),

                      BlocBuilder<AccessRightCubit, AccessRightInitial>(
                        builder: (context, state) {
                          return TextField(
                            onChanged: (conmmentValue) =>
                                context
                                    .read<AccessRightCubit>()
                                    .commentValueChanged(conmmentValue),
                            decoration: InputDecoration(
                              floatingLabelAlignment:
                              FloatingLabelAlignment.start,
                              labelText: 'Comments',
                              prefixIcon: const Icon(
                                  Icons.comment),
                            ),
                          );
                        },
                      ),
                      Container(height: 10,),

                      FloatingActionButton.extended(
                        onPressed: () {
                          context.read<AccessRightCubit>()
                              .getSubmitAccessRight(
                              user, selectedTypes, formattedDate);
                        },
                        label: const Text('Submit', style: TextStyle(
                            color: Colors.black
                        )),
                        icon: const Icon(
                            Icons.thumb_up_alt_outlined, color: Colors.black),
                        backgroundColor: Colors.white,),

                      Container(height: 10,),

                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  void _launchUrl() async {
    FlutterWebBrowser.openWebPage(
      url: "https://portal.hassanallam.com/Files/Hassan Allam_Confidentiality Undertaking_MBH 15 01 19.pdf",
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: Colors.blue,
        secondaryToolbarColor: Colors.green,
        navigationBarColor: Colors.amber,
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