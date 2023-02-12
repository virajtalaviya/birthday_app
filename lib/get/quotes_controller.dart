import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuotesController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool connectedToInternet = true.obs;

  // QuotesModel? quotesModel;
  // Map<String, List<String>>?
  dynamic quotes = {};
  RxBool gotQuotes = false.obs;

  void getQuotes() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectedToInternet.value = true;
      } else {
        connectedToInternet.value = false;
        gotQuotes.value = true;
      }
    } on SocketException catch (_) {
      connectedToInternet.value = false;
      gotQuotes.value = true;
    }
    DocumentReference<Map<String, dynamic>> path = fireStore.collection("quotes").doc("quotes");
    DocumentSnapshot docData = await path.get();
    quotes = docData.data();
    gotQuotes.value = true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getQuotes();
  }
}
