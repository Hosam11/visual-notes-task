import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/routes.dart';
import 'package:visual_notes/shared_widgets/z_shared_widgets.dart';
import 'package:get/get.dart';

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
