import 'package:birthday_app/screens/home_page.dart';
import 'package:birthday_app/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? preferences;
  bool showOnBoarding = true;

  callPreferences() async {
    preferences = await SharedPreferences.getInstance();
    showOnBoarding = preferences!.getBool("showOnBoarding") ?? true;
    Future.delayed(
      const Duration(seconds: 5),
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

  @override
  void initState() {
    super.initState();
    callPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash_logo.png", height: 200),
      ),
      // body: Column(
      //    mainAxisAlignment: MainAxisAlignment.center,
      //    children: [
      //      Center(
      //        child: Lottie.asset(
      //          "assets/birthday-cake-celebration.json",
      //          height: MediaQuery.of(context).size.height * 0.4,
      //        ),
      //      ),
      //    ],
      //  ),
    );
  }
}
