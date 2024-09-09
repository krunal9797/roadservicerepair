import 'package:flutter/material.dart';

Widget setRegularText(String text, Color color, double fontSize,
    {int? maxLines, TextAlign? textAlign, TextDecoration? textDecoration, TextOverflow? overflow}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      decoration: textDecoration,
    ),
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
  );
}

Widget setMediumText(String text, Color color, double fontSize,
    {int? maxLines, TextAlign? textAlign, TextDecoration? textDecoration, TextOverflow? overflow}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      decoration: textDecoration,
    ),
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
  );
}

Widget setSemiText(String text, Color color, double fontSize,
    {int? maxLines, TextAlign? textAlign, TextDecoration? textDecoration, TextOverflow? overflow}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: textDecoration,
    ),
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
  );
}

Widget setBoldText(String text, Color color, double fontSize,
    {int? maxLines, TextAlign? textAlign, TextDecoration? textDecoration, TextOverflow? overflow}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      decoration: textDecoration,
    ),
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: overflow,
  );
}
