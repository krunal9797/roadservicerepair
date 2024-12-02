import 'package:flutter/material.dart';

Widget setImageWithSize(String imageName, double? height, double? width) {
  return Image.asset(
    "assets/images/$imageName",
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}

Widget setIconWithSize(String iconName, double? height, double? width) {
  return Image.asset(
    "assets/icons/$iconName",
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}
