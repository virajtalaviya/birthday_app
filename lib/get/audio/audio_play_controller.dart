import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:birthday_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayController extends GetxController {
  final audioPlayer = AudioPlayer();
  RxInt downloadProgress = 0.obs;

  RxBool showAd = true.obs;

  var data = Get.arguments;
  RxBool isPlaying = false.obs;

  RxDouble audioDurationInDouble = 0.0.obs;
  RxDouble audioPositionInDouble = 0.0.obs;

  Rx<Duration> duration = const Duration().obs;
  Rx<Duration> position = const Duration().obs;

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  RxBool isDownloading = false.obs;

  RxInt progress = 0.obs;
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
    BuildContext secondContext = context;
    if (await Permission.storage.isGranted == false) {
      showAd.value = false;
    }
    final status = await Permission.storage.request();
    if (status.isGranted) {
      downloadFile(url);
      showAd.value = true;
    } else {
      showAd.value = false;
      await showDialog(
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
                  Navigator.pop(context);
                  askingPermission(url, secondContext);
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
      showAd.value = true;
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
      final progress = data[2] as int;
      downloadProgress.value = progress;
      if (progress == 100) {
        isDownloading.value = false;
        Get.rawSnackbar(
          message: "Audio downloaded successfully",
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

  void initAudio() {
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(data)));

    audioPlayer.durationStream.listen((event) {
      audioDurationInDouble.value = audioPlayer.duration?.inSeconds.toDouble() ?? 0.0;
      duration.value = audioPlayer.duration ?? const Duration();
    });
    audioPlayer.positionStream.listen((event) {
      audioPositionInDouble.value = audioPlayer.position.inSeconds.toDouble();
      position.value = audioPlayer.position;
      if (duration.value == position.value) {
        audioPlayer.pause();
        isPlaying.value = false;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initAudio();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack, step: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    _unbindBackgroundIsolate();
  }
}
