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
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    _permissionReady = false;

    // _prepare();
    // _checkPermission();
    //  _checkPermission();
    //
    // if (_permissionReady) {
    //   // await _prepareSaveDir();
    // }

  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  void _requestDownload(String link) async {
    final task = await FlutterDownloader.enqueue(
      url: link,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }
  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // if (debug) {
      print('UI Isolate Callback: $data');
      // }
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      // if (_tasks != null && _tasks!.isNotEmpty) {
      //   final task = _tasks!.firstWhere((task) => task.taskId == id);
      //   setState(() {
      //     task.status = status;
      //     task.progress = progress;
      //   });
      // }
    });
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Loading"),
              ),
            );
          }
          else if (state is PayslipErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          else if (state is PayslipSuccessState) {
            // _requestDownload(state.response);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response),
              ),
            );
          }else if (state is PayslipDownloadState) {
            // _requestDownload(state.response);
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