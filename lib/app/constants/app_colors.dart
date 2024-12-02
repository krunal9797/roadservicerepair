import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor appColor = MaterialColor(0xE8E8E8, mainColor);

  static const Color primary = Color.fromRGBO(232, 232, 232, 1.0);
  static const Color whiteText = Color.fromRGBO(239, 245, 245, 1.0);
  static const Color titleText = Color.fromRGBO(13, 15, 14, 1.0);
  static const Color detailText = Color.fromRGBO(197, 199, 198, 1.0);
  static const Color button = Color.fromRGBO(15, 20, 23, 1.0);
  static const Color red = Color.fromRGBO(191, 125, 129, 1.0);
  static const Color green = Color.fromRGBO(185, 216, 200, 1.0);
  static const Color trans = Colors.transparent;
}

Map<int, Color> mainColor = {
  50: const Color.fromRGBO(232, 232, 232, .1),
  100: const Color.fromRGBO(232, 232, 232, .2),
  200: const Color.fromRGBO(232, 232, 232, .3),
  300: const Color.fromRGBO(232, 232, 232, .4),
  400: const Color.fromRGBO(232, 232, 232, .5),
  500: const Color.fromRGBO(232, 232, 232, .6),
  600: const Color.fromRGBO(232, 232, 232, .7),
  700: const Color.fromRGBO(232, 232, 232, .8),
  800: const Color.fromRGBO(232, 232, 232, .9),
  900: const Color.fromRGBO(232, 232, 232, 1),
};
