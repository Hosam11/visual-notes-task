import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/app.dart';
import 'package:visual_notes/data/floor/db/services/db_service.dart';
import 'package:visual_notes/data/floor/db/services/note_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fimber.plantTree(DebugTree());
  await Get.putAsync(() => DBService().init(), permanent: false);
  Get.lazyPut(() => NoteService().init());

  runApp(const MyApp());
}
