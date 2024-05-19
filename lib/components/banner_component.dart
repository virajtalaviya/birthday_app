import 'dart:developer';

import 'package:birthday_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerComponent extends StatefulWidget {
  const BannerComponent({Key? key}) : super(key: key);

  @override
  State<BannerComponent> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  int loadAttempt = 0;

  late BannerAd _bannerAd;
  bool adLoaded = false;

  void loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Constants.bannerAdId,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          if (loadAttempt < 3) {
            loadBannerAd();
          }
        },
        onAdLoaded: (ad) {
          setState(() {
            adLoaded = true;
          });
        },
      ),
      request: const AdRequest(),
    );

    _bannerAd.load();
    loadAttempt++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Constants.bannerAdId != "") {
      loadBannerAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("---$adLoaded");
    return SizedBox(
      height: Constants.bannerAdId != "" && adLoaded ? 50 : 0,
      child: adLoaded ? AdWidget(ad: _bannerAd) : const SizedBox(),
    );
  }
}
