import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    Key? key,
    this.onImagePressed,
    this.image,
    this.isImageError = false,
  }) : super(key: key);
  final VoidCallback? onImagePressed;
  final String? image;
  final bool isImageError;
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    final imgSize =
        isPortrait ? screenSize.width / 2.7 : screenSize.height * .4;

    return InkWell(
      onTap: onImagePressed,
      child: Container(
        height: imgSize,
        width: imgSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: Colors.green,
          border: isImageError ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: image == null || image!.isEmpty
            ? const Icon(Icons.add_a_photo, size: 70, color: Colors.white)
            : ClipRRect(
                borderRadius: BorderRadius.circular(defaultRadius),
                child: Image.file(File(image!), fit: BoxFit.cover)),
      ),
    );
  }
}
