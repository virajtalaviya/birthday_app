import 'dart:io';

import 'package:birthday_app/constants.dart';
import 'package:birthday_app/screens/image/image_download.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ImageController extends GetxController {
  RxBool connectedToInternet = true.obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  RxList<String> fileURLs = <String>[].obs;
  RxBool gotImages = false.obs;

  int currentIndex = 0;

  InterstitialAd? interstitialAd;
  int adLoadedNumber = 0;

  void navigatorFunction() {
    Get.to(() => ImageDownload(imageLink: fileURLs[currentIndex]));
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
    Constants.adLoadTimes++;
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
              interstitialAd = null;
              loadInterstitialAd();
              navigatorFunction();
            },
            onAdDismissedFullScreenContent: (ad) {
              interstitialAd?.dispose();
              interstitialAd = null;
              loadInterstitialAd();
              navigatorFunction();
            },
            onAdClicked: (ad) {},
            onAdImpression: (ad) {},
            onAdShowedFullScreenContent: (ad) {

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
        gotImages.value = true;
      }
    } on SocketException catch (_) {
      connectedToInternet.value = false;
      gotImages.value = true;
    }
    Reference reference = storage.ref().child("images");
    ListResult result = await reference.listAll();
    List<Reference> allFiles = result.items;
    for (int i = 0; i < allFiles.length; i++) {
      final String fileURL = await allFiles[i].getDownloadURL();
      gotImages.value = true;
      fileURLs.add(fileURL);
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
    if(Constants.interstitialAdId != ""){
      loadInterstitialAd();
    }
  }
}
