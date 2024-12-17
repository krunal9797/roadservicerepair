import 'package:flutter/material.dart';

class LabelValueRow extends StatelessWidget {
  final String label;
  final String value;

  const LabelValueRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(width: 5),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
