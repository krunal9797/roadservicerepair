import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/utils/global.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

Widget setTextField(
  context,
  String label,
  String placeHolder,
  Key key,
  TextEditingController controller,
  FocusNode focusNode, {
  TextInputType? keyboardType,
  bool? obsecureText,
  Widget? prefix,
  Widget? surfix,
  bool enable = true,
}) {
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
            height: 50,
            width: getScreenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: AppColors.detailText),
            ),
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefix ?? Container(),
                Expanded(
                  child: Container(
                    height: 35,
                    child: CupertinoTextField(
                      enabled: enable,
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      padding: EdgeInsets.zero,
                      obscureText: obsecureText ?? false,
                      style: const TextStyle(
                        color: AppColors.titleText,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      placeholder: placeHolder,
                      placeholderStyle: const TextStyle(
                        color: AppColors.detailText,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.trans,
                      ),
                    ),
                  ),
                ),
                surfix ?? Container(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget setDropdownField(
    BuildContext context,
    String label,
    List<String> items,
    String selectedValue,
    ValueChanged<String?> onChanged, {
      Key? key,
      Widget? prefix,
      Widget? surfix,
      bool enable = true,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: setSemiText(label, AppColors.titleText, 12),
        ),
        const SizedBox(height: 5),
        ShakeWidget(
          key: key,
          child: Container(
            height: 50,
            width: getScreenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: AppColors.detailText),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                prefix ?? Container(),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedValue,
                      items: items
                          .map(
                            (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: AppColors.titleText,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: enable ? onChanged : null,
                    ),
                  ),
                ),
                surfix ?? Container(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget customTextField1({
  required BuildContext context,
  required String label,
  required String placeHolder,
  required Key key,
  required TextEditingController controller,
  required FocusNode focusNode,
  TextInputType? keyboardType,
  bool? obsecureText,
  Widget? prefix,
  Widget? surfix,
  bool enable = true,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(label, style: TextStyle(fontSize: 12, color: Colors.black)),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.grey),
          ),
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              prefix ?? Container(),
              Expanded(
                child: CupertinoTextField(
                  enabled: enable,
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  padding: EdgeInsets.zero,
                  obscureText: obsecureText ?? false,
                  placeholder: placeHolder,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              surfix ?? Container(),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget setTextField1(
    context,
    String label,
    String placeHolder,
    Key key,
    TextEditingController controller,
    FocusNode focusNode, {
      TextInputType? keyboardType,
      bool? obsecureText,
      Widget? prefix,
      Widget? surfix,
      bool enable = true,

    }) {
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
            height: 50,
            width: getScreenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: AppColors.detailText),
            ),
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefix ?? Container(),
                Expanded(
                  child: Container(
                    height: 35,
                    child: CupertinoTextField(
                      enabled: enable,
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      padding: EdgeInsets.zero,
                      readOnly: enable,
                      obscureText: obsecureText ?? false,
                      style: const TextStyle(
                        color: AppColors.titleText,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      placeholder: placeHolder,
                      placeholderStyle: const TextStyle(
                        color: AppColors.detailText,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.trans,
                      ),
                    ),
                  ),
                ),
                surfix ?? Container(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget setTextFormField(
  context,
  String label,
  String placeHolder,
  Key key,
  TextEditingController controller,
  FocusNode focusNode, {
  TextInputType? keyboardType,
  bool? obsecureText,
  Widget? prefix,
  Widget? surfix,
  bool enable = true,
}) {
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
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefix ?? Container(),
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    maxLines: 4,
                    enabled: enable,
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: keyboardType,
                    padding: EdgeInsets.zero,
                    obscureText: obsecureText ?? false,
                    style: const TextStyle(
                      color: AppColors.titleText,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    placeholder: placeHolder,
                    placeholderStyle: const TextStyle(
                      color: AppColors.detailText,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.trans,
                    ),
                  ),
                ),
                surfix ?? Container(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Widget setTextFormField1(
    context,
    String label,
    String placeHolder,
    Key key,
    TextEditingController controller,
    FocusNode focusNode, {
      TextInputType? keyboardType,
      bool? obsecureText,
      Widget? prefix,
      Widget? surfix,
      bool enable = true,
    }) {
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
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefix ?? Container(),
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    maxLines: 4,

                    enabled: enable,
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: keyboardType,
                    padding: EdgeInsets.zero,
                    readOnly: enable,
                    obscureText: obsecureText ?? false,
                    style: const TextStyle(
                      color: AppColors.titleText,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    placeholder: placeHolder,
                    placeholderStyle: const TextStyle(
                      color: AppColors.detailText,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.trans,
                    ),
                  ),
                ),
                surfix ?? Container(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
