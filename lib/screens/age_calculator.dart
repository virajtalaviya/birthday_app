import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime currentTime = DateTime.now();
  DateTime? selectedDate;
  String? formattedCurrentDate;
  String? formattedSelectedDate;
  TextEditingController selectDateController = TextEditingController();

  Duration durationDifference = const Duration();
  int days = 00;
  int hours = 00;
  int minutes = 00;
  int seconds = 00;
  int year = 00;
  int months = 00;

  // int currentIndex = 0;
  //
  // InterstitialAd? interstitialAd;
  // int adLoadedNumber = 0;
  //
  // void navigatorFunction() {
  //   // Get.to(() =>);
  // }
  //
  // void showInterstitial() {
  //   if (interstitialAd != null) {
  //     if (Constants.adLoadTimes % 3 == 0) {
  //       interstitialAd?.show();
  //     } else {
  //       navigatorFunction();
  //     }
  //   } else {
  //     navigatorFunction();
  //   }
  // }
  //
  // void loadInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: Constants.interstitialAdId,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (interAd) {
  //         interstitialAd = interAd;
  //         adLoadedNumber = 0;
  //         interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdFailedToShowFullScreenContent: (ad, error) {
  //             ad.dispose();
  //             navigatorFunction();
  //           },
  //           onAdDismissedFullScreenContent: (ad) {
  //             interstitialAd?.dispose();
  //             loadInterstitialAd();
  //             navigatorFunction();
  //           },
  //           onAdClicked: (ad) {},
  //           onAdImpression: (ad) {},
  //           onAdShowedFullScreenContent: (ad) {
  //             Constants.adLoadTimes++;
  //           },
  //         );
  //       },
  //       onAdFailedToLoad: (error) {
  //         adLoadedNumber = adLoadedNumber + 1;
  //         if (adLoadedNumber <= 3) {
  //           loadInterstitialAd();
  //         } else {
  //           Future.delayed(const Duration(seconds: 10), () {
  //             adLoadedNumber = 0;
  //           });
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    formattedCurrentDate = DateFormat('dd-MM-yyyy').format(currentTime);
    setState(() {});
    // loadInterstitialAd();
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
          "Age calculator",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Date of Birth",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF7232FB),
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.fontFamilyRegular,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(DateTime.now().year + 1),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF7232FB),
                            ),
                          ),
                          child: child ?? Container(),
                        );
                      },
                    );
                    if (selectedDate != null) {
                      formattedSelectedDate = DateFormat('dd-MM-yyyy').format(selectedDate!);
                      selectDateController.text = formattedSelectedDate!.replaceAll("-", "/");
                      setState(() {});
                    }
                  },
                  controller: selectDateController,
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.fontFamilyRegular,
                  ),
                  decoration: InputDecoration(
                    focusColor: const Color(0xFF7232FB),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF7232FB),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIconColor: const Color(0xFF7232FB),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      // onPressed: () async {
                      //   selectedDate = await showDatePicker(
                      //     context: context,
                      //     initialDate: DateTime.now(),
                      //     firstDate: DateTime(2000),
                      //     lastDate: DateTime(DateTime.now().year + 1),
                      //   );
                      //   if (selectedDate != null) {
                      //     formattedSelectedDate =
                      //         DateFormat('yyyy-MM-dd').format(selectedDate!);
                      //     selectDateController.text =
                      //         formattedSelectedDate!.replaceAll("-", "/");
                      //     setState(() {});
                      //   }
                      // },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Color(0xFF7232FB),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// date of birth
              Text(
                "Today's Date",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF7232FB),
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.fontFamilyRegular,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(
                    text: formattedCurrentDate!.replaceAll("-", "/"),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.fontFamilyRegular,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null) {
                          durationDifference = currentTime.difference(selectedDate!);
                          days = durationDifference.inDays;
                          hours = durationDifference.inHours;
                          minutes = durationDifference.inMinutes;
                          seconds = durationDifference.inSeconds;
                          year = days ~/ 365;
                          months = (days - year * 365) ~/ 30;
                          days = days - (year * 365) - (months * 30);
                          // months = days ~/ 30;

                          // months = months - (year * 12);

                          setState(() {});
                        }
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF7232FB)),
                          fixedSize: MaterialStateProperty.all(const Size(125, 45))),
                      child: const Text(
                        "Calculate",
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        selectDateController.clear();
                        selectedDate = null;
                        days = 0;
                        hours = 0;
                        minutes = 0;
                        seconds = 0;
                        year = 0;
                        months = 0;
                        setState(() {});
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF7232FB)),
                          fixedSize: MaterialStateProperty.all(const Size(125, 45))),
                      child: const Text(
                        "Clear",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Age",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF7232FB),
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.fontFamilyRegular,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Years",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                        Text(
                          "$year",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7232FB),
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Months",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                        Text(
                          "$months",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7232FB),
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Days",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                        Text(
                          "$days",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7232FB),
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  // border: Border.all(color: Colors.teal, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hours",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                        Text(
                          "$hours",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7232FB),
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Minutes",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                        Text(
                          "$minutes",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF7232FB),
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Seconds",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF7232FB),
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.fontFamilyRegular,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  // border: Border.all(color: Colors.teal, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Seconds",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.fontFamilyRegular,
                      ),
                    ),
                    Text(
                      "$seconds",
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF7232FB),
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.fontFamilyRegular,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
