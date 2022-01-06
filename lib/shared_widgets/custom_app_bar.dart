import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  CustomAppBar({Key? key, required this.title, this.centerTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(title.tr),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
