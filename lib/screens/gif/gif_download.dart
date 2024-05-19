import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/gif_controller/gif_download_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class GifDownload extends StatelessWidget {
  GifDownload({
    Key? key,
    required this.gifLink,
  }) : super(key: key);
  final String gifLink;
  final GIFDownloadController gifDownloadController = Get.put(GIFDownloadController());

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
          "Birthday GIF",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(gifLink),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              return gifDownloadController.isDownloading.value
                  ? Container(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7232FB),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Obx(() {
                          return Text(
                            "${gifDownloadController.downloadProgress.value} %",
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          );
                        }),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        gifDownloadController.askingPermission(gifLink, context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        height: 40,
                        // width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7232FB),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ic_download.png",
                              height: 25,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Download",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Share.share(gifLink);
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF7232FB),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/ic_share.png",
                      height: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          if(gifDownloadController.showAd.value){
            return const BannerComponent();
          }
          return const SizedBox();
        }
      ),
    );
  }
}
