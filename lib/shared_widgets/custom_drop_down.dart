import 'package:flutter/material.dart';
import 'package:visual_notes/constants/styles.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    this.mValidator,
    this.mOnChanged,
    this.mOnSaved,
    this.listItem,
    this.value,
  }) : super(key: key);

  final String? Function(T?)? mValidator;
  final void Function(T?)? mOnChanged;
  final void Function(T?)? mOnSaved;
  final List<T>? listItem;
  final T? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: listItem
          ?.map<DropdownMenuItem<T>>((T value) =>
              DropdownMenuItem<T>(value: value, child: Text('$value')))
          .toList(),
      onChanged: mOnChanged,
      onSaved: mOnSaved,
      decoration: kTextFieldDecoration,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      validator: mValidator,
    );
  }
}
