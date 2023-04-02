import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:birthday_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GIFDownloadController extends GetxController {
  RxBool isDownloading = false.obs;
  RxInt downloadProgress = 0.obs;
  final ReceivePort _port = ReceivePort();

  void downloadFile(String url) async {
    final appDir = await getExternalStorageDirectory();
    Directory appFolder = Directory('${appDir?.path.split("/Android").first}/Birthday_master/');

    bool dirExist = await appFolder.exists();
    if (!dirExist) {
      appFolder.create();
    }
    String link = url;
    link = link.split("/")[7];
    link = link.replaceAll("%20", " ");
    link = link.replaceAll("%2C", " ");
    link = link.replaceAll("%2F", " ");
    link = link.replaceAll("audio ", "");
    link = link.substring(0, link.indexOf('?'));
    link = link.replaceAll("%40", "@");
    isDownloading.value = true;

    FlutterDownloader.enqueue(
      url: url,
      savedDir: appFolder.path,
      showNotification: false,
    );
  }

  void askingPermission(String url, BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      downloadFile(url);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Storage permission",
              style: TextStyle(
                fontFamily: Constants.fontFamilyMedium,
              ),
            ),
            content: Text(
              "Please grant permission to access storage on your device",
              style: TextStyle(
                fontFamily: Constants.fontFamilyRegular,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    fontFamily: Constants.fontFamilyRegular,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  askingPermission(url, context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontFamily: Constants.fontFamilyRegular,
                  ),
                ),
              ),
            ],
          );
        },
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text(
      //       "Please grant permission to access storage on your device from settings",
      //     ),
      //     behavior: SnackBarBehavior.floating,
      //     margin: const EdgeInsets.all(10),
      //     action: SnackBarAction(label: "Open settings", onPressed: (){}),
      //   ),
      // );
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallBack(String id, DownloadTaskStatus status, int progress) {
    IsolateNameServer.lookupPortByName('downloader_send_port')?.send([id, status.value, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }

    _port.listen((dynamic data) {
      // final taskId = (data as List<dynamic>)[0] as String;
      // final status = DownloadTaskStatus(data[1] as int);
      final progress = data[2] as int;
      downloadProgress.value = progress;
      if (progress == 100) {
        isDownloading.value = false;
        Get.rawSnackbar(
          message: "GIF downloaded successfully",
          margin: const EdgeInsets.all(10),
          dismissDirection: DismissDirection.horizontal,
          borderRadius: 10,
        );
      }
      if (progress < 0) {
        downloadProgress.value = 0;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack, step: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unbindBackgroundIsolate();
  }
}
