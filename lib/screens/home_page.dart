// import 'package:birthday_app/components/drawer_content.dart';
// import 'package:birthday_app/components/main_grid_view_screen.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   final double maxSlide = 120.0;
//
//   AnimationController? animationController;
//
//   void toggle() => animationController!.isDismissed
//       ? animationController!.forward()
//       : animationController!.reverse();
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 300),);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: AnimatedBuilder(
//           animation: animationController!,
//           builder: (context, _) {
//             final slide = maxSlide * animationController!.value;
//             final scale = 1 - (animationController!.value * 0.3);
//             return Stack(
//               children: [
//                 const DrawerContent(),
//                 Transform(
//                   transform: Matrix4.identity()
//                     ..translate(slide)
//                     ..scale(scale),
//                   alignment: Alignment.centerRight,
//                   child: MainGridViewScreen(
//                     onTap: toggle,
//                     showMenuIcon: animationController!.isDismissed,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:birthday_app/constants.dart';
import 'package:birthday_app/screens/age_calculator.dart';
import 'package:birthday_app/screens/gif/birthday_gif.dart';
import 'package:birthday_app/screens/image/birthday_images.dart';
import 'package:birthday_app/screens/quotes/birthday_quotes.dart';
import 'package:birthday_app/screens/songs/birthday_songs.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                "assets/images/splash_logo.png",
                height: 120,
              ),
              const SizedBox(height: 15),
               Text(
                "Birthday Master Pro",
                style: TextStyle(
                  color: const Color(0xFF7232FB),
                  fontFamily: Constants.fontFamilyMedium,
                  fontSize: 20,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: Image.asset(Constants.drawerContent[index].image,
                        height: 25),
                    title: Text(Constants.drawerContent[index].name),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Scaffold.of(context).openDrawer();
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Birthday Master Pro",
          style: TextStyle(
            color: const Color(0xFF7232FB),
            fontFamily: Constants.fontFamilyMedium,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/images/home_screen.png",
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: Constants.content.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AgeCalculator(),
                          ),
                        );

                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BirthdaySongs(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdayImages(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdayGIF(),
                          ),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BirthdayQuotes(),
                          ),
                        );
                        break;
                      case 5:
                        MapsLauncher.launchQuery("Cake shop near me");
                        break;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(-0.7, -0.7),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Constants.content[index].bgColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.content[index].bgColor
                                      .withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                Constants.content[index].icon,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.85, 0.85),
                          child: Text(
                            Constants.content[index].intro,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: Constants.fontFamilyMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}