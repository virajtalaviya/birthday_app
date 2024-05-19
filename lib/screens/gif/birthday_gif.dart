import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/gif_controller/gif_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthdayGIF extends StatefulWidget {
  const BirthdayGIF({Key? key}) : super(key: key);

  @override
  State<BirthdayGIF> createState() => _BirthdayGIFState();
}

class _BirthdayGIFState extends State<BirthdayGIF> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<GIFController>();
  }
  @override
  Widget build(BuildContext context) {
    final GIFController gifController = Get.put(GIFController());
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
      body: Obx(() {
        return gifController.gotGifs.value == false
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF7232FB)))
            : !gifController.connectedToInternet.value
                ? const Center(
                    child: Text(
                      "Make sure you are connected to internet",
                      style: TextStyle(
                        color: Color(0xFF7232FB),
                        fontSize: 18,
                      ),
                    ),
                  )
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: gifController.gifURLs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      // Random random = Random();
                      return InkWell(
                        onTap: () {
                          gifController.currentIndex = index;
                          gifController.showInterstitial();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(gifController.gifURLs[index]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 5, right: 20, left: 20),
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7232FB),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/ic_download.png",
                                    height: 25,
                                  ),
                                )
                                ),
                          ],
                        ),
                      );
                    },
                  );
      }),
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
