import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:visual_notes/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Fimber.plantTree(DebugTree());

  runApp(const MyApp());
}
