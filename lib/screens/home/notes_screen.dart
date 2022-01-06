import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/routes.dart';
import 'package:visual_notes/shared_widgets/z_shared_widgets.dart';

// FIXME: remove it later
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

///  responsible for display all notes and delete notes
class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(noteDataScreen),
        child: const Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        title: notes,
      ),
      body: Container(),
    );
  }
}
