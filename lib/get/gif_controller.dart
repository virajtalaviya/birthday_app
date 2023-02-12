import 'dart:io';

import 'package:birthday_app/constants.dart';
import 'package:birthday_app/screens/gif/gif_download.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GIFController extends GetxController {
  RxBool connectedToInternet = true.obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxList<String> gifURLs = <String>[].obs;
  RxBool gotGifs = false.obs;
  int currentIndex = 0;

  InterstitialAd? interstitialAd;
  int adLoadedNumber = 0;

  void navigatorFunction() {
    Get.to(() => GifDownload(gifLink: gifURLs[currentIndex]));
  }

  void showInterstitial() {
    if (interstitialAd != null) {
      if (Constants.adLoadTimes % 3 == 0) {
        interstitialAd?.show();
      } else {
        navigatorFunction();
      }
    } else {
      navigatorFunction();
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Constants.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (interAd) {
          interstitialAd = interAd;
          adLoadedNumber = 0;
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              navigatorFunction();
            },
            onAdDismissedFullScreenContent: (ad) {
              interstitialAd?.dispose();
              loadInterstitialAd();
              navigatorFunction();
            },
            onAdClicked: (ad) {},
            onAdImpression: (ad) {},
            onAdShowedFullScreenContent: (ad) {
              Constants.adLoadTimes++;
            },
          );
        },
        onAdFailedToLoad: (error) {
          adLoadedNumber = adLoadedNumber + 1;
          if (adLoadedNumber <= 3) {
            loadInterstitialAd();
          } else {
            Future.delayed(const Duration(seconds: 10), () {
              adLoadedNumber = 0;
            });
          }
        },
      ),
    );
  }

  Future getListOfURL() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectedToInternet.value = true;
      } else {
        connectedToInternet.value = false;
        gotGifs.value = true;
      }
    } on SocketException catch (_) {
      connectedToInternet.value = false;
      gotGifs.value = true;
    }
    Reference reference = storage.ref().child("gifs");
    ListResult result = await reference.listAll();
    List<Reference> allFiles = result.items;
    for (int i = 0; i < allFiles.length; i++) {
      final String fileURL = await allFiles[i].getDownloadURL();
      gotGifs.value = true;
      gifURLs.add(fileURL);
    }

    // await Future.forEach<Reference>(allFiles, (file) async {
    //   final String fileURL = await file.getDownloadURL();
    //   gotImages.value = true;
    //   fileURLs.add(fileURL);
    // });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListOfURL();
    loadInterstitialAd();
  }
}
