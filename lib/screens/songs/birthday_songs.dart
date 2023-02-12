import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/audio/audio_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthdaySongs extends StatelessWidget {
  BirthdaySongs({Key? key}) : super(key: key);
  final AudioController audioController = Get.put(AudioController());

//
//   @override
//   State<BirthdaySongs> createState() => _BirthdaySongsState();
// }
//
// class _BirthdaySongsState extends State<BirthdaySongs> {
  // SongsModel? songsModel;
  // bool connectedToInternet = true;
  //
  // getSongs() {
  //   Constants.apiClient.getSongs()
  //     ..then((value) {
  //       setState(() {
  //         songsModel = value;
  //       });
  //     })
  //     ..onError((DioError error, stackTrace) {
  //       if (error.message.contains("SocketException")) {
  //         setState(() {
  //           songsModel = SongsModel(code: 1, data: [], message: "");
  //           connectedToInternet = false;
  //         });
  //       }
  //       return SongsModel(code: 0, message: "", data: []);
  //     });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getSongs();
  // }

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
          "Birthday Songs",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: Obx(() {
        return audioController.gotAudio.value == false
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF7232FB)))
            : !audioController.connectedToInternet.value
                ? const Center(
                    child: Text(
                      "Make sure you are connected to internet",
                      style: TextStyle(
                        color: Color(0xFF7232FB),
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    itemCount: audioController.audioURLs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            audioController.currentIndex = index;
                            audioController.showInterstitial();
                          },
                          leading: Image.asset(
                            "assets/images/ic_music.png",
                            height: 35,
                            width: 35,
                          ),
                          title: Text(
                            "${audioController.audioURLs[index]["name"]}",
                            style: TextStyle(
                              fontFamily: Constants.fontFamilyRegular,
                            ),
                          ),
                        ),
                      );
                    },
                  );
      }),
      bottomNavigationBar: const BannerComponent(),
    );
  }
}
