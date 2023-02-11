import 'dart:io';

import 'package:birthday_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PlaySong extends StatefulWidget {
  const PlaySong({
    Key? key,
    required this.name,
    required this.songLink,
  }) : super(key: key);
  final String name;
  final String songLink;

  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  final audioPlayer = AudioPlayer();
  bool isDownloading = false;

  download(context) async {
    setState(() {
      isDownloading = true;
    });
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String _url = widget.songLink;
      final response = await http.get(Uri.parse(_url));
      // Get the image name
      String link = widget.songLink;
      link = link.split("/")[7];
      link = link.replaceAll("%20", " ");
      link = link.replaceAll("%2C", " ");
      link = link.replaceAll("%2F", " ");
      link = link.replaceAll("audio ", "");
      // link = link.substring(0, link.indexOf('.mp3'));
      link = link.replaceAll("%40", "@");
      link = link.split("?alt")[0];
      // final imageName = path.basename(_url);
      // Get the document directory path
      final appDir = await getExternalStorageDirectory();

      final appFolder = Directory('${appDir?.path.split("/Android").first}/BirthDay_Master/');
      if (!await appFolder.exists()) {
        appFolder.create();
      }
      // This is the saved image path
      // You can use it to display the saved image later.
      print("========   file name =======$link========");
      final localPath = path.join(appFolder.path, link);
      // Downloading
      final imageFile = File(localPath);
      await imageFile.writeAsBytes(response.bodyBytes).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Song downloaded",
              style: TextStyle(fontFamily: Constants.fontFamilyRegular),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
          ),
        );
      });
      // print('$_url ....songs..Downloaded!...$imageFile');
    }
    setState(() {
      isDownloading = false;
    });
  }

  // AudioController audioController = Get.put(AudioController());

  double audioDurationInDouble = 0.0;
  double audioPositionInDouble = 0.0;

  Duration duration = const Duration();
  Duration position = const Duration();

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // audioController.getAudio(widget.songLink);
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.songLink)));
    // audioDurationInDouble = audioPlayer.duration?.inSeconds.toDouble() ?? 0.0;

    audioPlayer.durationStream.listen((event) {
      audioDurationInDouble = audioPlayer.duration?.inSeconds.toDouble() ?? 0.0;
      duration = audioPlayer.duration ?? const Duration();
      if (mounted) {
        setState(() {});
      }
    });
    audioPlayer.positionStream.listen((event) {
      audioPositionInDouble = audioPlayer.position.inSeconds.toDouble();
      position = audioPlayer.position;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    // audioController.audioPlayer.value.pause();
    // audioController.audioPlayer.value.dispose();
  }

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
          "Birthday song",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              widget.name,
              style: TextStyle(
                fontFamily: Constants.fontFamilyMedium,
                fontSize: 17,
              ),
            ),
            // CustomSlider(
            //   audioPlayer: audioPlayer,
            //   duration: duration,
            //   position: position,
            //   durationInDouble: audioDurationInDouble,
            //   positionInDouble: audioPositionInDouble,
            // ),
            Slider(
              value: audioPositionInDouble,
              min: 0.0,
              max: audioDurationInDouble,
              onChanged: (value) {
                setState(() {
                  audioPositionInDouble = value;
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
              activeColor: const Color(0xFF7232FB),
              inactiveColor: Colors.deepPurpleAccent.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _printDuration(position),
                    style: TextStyle(
                      fontFamily: Constants.fontFamilyRegular,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    _printDuration(duration),
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
                // if (audioController.audioPlayer.value.playing) {
                //   audioController.audioPlayer.value.pause();
                //   audioController.isPlaying.value = false;
                // } else {
                //   audioController.audioPlayer.value.play();
                //   audioController.isPlaying.value = true;
                // }
                if (audioPlayer.playing) {
                  audioPlayer.pause();
                } else {
                  audioPlayer.play();
                }
                setState(() {});
              },
              child: audioPlayer.playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              // child : Obx(() {
              //   return audioController.isPlaying.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow);
              // }),
              backgroundColor: const Color(0xFF7232FB),
            ),
            const SizedBox(height: 20),
            isDownloading
                ? const CircularProgressIndicator(
                    color: Color(0xFF7232FB),
                  )
                : InkWell(
                    onTap: () {
                      download(context);
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
                  ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Share.share(widget.songLink);
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
          ],
        ),
      ),
    );
  }
}
