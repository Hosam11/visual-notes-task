import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';

const screenPadding = EdgeInsets.all(mediumPadding);

const kInputDecorationContentPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 20.0,
);

final kTextFieldDecoration = InputDecoration(
  // labelStyle: kFontLabelStyle,
  contentPadding: kInputDecorationContentPadding,
  fillColor: kHintColor,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultRadius),
  ),
);

final dialogShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius));
