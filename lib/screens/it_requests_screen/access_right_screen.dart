import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:hassanallamportalflutter/widgets/filters/multi_selection_chips_filters.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants/enums.dart';

class AccessRightScreen extends StatefulWidget {

  static const routeName = "/access-user-account-screen";
  static const requestNoKey = 'request-No';
  static const requestHrCode = 'request-HrCode';

  const AccessRightScreen(
      {Key? key,this.requestNo,this.requestedHrCode})
      : super(key: key);

  final requestNo;
  final requestedHrCode;

  @override
  State<AccessRightScreen> createState() => _AccessRightScreen();

}

class _AccessRightScreen extends State<AccessRightScreen> {

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    final formatter = GlobalConstants.dateFormatServer;

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
          BlocProvider<AccessRightCubit>(create: (accessRightContext) =>
          currentRequestNo == null ? (AccessRightCubit(RequestRepository(user))
            ..getRequestData(RequestStatus.newRequest, ""))
              : (AccessRightCubit(RequestRepository(user))
            ..getRequestData(RequestStatus.oldRequest,
                currentRequestNo[AccessRightScreen.requestNoKey]))),
          // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])),
        ],
        child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Access Right"),
                    centerTitle: true,
                  ),
                  // resizeToAvoidBottomInset: false,
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
                      if(state
                          .requestStatus ==
                          RequestStatus.oldRequest && state.takeActionStatus ==
                          TakeActionStatus.takeAction )FloatingActionButton
                          .extended(
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
                                .getSubmitAccessRight();
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
                  body: BlocListener<AccessRightCubit, AccessRightInitial>(
                    listener: (context, state) {
                      if (state.status.isSubmissionInProgress) {
                        LoadingDialog.show(context);
                      }
                      if (state.status.isSubmissionSuccess) {
                        LoadingDialog.hide(context);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) =>
                                SuccessScreen(text: state.successMessage ??
                                    "Error Number",)));
                      }
                      if (state.status.isSubmissionFailure) {
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              if(state.requestStatus ==
                                  RequestStatus.oldRequest)Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: BlocBuilder<
                                    AccessRightCubit,
                                    AccessRightInitial>(

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
                                    AccessRightCubit,
                                    AccessRightInitial>(
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
                                  child: BlocBuilder<AccessRightCubit,
                                      AccessRightInitial>(
                                      buildWhen: (previous, current) {
                                        return (state.requestStatus ==
                                            RequestStatus.newRequest);
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
                                              title: const Text("Access Right"),
                                              groupValue: state.requestType,
                                              // selected: (state.requestType == 1) ? true : false,
                                              onChanged: (accessType) =>
                                              {
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<AccessRightCubit>()
                                                    .accessRightChanged(
                                                    accessType ?? 1)
                                                    : null,
                                              },
                                            ),
                                            RadioListTile<int>(
                                              value: 2,
                                              title: const Text("Disable"),
                                              groupValue: state.requestType,
                                              // selected: (state.requestType == 2) ? true : false,
                                              onChanged: (accessType) =>
                                              {
                                                state.requestStatus ==
                                                    RequestStatus.newRequest
                                                    ? context
                                                    .read<AccessRightCubit>()
                                                    .accessRightChanged(
                                                    accessType ?? 2)
                                                    : null,
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),

                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    labelText: 'Select items',
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                  ),
                                  child: BlocBuilder<
                                      AccessRightCubit,
                                      AccessRightInitial>(
                                      buildWhen: (previous, current) {
                                        return (state.requestStatus ==
                                            RequestStatus.newRequest);
                                      },
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: MultiSelectionChipsFilters(
                                            filtersList: GlobalConstants
                                                .accountsTypesList,
                                            filterName: 'Select items',
                                            onConfirm: (selectedFilters) {
                                              List<String> x = selectedFilters
                                                  .map((e) => e.toString())
                                                  .toList();
                                              context.read<AccessRightCubit>().
                                              getRequestValue(x.toString());
                                              context.read<AccessRightCubit>().
                                              chosenItemsOptions(
                                                  selectedFilters
                                                      .map((e) => e.toString())
                                                      .toList());
                                            },
                                            initialValue: state
                                                .requestItemsList,
                                            onTap: (item) {
                                              List<String> x = [
                                                ...state.requestItemsList
                                              ]
                                                ..remove(item);

                                              context.read<AccessRightCubit>().
                                              chosenItemsOptions([
                                                ...state.requestItemsList
                                              ]
                                                ..remove(item));

                                              context.read<AccessRightCubit>().
                                              getRequestValue(x.toString());
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    labelText: 'Usb Agreement',
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    prefixIcon: Icon(Icons.usb),
                                  ),

                                  child: BlocBuilder<
                                      AccessRightCubit,
                                      AccessRightInitial>(
                                    buildWhen: (previous, current) {
                                      return (state.requestStatus ==
                                          RequestStatus.newRequest);
                                    },
                                    builder: (context, state) {
                                      return


                                        Column(children: [

                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              "* If you choose a USB Exception please download this file and upload after signature",
                                              style: TextStyle(
                                                  color: Colors.red),),
                                          ),


                                          Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: FloatingActionButton
                                                  .extended(
                                                onPressed: () {
                                                  _launchUrl();
                                                },
                                                label: const Text(
                                                    'Download file',
                                                    style: TextStyle(
                                                        color: Colors.black
                                                    )),
                                                icon: const Icon(
                                                    Icons.cloud_download_sharp,
                                                    color: Colors.black),
                                                backgroundColor: Colors.white,),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: BlocBuilder<
                                                  AccessRightCubit,
                                                  AccessRightInitial>(
                                                builder: (context, state) {
                                                  return
                                                    FloatingActionButton
                                                        .extended(
                                                      onPressed: () async {
                                                        FilePickerResult? result = await FilePicker
                                                            .platform
                                                            .pickFiles();

                                                        if (result != null) {
                                                          Uint8List? fileBytes = result
                                                              .files
                                                              .first
                                                              .bytes;
                                                          String fileName = result
                                                              .files.first
                                                              .name;

                                                          // Upload file
                                                          // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
                                                        }
                                                      },
                                                      label: const Text(
                                                          'Upload',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                          )),
                                                      icon: const Icon(
                                                          Icons
                                                              .cloud_upload_sharp,
                                                          color: Colors.black),
                                                      backgroundColor: Colors
                                                          .white,);
                                                },),
                                            ),
                                          ],),

                                        ],);
                                    },),


                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<
                                    AccessRightCubit,
                                    AccessRightInitial>(
                                  // buildWhen: (previous, current) {
                                  //   return (previous.requestDate !=
                                  //       current.requestDate) ||
                                  //       previous.status != current.status;
                                  // },

                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue:  state.fromDate.value,
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
                                        if (state.requestStatus ==
                                            RequestStatus.newRequest) {
                                          context.read<AccessRightCubit>().
                                          selectDate(context, "from");
                                        }
                                      },
                                    );
                                  },),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<
                                    AccessRightCubit,
                                    AccessRightInitial>(
                                  // buildWhen: (previous, current) {
                                  //   return (previous.requestDate !=
                                  //       current.requestDate) ||
                                  //       previous.status != current.status;
                                  // },
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
                                        if (state.requestStatus ==
                                            RequestStatus.newRequest) {
                                          context.read<AccessRightCubit>().
                                          selectDate(context, "to");
                                        }
                                      },
                                    );
                                  },),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    labelText: 'Time',
                                    floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                    prefixIcon: Icon(Icons.event),
                                  ),
                                  child: BlocBuilder<
                                      AccessRightCubit,
                                      AccessRightInitial>(

                                    buildWhen: (previous, current) {
                                      return (state.requestStatus ==
                                          RequestStatus.newRequest);
                                    },

                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          const Text('Permanent'), //Text
                                          Checkbox(
                                            value: state.permanent,
                                            onChanged: (bool? value) {
                                              context.read<AccessRightCubit>()
                                                  .getPermanentValue(value!);
                                            },

                                          ),
                                        ], /** Checkbox Widget **/ //<Widget>[]
                                      );
                                    },),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 8.0,
                                    left: 8.0,
                                    top: 8.0,
                                    bottom: 80.0),
                                child: BlocBuilder<
                                    AccessRightCubit,
                                    AccessRightInitial>(

                                  buildWhen: (previous, current) {
                                    return (state.requestStatus ==
                                        RequestStatus.newRequest);
                                  },
                                  builder: (context, state) {
                                    return TextFormField(
                                      initialValue: state.comments,
                                      readOnly:
                                      state.requestStatus ==
                                          RequestStatus.oldRequest
                                          ? true : false,
                                      onChanged: (commentValue) =>
                                          context
                                              .read<AccessRightCubit>()
                                              .commentValueChanged(
                                              commentValue),
                                      decoration: const InputDecoration(
                                        floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                        labelText: 'Comment',
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
              onPressed: () =>
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => const AccessRightScreen())),
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
