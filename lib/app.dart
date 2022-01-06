import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: appName,
      initialRoute: notesScreen,
      getPages: pages,
      theme: ThemeData(primarySwatch: kPrimaryColor),
    );
  }
}

// to enables scrolling with tools like "Vysor" or "Scrcpy"
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
      };
}
