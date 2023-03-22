import 'dart:isolate';
import 'dart:ui';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_cubit.dart';
import 'package:intl/intl.dart';
import '../../widgets/background/custom_background.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_reset_password_screen.dart';

class PayslipScreen extends StatefulWidget {
  static const routeName = 'payslip-screen';
  // final TargetPlatform? platform;

  const PayslipScreen({Key? key}) : super(key: key);

  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  final _passwordController = TextEditingController();

  final ReceivePort _port = ReceivePort();
  bool showPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    // EasyLoading.dismiss(animation: false);
    _unbindBackgroundIsolate();

    super.dispose();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status,
      int progress) {
    // if (debug) {
    // print(
    //     'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    // }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData.user);
    final FocusNode passwordFocusNode = FocusNode();
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Payslip"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // centerTitle: true,
          ),
          body: BlocConsumer<PayslipCubit, PayslipState>(
            listener: (context, state) {
              if (state.payslipDataEnumStates ==
                  PayslipDataEnumStates.loading) {
                EasyLoading.show(status: 'Loading...',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,);
                // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text("Loading"),
                //   ),
                // );
              }
              else
              if (state.payslipDataEnumStates == PayslipDataEnumStates.failed) {
                EasyLoading.showError(state.error,);
                // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(state.error),
                //   ),
                // );
              }
              else if (state.payslipDataEnumStates ==
                  PayslipDataEnumStates.success) {
                // _requestDownload(state.response);
                // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(state.response),
                //   ),
                // );
                EasyLoading.showSuccess(state.response,);
              }
              else if (state.payslipDataEnumStates ==
                  PayslipDataEnumStates.download) {
                // _requestDownload(state.response);
                EasyLoading.showSuccess(state.response,);
                // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                // ScaffoldMessenger.of(context).showSnackBar(
                //
                //   SnackBar(
                //     content: Text(state.response),
                //   ),
                // );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            // BlocProvider.of<PayslipCubit>(context)
                            //     .openResetLink();
                            Navigator.of(context).pushNamed(
                              PayslipResetPasswordScreen.routeName,
                            );
                          },
                          child: Text(
                            "Reset Payslip Password", style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme
                                .of(context)
                                .highlightColor,
                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      focusNode: passwordFocusNode,
                      cursorColor: Colors.white,
                      key: const Key('loginForm_passwordInput_textField'),
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: showPassword
                              ? const Icon(
                              Icons.visibility,
                              color: Colors.white70
                          )
                              : const Icon(Icons.visibility_off,
                              color: Colors.white38),
                        ),
                        prefixIcon: Icon(
                          Icons.password,
                          color: (passwordFocusNode.hasFocus)
                              ? Colors.white
                              : Colors.white38,
                        ),
                        filled: true,
                        // fillColor: const Color(0xFFcfdeec),
                        hintText: 'Payslip Password',
                        hintStyle: const TextStyle(color: Color(0xFFa2b6c9)),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        // errorText: state.password.invalid ? 'invalid password' : null,
                      ),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // if (_passwordController.text
                        //     .trim()
                        //     .isNotEmpty
                        // ) {
                          // old way to get only the last payslip
                          // BlocProvider.of<PayslipCubit>(context).getPdfLink(
                          //     user ?? User.empty, _passwordController.text.toString());

                          BlocProvider.of<PayslipCubit>(context)
                              .getPayslipAvailableMonths(
                              user ?? User.empty,
                              _passwordController.text.toString());

                          // context.read<PayslipCubit>().getPdfLink("ahmed.elghandour@hassanallam.com", _passwordController.text.toString());
                        // }
                      },
                      // child: const Text("Download Payslip"),
                      child: const Text("Show Payslip"),
                    ),
                    state.months.isNotEmpty ?
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white54),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black12,
                      ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: const [
                                  Text("Num",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  Text("Month",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  Text("View File",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ],),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.months.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.white60,
                                    ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(" ${state.months[index]} ",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Text(" ${DateFormat('MMM').format(
                                                  DateTime(0, int.parse(
                                                      state.months[index])))} ",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<PayslipCubit>(
                                                        context)
                                                        .getPayslipByMonth(
                                                        user ?? User.empty,
                                                        _passwordController.text
                                                            .toString(),
                                                        state.months[index]);
                                                  },
                                                  icon: const Icon(
                                                      Icons.download,
                                                      color: Colors.white
                                                  )
                                              ),]
                                    ),
                                        ),
                                  ],
                                );
                              },
                            )
                          ],
                      ),
                    )
                        : const Text(""),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}