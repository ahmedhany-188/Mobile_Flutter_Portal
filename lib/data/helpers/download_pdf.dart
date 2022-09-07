import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class DownloadPdfHelper{

  String fileUrl;
  String fileName;
  final Dio _dio = Dio();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Function success;
  Function failed;
  DownloadPdfHelper({required this.fileUrl,required this.fileName,required this.success,required this.failed});

  Future<void> requestDownload(String _url, String _name) async {
    await _checkPermission();

    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        // final directory = await getApplicationDocumentsDirectory();
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
        // externalStorageDirPath = await getExternalStorageDirectories().downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      externalStorageDirPath = directory.path;
      // externalStorageDirPath =
      //     (await getApplicationDocumentsDirectory()).absolute.path;
    }


    final dir =
    await getApplicationDocumentsDirectory(); //From path_provider package
    var _localPath = externalStorageDirPath;
    final savedDir = Directory(_localPath!);
    await savedDir.create(recursive: true).then((value) async {
      try {
        String? _taskid = await FlutterDownloader.enqueue(
          url: _url,
          fileName: _name,
          savedDir: _localPath,
          showNotification: true,
          openFileFromNotification: true,
          saveInPublicStorage: true,
        ).then(
                (value) async {
              bool waitTask = true;
              while (waitTask) {
                String query = "SELECT * FROM task WHERE task_id='" + value! +
                    "'";
                var _tasks =
                await FlutterDownloader.loadTasksWithRawQuery(query: query);
                String taskStatus = _tasks![0].status.toString();
                int taskProgress = _tasks[0].progress;
                if (taskStatus == "DownloadTaskStatus(3)" &&
                    taskProgress == 100) {
                  waitTask = false;
                }
              }

              await FlutterDownloader.open(taskId: value!);
              return null;
            });
        print(_taskid);
      } catch (e) {
        print(e);
      }
    });
  }
  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid) {
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


  void _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      failed();
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    const android = AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        priority: Priority.high,
        importance: Importance.max
    );

    const iOS = IOSNotificationDetails();
    const platform = const NotificationDetails(android: android,iOS:  iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess ? '$fileName has been downloaded successfully!' : 'There was an error while downloading the file.',
        platform,
        payload: json
    );
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isIOS) return true;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid) {
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

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      // setState(() {
      //   _progress = (received / total * 100).toStringAsFixed(0) + "%";
      // });
    }
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(
          fileUrl,
          savePath,
          onReceiveProgress: _onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
      failed();
    } finally {
      success();
      // await _showNotification(result);
      if (result['isSuccess']) {
        OpenFile.open(result['filePath']);
      } else {
        failed();
      }
    }
  }

  Future<void> download() async {

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const initSettings = const InitializationSettings(android: android,iOS:  iOS);

    await flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);


    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (Platform.isIOS){
      await requestDownload(fileUrl,fileName);
    }else{
      if (isPermissionStatusGranted) {
        final savePath = path.join(dir!.path, fileName);
        await _startDownload(savePath);
      } else {
        // handle the scenario when user declines the permissions
        failed();
      }
    }


  }
}