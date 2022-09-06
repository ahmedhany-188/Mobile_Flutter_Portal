import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/it_request_bloc/access_right_request/access_right_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:hassanallamportalflutter/widgets/filters/multi_selection_chips_filters.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../../constants/enums.dart';
import '../../../widgets/success/success_request_widget.dart';
import '../../widgets/requester_data_widget/requester_data_widget.dart';

class AccessRightScreen extends StatefulWidget {
  static const routeName = "/access-user-account-screen";
  static const requestNoKey = 'request-No';
  static const requesterHRCode = 'request-HrCode';

  const AccessRightScreen({Key? key, this.requestData}) : super(key: key);

  final dynamic requestData;

  @override
  State<AccessRightScreen> createState() => _AccessRightScreen();
}

class _AccessRightScreen extends State<AccessRightScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);
    // final formatter = GlobalConstants.dateFormatServer;
    final currentRequestData = widget.requestData;

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
        child: CustomTheme(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AccessRightCubit>(
                  create: (accessRightContext) =>
                      currentRequestData[AccessRightScreen.requestNoKey] == "0"
                          ? (AccessRightCubit(RequestRepository(user))
                            ..getRequestData(
                                requestStatus: RequestStatus.newRequest,
                                requestNo: ""))
                          : (AccessRightCubit(RequestRepository(user))
                            ..getRequestData(
                                requestStatus: RequestStatus.oldRequest,
                                requestNo: currentRequestData[
                                    AccessRightScreen.requestNoKey],
                                requesterHRCode: currentRequestData[
                                    AccessRightScreen.requesterHRCode]))),
              // ..getRequestData(currentRequestNo == null ?RequestStatus.newRequest : RequestStatus.oldRequest,currentRequestNo == null?"":currentRequestNo[VacationScreen.requestNoKey])),
            ],
            child: BlocBuilder<AccessRightCubit, AccessRightInitial>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text("Access Right "
                          "${state.requestStatus == RequestStatus.oldRequest ? "#${currentRequestData[AccessRightScreen.requestNoKey]}" : "Request"}"),
                      centerTitle: true,
                    ),
                    // resizeToAvoidBottomInset: false,
                    floatingActionButton: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (state.requestStatus == RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus.takeAction)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              context.read<AccessRightCubit>().submitAction(
                                  ActionValueStatus.accept,
                                  currentRequestData[
                                      AccessRightScreen.requestNoKey]);
                            },
                            icon: const Icon(Icons.verified),
                            label: const Text('Accept'),
                          ),
                        const SizedBox(height: 12),
                        if (state.requestStatus == RequestStatus.oldRequest &&
                            state.takeActionStatus ==
                                TakeActionStatus.takeAction)
                          FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            heroTag: null,
                            onPressed: () {
                              context.read<AccessRightCubit>().submitAction(
                                  ActionValueStatus.reject,
                                  currentRequestData[
                                      AccessRightScreen.requestNoKey]);
                            },
                            icon: const Icon(
                              Icons.dangerous,
                              color: ConstantsColors.buttonColors,
                            ),
                            label: const Text(
                              'Reject',
                              style: TextStyle(
                                  color: ConstantsColors.buttonColors),
                            ),
                          ),
                        const SizedBox(height: 12),
                        if (context
                                .read<AccessRightCubit>()
                                .state
                                .requestStatus ==
                            RequestStatus.newRequest)
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              context
                                  .read<AccessRightCubit>()
                                  .getSubmitAccessRight();
                            },
                            icon: const Icon(Icons.send),
                            label: const Text('SUBMIT'),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    body: BlocListener<AccessRightCubit, AccessRightInitial>(
                      listener: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,
                          );
                        }
                        if (state.status.isSubmissionSuccess) {
                          // LoadingDialog.hide(context);
                          EasyLoading.dismiss(animation: true);
                          if (state.requestStatus == RequestStatus.newRequest) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (_) => SuccessScreen(
                                          text: state.successMessage ??
                                              "Error Number",
                                          routName: AccessRightScreen.routeName,
                                          requestName: 'Access Right',
                                        )));
                          } else if (state.requestStatus ==
                              RequestStatus.oldRequest) {
                            EasyLoading.showSuccess(state.successMessage ?? "").then((value) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context,rootNavigator: true).pop();
                              }else{
                                SystemNavigator.pop();
                              }
                            });
                            BlocProvider.of<UserNotificationApiCubit>(context).getNotifications();
                          }
                        }
                        if (state.status.isSubmissionFailure) {
                          EasyLoading.showError(
                            state.errorMessage.toString(),
                          );
                        }
                        if (state.status.isValid) {
                          EasyLoading.dismiss(animation: true);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Form(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (state.requestStatus ==
                                    RequestStatus.oldRequest)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: BlocBuilder<AccessRightCubit,
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
                                    }),
                                  ),
                                if (state.requestStatus ==
                                        RequestStatus.oldRequest &&
                                    state.takeActionStatus ==
                                        TakeActionStatus.takeAction)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: BlocBuilder<AccessRightCubit,
                                            AccessRightInitial>(
                                        buildWhen: (previous, current) {
                                      return (previous.requesterData !=
                                          current.requesterData);
                                    }, builder: (context, state) {
                                      return RequesterDataWidget(
                                        requesterData: state.requesterData,
                                        actionComment: ActionCommentWidget(
                                            onChanged: (commentValue) => context
                                                .read<AccessRightCubit>()
                                                .commentRequesterChanged(
                                                    commentValue)),
                                      );
                                    }),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: BlocBuilder<AccessRightCubit,
                                          AccessRightInitial>(
                                      buildWhen: (previous, current) {
                                    return (previous.requestDate !=
                                            current.requestDate) ||
                                        previous.status != current.status;
                                  }, builder: (context, state) {
                                    return TextFormField(
                                      key: UniqueKey(),
                                      initialValue: state.requestDate.value,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Request Date',
                                        errorText: state.requestDate.invalid
                                            ? 'invalid request date'
                                            : null,
                                        prefixIcon:
                                            const Icon(Icons.date_range),
                                      ),
                                    );
                                  }),
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
                                      prefixIcon: Icon(Icons.event,
                                          color: Colors.white70),
                                    ),
                                    child: BlocBuilder<AccessRightCubit,
                                            AccessRightInitial>(
                                        buildWhen: (previous, current) {
                                      return (state.requestStatus ==
                                          RequestStatus.newRequest);
                                    }, builder: (context, state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RadioListTile<int>(
                                            value: 1,
                                            activeColor: Colors.white,
                                            title: const Text("Access Right"),
                                            groupValue: state.requestType,
                                            // selected: (state.requestType == 1) ? true : false,
                                            onChanged: (accessType) => {
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
                                            activeColor: Colors.white,
                                            title: const Text("Disable"),
                                            groupValue: state.requestType,
                                            // selected: (state.requestType == 2) ? true : false,
                                            onChanged: (accessType) => {
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
                                    }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      labelText: 'Select items',
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                    ),
                                    child: BlocBuilder<AccessRightCubit,
                                            AccessRightInitial>(
                                        builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: state.requestStatus ==
                                                RequestStatus.newRequest
                                            ? MultiSelectionChipsFilters(
                                                searchable: false,
                                                filtersList: GlobalConstants
                                                    .accountsTypesList,
                                                filterName: 'Select items',
                                                onConfirm: (selectedFilters) {
                                                  List<String> x =
                                                      selectedFilters
                                                          .map((e) =>
                                                              e.toString())
                                                          .toList();
                                                  context
                                                      .read<AccessRightCubit>()
                                                      .getRequestValue(
                                                          x.toString());
                                                  context
                                                      .read<AccessRightCubit>()
                                                      .chosenItemsOptions(
                                                          selectedFilters
                                                              .map((e) =>
                                                                  e.toString())
                                                              .toList());
                                                },
                                                initialValue:
                                                    state.requestItemsList,
                                                onTap: (item) {
                                                  List<String> x = [
                                                    ...state.requestItemsList
                                                  ]..remove(item);

                                                  context
                                                      .read<AccessRightCubit>()
                                                      .chosenItemsOptions([
                                                        ...state
                                                            .requestItemsList
                                                      ]..remove(item));

                                                  context
                                                      .read<AccessRightCubit>()
                                                      .getRequestValue(
                                                          x.toString());
                                                },
                                              )
                                            : ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                separatorBuilder: (context, i) {
                                                  return const SizedBox(
                                                    height: 2,
                                                  );
                                                },
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .requestItemsList.length,
                                                itemBuilder: (ctx, index) {
                                                  return Center(
                                                    child: Container(
                                                        width: 30.h,
                                                        color: Colors.white10,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(state
                                                                  .requestItemsList[
                                                              index]),
                                                        )),
                                                  );
                                                }),
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
                                      prefixIcon: Icon(Icons.usb,
                                          color: Colors.white70),
                                    ),
                                    child: BlocBuilder<AccessRightCubit,
                                        AccessRightInitial>(
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "* If you choose a USB Exception please download this file and upload after signature",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        _launchUrl();
                                                      },
                                                      label: const Text(
                                                        'Download',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      icon: const Icon(
                                                          Icons
                                                              .cloud_download_sharp,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: BlocBuilder<
                                                          AccessRightCubit,
                                                          AccessRightInitial>(
                                                        builder:
                                                            (context, state) {
                                                          return (state
                                                                      .requestStatus ==
                                                                  RequestStatus
                                                                      .newRequest)
                                                              ? ElevatedButton
                                                                  .icon(
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary: (state
                                                                              .chosenFileName
                                                                              .isNotEmpty)
                                                                          ? Colors
                                                                              .green
                                                                          : null),
                                                                  onPressed:
                                                                      () {
                                                                    AccessRightCubit.get(
                                                                            context)
                                                                        .setChosenFileName();
                                                                    // FilePickerResult?
                                                                    //     result =
                                                                    //     await FilePicker
                                                                    //         .platform
                                                                    //         .pickFiles();
                                                                    //
                                                                    // if (result !=
                                                                    //     null) {
                                                                    //   Uint8List?
                                                                    //       fileBytes =
                                                                    //       result
                                                                    //           .files
                                                                    //           .first
                                                                    //           .bytes;
                                                                    //   String
                                                                    //       fileName =
                                                                    //       result
                                                                    //           .files
                                                                    //           .first
                                                                    //           .name;
                                                                    //
                                                                    //   // Upload file
                                                                    //   // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
                                                                    // }
                                                                  },
                                                                  label: const Text(
                                                                      'Upload',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .cloud_upload_sharp,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : ElevatedButton
                                                                  .icon(
                                                                  onPressed:
                                                                      () {

                                                                      },
                                                                  label: const Text(
                                                                      'View',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .cloud_upload_sharp,
                                                                      color: Colors
                                                                          .white),
                                                                );
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                    initialValue:
                                                        state.fromDate.value,
                                                    key: UniqueKey(),
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      floatingLabelAlignment:
                                                          FloatingLabelAlignment
                                                              .start,
                                                      labelText: 'From Date',
                                                      errorText:
                                                          state.fromDate.invalid
                                                              ? 'invalid Date'
                                                              : null,
                                                      prefixIcon: const Icon(
                                                          Icons.calendar_today,
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    onTap: () async {
                                                      if (state.requestStatus ==
                                                          RequestStatus
                                                              .newRequest) {
                                                        context
                                                            .read<
                                                                AccessRightCubit>()
                                                            .selectDate(context,
                                                                "from");
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                    initialValue:
                                                        state.toDate.value,
                                                    key: UniqueKey(),
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      floatingLabelAlignment:
                                                          FloatingLabelAlignment
                                                              .start,
                                                      labelText: 'To Date',
                                                      errorText:
                                                          state.toDate.invalid
                                                              ? 'invalid Date'
                                                              : null,
                                                      prefixIcon: const Icon(
                                                          Icons.calendar_today,
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    onTap: () async {
                                                      if (state.requestStatus ==
                                                          RequestStatus
                                                              .newRequest) {
                                                        context
                                                            .read<
                                                                AccessRightCubit>()
                                                            .selectDate(
                                                                context, "to");
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InputDecorator(
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0,
                                                          vertical: 5),
                                                  labelText: 'Time',
                                                  floatingLabelAlignment:
                                                      FloatingLabelAlignment
                                                          .start,
                                                  prefixIcon: Icon(Icons.event,
                                                      color: Colors.white70),
                                                ),
                                                child: BlocBuilder<
                                                    AccessRightCubit,
                                                    AccessRightInitial>(
                                                  buildWhen:
                                                      (previous, current) {
                                                    return (state
                                                            .requestStatus ==
                                                        RequestStatus
                                                            .newRequest);
                                                  },
                                                  builder: (context, state) {
                                                    return Row(
                                                      children: [
                                                        const Text('Permanent'),
                                                        //Text
                                                        Checkbox(
                                                          value:
                                                              state.permanent,
                                                          onChanged:
                                                              (bool? value) {
                                                            context
                                                                .read<
                                                                    AccessRightCubit>()
                                                                .getPermanentValue(
                                                                    value!);
                                                          },
                                                        ),
                                                      ], /** Checkbox Widget **/ //<Widget>[]
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 8.0,
                                      bottom: 80.0),
                                  child: BlocBuilder<AccessRightCubit,
                                      AccessRightInitial>(
                                    buildWhen: (previous, current) {
                                      return (state.requestStatus ==
                                          RequestStatus.newRequest);
                                    },
                                    builder: (context, state) {
                                      return TextFormField(
                                        initialValue: state.comments,
                                        readOnly: state.requestStatus ==
                                                RequestStatus.oldRequest
                                            ? true
                                            : false,
                                        onChanged: (commentValue) => context
                                            .read<AccessRightCubit>()
                                            .commentValueChanged(commentValue),
                                        decoration: const InputDecoration(
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          labelText: 'Justify Your Request',
                                          prefixIcon: Icon(Icons.comment,
                                              color: Colors.white70),
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
                    )),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _launchUrl() async {
    launchUrl(
      Uri.parse(
          "https://portal.hassanallam.com/Files/Hassan Allam_Confidentiality Undertaking_MBH 15 01 19.pdf"),
      mode: LaunchMode.externalApplication,
    );

    // FlutterWebBrowser.openWebPage(
    //   url:
    //       "https://portal.hassanallam.com/Files/Hassan Allam_Confidentiality Undertaking_MBH 15 01 19.pdf",
    //   customTabsOptions: const CustomTabsOptions(
    //     colorScheme: CustomTabsColorScheme.dark,
    //     // toolbarColor: Colors.blue,
    //     // secondaryToolbarColor: Colors.green,
    //     // navigationBarColor: Colors.amber,
    //     shareState: CustomTabsShareState.on,
    //     instantAppsEnabled: true,
    //     showTitle: true,
    //     urlBarHidingEnabled: true,
    //   ),
    //   safariVCOptions: const SafariViewControllerOptions(
    //     barCollapsingEnabled: true,
    //     preferredBarTintColor: Colors.green,
    //     preferredControlTintColor: Colors.amber,
    //     dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
    //     modalPresentationCapturesStatusBarAppearance: true,
    //   ),
    // );
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
