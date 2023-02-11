import 'dart:io';

import 'package:birthday_app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownLoadController extends GetxController {
  RxBool isDownloading = false.obs;

  RxInt progress = 0.obs;

  void downloadFile(String url) async {
    final appDir = await getExternalStorageDirectory();
    Directory?  appFolder;
    // try {
    //    appFolder = Directory('${appDir?.path.split("/Android").first}/Download/');
    // } catch (e) {
    //   print("l..................$e");
    // }
    // if (!await appFolder.exists()) {
    //   appFolder.create();
    // }
    String link = url;
    link = link.split("/")[7];
    link = link.replaceAll("%20", " ");
    link = link.replaceAll("%2C", " ");
    link = link.replaceAll("%2F", " ");
    link = link.replaceAll("audio ", "");
    link = link.substring(0, link.indexOf('?'));
    link = link.replaceAll("%40", "@");
    // isDownloading.value = true;
    try {
      Dio().download(
        url,
        appDir?.path,
        onReceiveProgress: (count, total) {
          print("-----$count------------$total---------");
        },
      );
    } catch (e) {
      print("--nnnnnnnnnnnnnnnnnnnnn    $e");
    }
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
}
