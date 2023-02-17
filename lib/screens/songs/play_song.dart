import 'package:birthday_app/components/banner_component.dart';
import 'package:birthday_app/constants.dart';
import 'package:birthday_app/get/audio/audio_play_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PlaySong extends StatelessWidget {
  const PlaySong({
    Key? key,
    required this.name,
    required this.songLink,
  }) : super(key: key);
  final String name;
  final String songLink;

  @override
  Widget build(BuildContext context) {
    final AudioPlayController audioController = Get.put(AudioPlayController());
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
          "Birthday song",
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
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/ic_music.png"),
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: Constants.fontFamilyMedium,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            // CustomSlider(
            //   audioPlayer: audioPlayer,
            //   duration: duration,
            //   position: position,
            //   durationInDouble: audioDurationInDouble,
            //   positionInDouble: audioPositionInDouble,
            // ),
            Obx(() {
              return Slider(
                value: audioController.audioPositionInDouble.value,
                min: 0.0,
                max: audioController.audioDurationInDouble.value,
                onChanged: (value) {
                  audioController.audioPositionInDouble.value = value;
                  audioController.audioPlayer.seek(Duration(seconds: value.toInt()));
                },
                activeColor: const Color(0xFF7232FB),
                inactiveColor: Colors.deepPurpleAccent.withOpacity(0.2),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    audioController.printDuration(audioController.position.value),
                    style: TextStyle(
                      fontFamily: Constants.fontFamilyRegular,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    audioController.printDuration(audioController.duration.value),
                    style: TextStyle(
                      fontFamily: Constants.fontFamilyRegular,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (audioController.audioPlayer.playing) {
                  audioController.audioPlayer.pause();
                  audioController.isPlaying.value = false;
                } else {
                  audioController.audioPlayer.play();
                  audioController.isPlaying.value = true;
                }
                //   if (audioPlayer.playing) {
                //     audioPlayer.pause();
                //   } else {
                //     audioPlayer.play();
                //   }
                //   setState(() {});
                // },
                // child: audioPlayer.playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              },
              child: Obx(() {
                return audioController.isPlaying.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow);
              }),
              backgroundColor: const Color(0xFF7232FB),
            ),
            const SizedBox(height: 20),

            Obx(() {
              return audioController.isDownloading.value
                  ? const CircularProgressIndicator(
                      color: Color(0xFF7232FB),
                    )
                  : InkWell(
                      onTap: () {
                        audioController.askingPermission(songLink, context);
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

            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Share.share(songLink);
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
