import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/screens/notes/notes_controller.dart';
import 'package:visual_notes/screens/notes/widget/note_card.dart';
import 'package:visual_notes/shared_widgets/z_shared_widgets.dart';

// FIXME: remove it later
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

///  responsible for display all notes and delete notes
class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final notesController = Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notesController.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: notesController.onAddPressed,
        child: const Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        title: notes,
      ),
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: notesController.notes.isEmpty
                    ? EmptyWidget(text: emptyNotes)
                    : ListView.builder(
                        itemBuilder: (_, i) => NoteCard(
                          noteEntity: notesController.notes[i],
                        ),
                        itemCount: notesController.notes.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
