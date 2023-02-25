import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/image/image_download_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ImageDownload extends StatelessWidget {
  const ImageDownload({Key? key, required this.imageLink}) : super(key: key);
  final String imageLink;

//   @override
//   State<ImageDownload> createState() => _ImageDownloadState();
// }
//
// class _ImageDownloadState extends State<ImageDownload> {
  // download(context) async {
  //   setState(() {
  //     isDownloading = true;
  //   });
  //
  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     String _url = widget.imageLink;
  //     final response = await http.get(Uri.parse(_url));
  //     // Get the image name
  //     String imageName = widget.imageLink.split("/").last;
  //     // final imageName = path.basename(_url);
  //     // Get the document directory path
  //     final appDir = await getExternalStorageDirectory();
  //
  //     final appFolder = Directory('${appDir?.path.split("/Android").first}/BirthDay_Master/');
  //     if (!await appFolder.exists()) {
  //       appFolder.create();
  //     }
  //     // This is the saved image path
  //     // You can use it to display the saved image later.
  //     final localPath = path.join(appFolder.path, imageName);
  //     // Downloading
  //     final imageFile = File(localPath);
  //     await imageFile.writeAsBytes(response.bodyBytes).then((value) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "Image downloaded",
  //             style: TextStyle(fontFamily: Constants.fontFamilyRegular),
  //           ),
  //           duration: const Duration(seconds: 2),
  //           behavior: SnackBarBehavior.floating,
  //           margin: const EdgeInsets.all(10),
  //         ),
  //       );
  //     });
  //     // print('$_url ....songs..Downloaded!...$imageFile');
  //   }
  //   setState(() {
  //     isDownloading = false;
  //   });
  // }

  // bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final ImageDownLoadController imageDownLoadController = Get.put(ImageDownLoadController());
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
          "Birthday Image",
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
                // height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageLink),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              return imageDownLoadController.isDownloading.value == true
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
                            "${imageDownLoadController.downloadProgress.value} %",
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          );
                        }),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        imageDownLoadController.askingPermission(imageLink, context);
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
                Share.share(imageLink);
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
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
