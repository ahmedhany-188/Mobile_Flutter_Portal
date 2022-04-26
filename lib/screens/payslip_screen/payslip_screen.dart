import 'dart:isolate';
import 'dart:ui';
import 'dart:io' show Directory, Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hassanallamportalflutter/bloc/payslip_screen_bloc/payslip_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_path_provider/android_path_provider.dart';

class PayslipScreen extends StatefulWidget {
  static const routeName = 'payslip-screen';
  // final TargetPlatform? platform;

  PayslipScreen({Key? key}) : super(key: key);

  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  final _passwordController = TextEditingController();


  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });
    FlutterDownloader.registerCallback(downloadCallback);

    // _prepare();
    // _checkPermission();
    //  _checkPermission();
    //
    // if (_permissionReady) {
    //   // await _prepareSaveDir();
    // }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _unbindBackgroundIsolate();
    super.dispose();
  }
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    // }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Payslip"),
        centerTitle: true,
      ),
      body: BlocConsumer<PayslipCubit, PayslipState>(
        listener: (context, state) {
          if (state is PayslipLoadingState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Loading"),
              ),
            );
          }
          else if (state is PayslipErrorState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is PayslipSuccessState) {
            // _requestDownload(state.response);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response),
              ),
            );
          }else if (state is PayslipDownloadState) {
            // _requestDownload(state.response);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(
                content: Text(state.response),
              ),
            );
          }
        },
        builder: (context, state) {
          // if (state is PayslipLoadingState) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // else if (state is PayslipErrorState) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.error),
          //     ),
          //   );
          // }
          // else if (state is PayslipSuccessState || state is PayslipInitialState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(

                children: [
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      if (_passwordController.text.isNotEmpty) {
                        BlocProvider.of<PayslipCubit>(context).getPdfLink("ahmed.elghandour@hassanallam.com", _passwordController.text.toString());
                        // context.read<PayslipCubit>().getPdfLink("ahmed.elghandour@hassanallam.com", _passwordController.text.toString());
                      }
                    },
                    child: const Text("Download Payslip"),
                  )
                ],
              ),
            );
          // }
          // else {
          //   return Container();
          // }
        },

      ),
    );
  }


}