
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPdfHelper{
  Future<void> requestDownload(String _url, String _name) async {
    await _checkPermission();

    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
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
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
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
                await FlutterDownloader.open(taskId: value);
              }
            }

          });


      print(_taskid);
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
}