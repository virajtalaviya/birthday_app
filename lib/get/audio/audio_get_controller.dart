import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  RxBool connectedToInternet = true.obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxList<Map<String, String>> audioURLs = <Map<String, String>>[].obs;
  RxBool gotAudio = false.obs;

  Future getListOfAudio() async {
    try {
      Reference reference = storage.ref().child("audio");
      ListResult result = await reference.listAll();
      List<Reference> allFiles = result.items;
      for (int i = 0; i < allFiles.length; i++) {
        final String fileURL = await allFiles[i].getDownloadURL();
        gotAudio.value = true;
        String link = fileURL;
        link = link.split("/")[7];
        link = link.replaceAll("%20", " ");
        link = link.replaceAll("%2C", " ");
        link = link.replaceAll("%2F", " ");
        link = link.replaceAll("audio ", "");
        link = link.substring(0, link.indexOf('.mp3'));
        link = link.replaceAll("%40", "@");
        audioURLs.add({
          "name": link,
          "audioLink": fileURL,
        });
      }
    } on SocketException catch (_) {
      connectedToInternet.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListOfAudio();
  }
}
