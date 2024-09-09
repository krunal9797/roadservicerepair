import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';

Widget setButton(Function() onPressed, Widget child, Color backgroundColor,
    double width, double height,
    {double? borderRadius}) {
  return ElevatedButton(
    style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(width, height)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.black54),
        overlayColor: MaterialStateProperty.all(AppColors.trans)),
    onPressed: onPressed,
    child: child,
  );
}

Widget setTextButton(
  Function() onPressed,
  Widget child,
) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.trans),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shadowColor: MaterialStateProperty.all(AppColors.trans),
      overlayColor: MaterialStateProperty.all(AppColors.trans),
      surfaceTintColor: MaterialStateProperty.all(AppColors.trans),
    ),
    onPressed: onPressed,
    child: child,
  );
}

Widget setIconButton(
  Function() onPressed,
  Widget child, {
  double? width,
  double? height,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(width ?? 24, height ?? 24)),
      backgroundColor: MaterialStateProperty.all(AppColors.trans),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      shadowColor: MaterialStateProperty.all(AppColors.trans),
      overlayColor: MaterialStateProperty.all(AppColors.trans),
      surfaceTintColor: MaterialStateProperty.all(AppColors.trans),
    ),
    onPressed: onPressed,
    child: child,
  );
}
