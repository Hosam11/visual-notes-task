import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.onChange,
    this.textInputAction,
    this.controller,
    this.isEnabled = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final String? labelText;
  final String? hintText;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      // if number disable copy/past
      enableInteractiveSelection:
          keyboardType == TextInputType.number ? false : true,
      decoration: kTextFieldDecoration.copyWith(
        labelText: labelText,
        hintText: hintText,
      ),
      enabled: isEnabled,
      onSaved: onSaved,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
