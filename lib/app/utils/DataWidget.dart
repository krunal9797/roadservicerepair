import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class DataWidget extends StatelessWidget {
  final String label;
  final String phoneNumber;
  final Color labelColor;
  final Color phoneNumberColor;
  final double labelFontSize;
  final double phoneNumberFontSize;

  const DataWidget({
    Key? key,
    required this.label,
    required this.phoneNumber,
    this.labelColor = Colors.black,
    this.phoneNumberColor = Colors.black,
    this.labelFontSize = 14.0,
    this.phoneNumberFontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setSemiText(label, labelColor, labelFontSize),
        const SizedBox(height: 5),
        setRegularText(phoneNumber, phoneNumberColor, phoneNumberFontSize),
        const SizedBox(height: 20),
      ],
    );
  }
}
