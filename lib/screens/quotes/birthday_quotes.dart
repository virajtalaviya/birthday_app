import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BirthdayQuotes extends StatefulWidget {
  const BirthdayQuotes({Key? key}) : super(key: key);

  @override
  State<BirthdayQuotes> createState() => _BirthdayQuotesState();
}

class _BirthdayQuotesState extends State<BirthdayQuotes> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<QuotesController>();
  }
  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.put(QuotesController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Image.asset(
              "assets/images/ic_back.png",
              height: 27,
            ),
          ),
        ),
        title: Text(
          "Birthday quotes",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: Obx(() {
        return quotesController.gotQuotes.value == false
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF7232FB)))
            : !quotesController.connectedToInternet.value
                ? const Center(
                    child: Text(
                      "Make sure you are connected to internet",
                      style: TextStyle(
                        color: Color(0xFF7232FB),
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    itemCount: quotesController.quotes?["data"]?.length ?? 0, //quotesModel!.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            // border: Border.all(color: Colors.teal, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                quotesController.quotes?["data"]?[index] ?? "...",
                                style: TextStyle(
                                  fontFamily: Constants.fontFamilyMedium,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                    text: quotesController.quotes?["data"]?[index] ?? "...",
                                  )).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Quote copied successfully",
                                          style: TextStyle(fontFamily: Constants.fontFamilyRegular),
                                        ),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(10),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 93,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.deepPurpleAccent, //.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_copy.png",
                                        height: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Copy",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: Constants.fontFamilyRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      }),

      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection("quotes/quotes/data").snapshots(),
      //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     print("----->${snapshot.data?.docs.length ?? "BHAI BHAI"}");
      //     return ListView.builder(
      //       itemBuilder: (context, index) {
      //         return const Text("");
      //       },
      //     );
      //   },
      // ),
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
