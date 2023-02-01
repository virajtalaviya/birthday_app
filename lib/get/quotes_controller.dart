import 'package:birthday_app/retrofit_service/model/quotes/quotes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuotesController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  QuotesModel? quotesModel;
  // Map<String, dynamic>? quotes = {};
  RxBool gotQuotes = false.obs;

  void getQuotes() async {
    DocumentReference<Map<String, dynamic>> path = fireStore.collection("quotes").doc("quotes");

    DocumentSnapshot docData = await path.get();
    // quotes = docData.data() as Map<String, dynamic>;
    quotesModel = QuotesModel.fromJson(docData.data() as Map<String, dynamic>);
    gotQuotes.value = true;
    // .then((value) {
    //   quotes = value.data();
    //   gotQuotes.value = true;
    // });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getQuotes();
  }
}
