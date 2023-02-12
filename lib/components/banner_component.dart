import 'package:birthday_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerComponent extends StatefulWidget {
  const BannerComponent({Key? key}) : super(key: key);

  @override
  State<BannerComponent> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  late BannerAd bannerAd;

  void loadBanner() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Constants.bannerAdId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AdWidget(ad: bannerAd),
    );
  }
}
