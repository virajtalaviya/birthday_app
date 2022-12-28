//
// import 'package:flutter/material.dart';
//
// class MainGridViewScreen extends StatelessWidget {
//   const MainGridViewScreen({
//     Key? key,
//     required this.showMenuIcon,
//     required this.onTap,
//   }) : super(key: key);
//
//   final bool showMenuIcon;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed:onTap,
//           icon: showMenuIcon
//               ? const Icon(Icons.menu, color: Colors.black)
//               : const Icon(Icons.close, color: Colors.black),
//         ),
//         title: const Text(
//           "Happy Birthday",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.share,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(right: 15, left: 15),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 15,
//           ),
//           itemCount: 8,
//           itemBuilder: (context, index) {
//             return AbsorbPointer(
//               absorbing: !showMenuIcon,
//               child: InkWell(
//                 onTap: () {
//
//                 },
//                 child: Container(
//                   decoration: const BoxDecoration(color: Colors.teal,
//                       // shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(color: Colors.grey),
//                       ]),
//                   alignment: Alignment.center,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       // Icon(
//                       //   Constants.content[index].icon,
//                       //   size: 60,
//                       //   color: Colors.white,
//                       // ),
//                       // Text(
//                       //   Constants.content[index]["intro"],
//                       //   style: const TextStyle(
//                       //     color: Colors.white,
//                       //     fontSize: 20,
//                       //   ),
//                       //   textAlign: TextAlign.center,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
