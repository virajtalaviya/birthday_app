import 'package:birthday_app/retrofit_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Constants {
  static ApiClient apiClient =
      ApiClient(Dio(BaseOptions(contentType: "application/json")));
  static String fontFamilyMedium = "Heebo-Medium";
  static String fontFamilyRegular = "Heebo-Regular";
  static List<GridContent> content = [
    GridContent(
      bgColor: const Color(0xFFF43865),
      icon: "assets/images/home_grid/ic_calculator.png",
      intro: "Age\nCalculator",
    ),
    GridContent(
      bgColor: const Color(0xFF38C7F4),
      icon: "assets/images/home_grid/ic_birthdaysongs.png",
      intro: "Birthday\nSongs",
    ),
    GridContent(
      bgColor: const Color(0xFF08C955),
      icon: "assets/images/home_grid/ic_birthdayimages.png",
      intro: "Birthday\nImages",
    ),
    GridContent(
      bgColor: const Color(0xFFFFB800),
      icon: "assets/images/home_grid/ic_birthdaygif.png",
      intro: "Birthday\nGIF",
    ),
    GridContent(
      bgColor: const Color(0xFF386DF4),
      icon: "assets/images/home_grid/ic_birthdayquote.png",
      intro: "Birthday\nquotes",
    ),
    GridContent(
      bgColor: const Color(0xFFFF5722),
      icon: "assets/images/home_grid/ic_cakeshop.png",
      intro: "Cake Shops\nNear you",
    ),
  ];

  static List<DrawerContent> drawerContent = [
    DrawerContent(
      image: "assets/drawer/ic_share.png",
      name: "Share app",
    ),
    DrawerContent(
      image: "assets/drawer/ic_rateus.png",
      name: "Rate us",
    ),
    DrawerContent(
      image: "assets/drawer/ic_moreapps.png",
      name: "More Apps",
    ),
    DrawerContent(
      image: "assets/drawer/ic_privacypolicy.png",
      name: "Privacy Policy",
    ),
  ];
}

class GridContent {
  Color bgColor;
  String icon;
  String intro;

  GridContent({
    required this.bgColor,
    required this.icon,
    required this.intro,
  });
}

class DrawerContent {
  String name;
  String image;

  DrawerContent({
    required this.name,
    required this.image,
  });
}
