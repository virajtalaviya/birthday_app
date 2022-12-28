// import 'package:birthday_app/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
//
// class CustomSlider extends StatefulWidget {
//   CustomSlider({
//     Key? key,
//     required this.audioPlayer,
//     required this.positionInDouble,
//     required this.durationInDouble,
//     required this.duration,
//     required this.position,
//   }) : super(key: key);
//   final AudioPlayer audioPlayer;
//   late double positionInDouble;
//   final double durationInDouble;
//   final Duration duration;
//   final Duration position;
//
//   @override
//   State<CustomSlider> createState() => _CustomSliderState();
// }
//
// class _CustomSliderState extends State<CustomSlider> {
//   double currentValue = 0.0;
//   String _printDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//
//       ],
//     );
//   }
// }
