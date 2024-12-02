import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

Widget setSideBarButton(String label, Function() onSelect, bool isSelected,
    {bool isLogout = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isLogout
              ? AppColors.red
              : isSelected
                  ? AppColors.titleText
                  : AppColors.whiteText,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: setRegularText(
            label, isSelected ? AppColors.whiteText : AppColors.titleText, 14),
      ),
    ),
  );
}
