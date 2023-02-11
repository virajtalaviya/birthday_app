import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/screens/age_calculator.dart';
import 'package:birthday_app/screens/gif/birthday_gif.dart';
import 'package:birthday_app/screens/image/birthday_images.dart';
import 'package:birthday_app/screens/quotes/birthday_quotes.dart';
import 'package:birthday_app/screens/songs/birthday_songs.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maps_launcher/maps_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // late BannerAd bannerAd;
  //
  // void loadBanner() {
  //   bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: "ca-app-pub-3940256099942544/6300978111",
  //     listener: const BannerAdListener(),
  //     request: const AdRequest(),
  //   );
  //   bannerAd.load();
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadBanner();
  // }

  InterstitialAd? interstitialAd;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          print("============ad loaded");
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, error) {
              print("1111111111111111111");
            },
            onAdDismissedFullScreenContent: (ad) {
              print("2222222222222222222");
              interstitialAd?.dispose();
              print("------------  disposed  ");
              loadInterstitialAd();
            },
            onAdClicked: (ad) {
              print("3333333333333333333");
            },
            onAdImpression: (ad) {
              print("44444444444444444444");
            },
            onAdShowedFullScreenContent: (ad) {
              print("555555555555555555555");
            },
            onAdWillDismissFullScreenContent: (ad) {
              print("66666666666666666666666");
            },
          );
        },
        onAdFailedToLoad: (error) {
          print("==================${error.message}");
          loadInterstitialAd();
        },
      ),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                "assets/images/splash_logo.png",
                height: 120,
              ),
              const SizedBox(height: 15),
              Text(
                "Birthday Master Pro",
                style: TextStyle(
                  color: const Color(0xFF7232FB),
                  fontFamily: Constants.fontFamilyMedium,
                  fontSize: 20,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Constants.drawerContent.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: Image.asset(
                      Constants.drawerContent[index].image,
                      height: 25,
                    ),
                    title: Text(Constants.drawerContent[index].name),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Scaffold.of(context).openDrawer();
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Birthday Master Pro",
          style: TextStyle(
            color: const Color(0xFF7232FB),
            fontFamily: Constants.fontFamilyMedium,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/images/home_screen.png",
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: Constants.content.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (interstitialAd != null) {
                      interstitialAd?.show();
                    }

                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AgeCalculator(),
                          ),
                        );

                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdaySongs(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdayImages(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdayGIF(),
                          ),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BirthdayQuotes(),
                          ),
                        );
                        break;
                      case 5:
                        MapsLauncher.launchQuery("Cake shop near me");
                        break;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(-0.7, -0.7),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Constants.content[index].bgColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.content[index].bgColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                Constants.content[index].icon,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.85, 0.85),
                          child: Text(
                            Constants.content[index].intro,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: Constants.fontFamilyMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
