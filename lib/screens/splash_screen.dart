import 'dart:io';

import 'package:birthday_app/constants.dart';
import 'package:birthday_app/screens/home_page.dart';
import 'package:birthday_app/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? preferences;
  bool showOnBoarding = true;

  // final remoteConfig = FirebaseRemoteConfig.instance;

  callPreferences() async {
    preferences = await SharedPreferences.getInstance();
    showOnBoarding = preferences!.getBool("showOnBoarding") ?? true;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (showOnBoarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
    );
  }

  showInternetDialog() async {
    await Future.delayed(const Duration(seconds: 2));
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Internet connectivity!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: Constants.fontFamilyMedium,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Make sure you are connected to internet.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: Constants.fontFamilyRegular,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        checkInternetConnection();
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7232FB),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Ok",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: Constants.fontFamilyRegular,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: Constants.fontFamilyRegular,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // getRemoteConfig();
        callPreferences();
      } else {
        showInternetDialog();
      }
    } on SocketException catch (_) {
      showInternetDialog();
    }
  }

  // getRemoteConfig() async {
  //   try {
  //     await remoteConfig.setConfigSettings(
  //       RemoteConfigSettings(
  //         fetchTimeout: const Duration(seconds: 10),
  //         minimumFetchInterval: const Duration(seconds: 30),
  //       ),
  //     );
  //     await remoteConfig.fetchAndActivate();
  //     Constants.interstitialAdId = remoteConfig.getString("interstitial_ad_id");
  //     Constants.bannerAdId = remoteConfig.getString("banner_ad_id");
  //     callPreferences();
  //   } catch (_) {
  //     callPreferences();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash_logo.png", height: 200),
      ),
    );
  }
}
