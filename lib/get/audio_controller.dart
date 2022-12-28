import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController{

  Rx<AudioPlayer> audioPlayer = AudioPlayer().obs;
  RxDouble audioDuration = 0.0.obs;
  RxDouble audioPosition = 0.0.obs;

  RxBool isPlaying = false.obs;

  getAudio(String songLink){
    audioPlayer.value.setAudioSource(AudioSource.uri(Uri.parse(songLink)));
  }

}