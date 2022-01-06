import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.hasSize = true,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final bool hasSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize:
            hasSize ? Size(MediaQuery.of(context).size.width, 40) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
      child: Text(title),
    );
  }
}
