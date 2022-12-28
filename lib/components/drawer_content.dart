// import 'package:flutter/material.dart';
//
// class DrawerContent extends StatefulWidget {
//   const DrawerContent({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerContent> createState() => _DrawerContentState();
// }
//
// class _DrawerContentState extends State<DrawerContent> {
//   List drawerContant = [
//     {
//       "icon": Icons.share,
//       "title": "Share App",
//     },
//     {
//       "icon": Icons.star,
//       "title": "Rate Us",
//     },
//     {
//       "icon": Icons.more,
//       "title": "More Apps",
//     },
//     {
//       "icon": Icons.privacy_tip,
//       "title": "Privacy Policy",
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal,
//       body: Center(
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: drawerContant.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Icon(
//                 drawerContant[index]["icon"],
//                 color: Colors.amber,
//               ),
//               title: Text(
//                 drawerContant[index]["title"],
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
