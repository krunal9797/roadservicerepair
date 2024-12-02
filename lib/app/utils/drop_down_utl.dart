import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/utils/global.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

Widget setDropDown(
  context,
  String label,
  String placeHolder,
  Key key,
  List<String> arrValues,
  Function(String?) onSelect,

) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: setSemiText(label, AppColors.titleText, 12)),
        const SizedBox(height: 5),
        ShakeWidget(
          key: key,
          child: Container(
            width: getScreenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: AppColors.detailText),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: AppColors.detailText),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DropdownMenu<String>(


                  width: getScreenWidth(context) - 40,
                  hintText: placeHolder,
                  inputDecorationTheme: const InputDecorationTheme(
                    fillColor: AppColors.whiteText,
                    filled: true,
                    border: InputBorder.none,
                    iconColor: AppColors.detailText,
                    suffixIconColor: AppColors.detailText,
                  ),
                  textStyle: const TextStyle(
                    color: AppColors.titleText,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.whiteText),
                    surfaceTintColor:
                        MaterialStateProperty.all(AppColors.whiteText),
                  ),
                  onSelected: onSelect,

                  dropdownMenuEntries:
                      arrValues.map<DropdownMenuEntry<String>>((String value) {
                        print('drop'+arrValues.toString());
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget setDropDown1(
    context,
    String label,
    String placeHolder,
    Key key,
    List<String> arrValues,
    Function(String?) onSelect,
    String? initialValue,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: setSemiText(label, AppColors.titleText, 12)),
        const SizedBox(height: 5),
        ShakeWidget(
          key: key,
          child: Container(
            width: getScreenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: AppColors.detailText),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: AppColors.detailText),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DropdownMenu<String>(


                  width: getScreenWidth(context) - 40,
                  hintText: placeHolder,


                  inputDecorationTheme: const InputDecorationTheme(
                    fillColor: AppColors.whiteText,
                    filled: true,
                    border: InputBorder.none,
                    iconColor: AppColors.detailText,
                    suffixIconColor: AppColors.detailText,
                  ),
                  textStyle: const TextStyle(
                    color: AppColors.titleText,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.whiteText),
                    surfaceTintColor:
                    MaterialStateProperty.all(AppColors.whiteText),
                  ),
                  onSelected: onSelect,


                  dropdownMenuEntries:
                  arrValues.map<DropdownMenuEntry<String>>((String value) {
                    print('drop'+arrValues.toString());
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
