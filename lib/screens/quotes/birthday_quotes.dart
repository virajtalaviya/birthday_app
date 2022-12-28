import 'package:birthday_app/constants.dart';
import 'package:birthday_app/retrofit_service/model/quotes/quotes_model.dart';
import 'package:birthday_app/screens/quotes/copy_quotes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BirthdayQuotes extends StatefulWidget {
  const BirthdayQuotes({Key? key}) : super(key: key);

  @override
  State<BirthdayQuotes> createState() => _BirthdayQuotesState();
}

class _BirthdayQuotesState extends State<BirthdayQuotes> {
  QuotesModel? quotesModel;
  bool connectedToInternet = true;

  getQuotes() {
    Constants.apiClient.getQuotes()
      ..then((value) {
        setState(() {
          quotesModel = value;
        });
      })
      ..onError((DioError error, stackTrace) {
        if (error.message.contains("SocketException")) {
          setState(() {
            quotesModel = QuotesModel(code: 1, data: [], message: "");
            connectedToInternet = false;
          });
        }
        return QuotesModel(message: "", code: 1, data: []);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
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
      body: quotesModel == null
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF7232FB)))
          : !connectedToInternet
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
                  itemCount: quotesModel!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CopyQuote(
                              quotes: quotesModel!.data![index],
                            ),
                          ),
                        );
                      },
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
                              '''"${quotesModel!.data![index]}"''',
                              style: TextStyle(
                                fontFamily: Constants.fontFamilyMedium,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 40,
                              width: 93,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors
                                    .deepPurpleAccent, //.withOpacity(0.2),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
