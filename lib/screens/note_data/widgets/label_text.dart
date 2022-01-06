import 'package:flutter/material.dart';
import 'package:visual_notes/constants/dimensions.dart';

class LabelText extends StatelessWidget {
  const LabelText({Key? key, required this.label, this.isRequired = false})
      : super(key: key);
  final String label;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: smallPadding),
      child: Text(
        '$label ${isRequired ? '*' : ''}',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
