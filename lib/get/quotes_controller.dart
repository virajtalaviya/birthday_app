import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuotesController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // QuotesModel? quotesModel;
  // Map<String, List<String>>?
  dynamic quotes = {};
  RxBool gotQuotes = false.obs;

  void getQuotes() async {
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
