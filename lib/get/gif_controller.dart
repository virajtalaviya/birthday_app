import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class GIFController extends GetxController {
  RxBool connectedToInternet = true.obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxList<String> gifURLs = <String>[].obs;
  RxBool gotGifs = false.obs;

  Future getListOfURL() async {
    Reference reference = storage.ref().child("gifs");
    ListResult result = await reference.listAll();
    List<Reference> allFiles = result.items;
    for (int i = 0; i < allFiles.length; i++) {
      final String fileURL = await allFiles[i].getDownloadURL();
      gotGifs.value = true;
      gifURLs.add(fileURL);
    }

    // await Future.forEach<Reference>(allFiles, (file) async {
    //   final String fileURL = await file.getDownloadURL();
    //   gotImages.value = true;
    //   fileURLs.add(fileURL);
    // });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListOfURL();
  }
}
