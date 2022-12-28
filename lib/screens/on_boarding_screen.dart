import 'package:birthday_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  SharedPreferences? preferences;

  callPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callPreferences();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Text(
                "Birthday Master Pro",
                style: TextStyle(color: Color(0xFF7232FB), fontSize: 22),
              ),
            ),
            Image.asset("assets/images/on_boarding.png", height: 200),
            Text(
              "New and creative concept of birthday \nwishes for your loved ones,\nfamily and friends",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                preferences!.setBool("showOnBoarding", false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF7232FB)),
                  fixedSize: MaterialStateProperty.all(const Size(125, 40))),
              child: const Text(
                "START",
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   color: Colors.amber,
      // ),
    );
  }
}
