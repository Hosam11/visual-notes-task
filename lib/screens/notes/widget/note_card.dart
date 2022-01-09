import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';
import 'package:visual_notes/screens/note_data/note_data_controller.dart';
import 'package:visual_notes/screens/notes/notes_controller.dart';
import 'package:visual_notes/shared_widgets/custom_button.dart';
import 'package:get/get.dart';

// FIXME: remove it later
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
class NoteCard extends StatelessWidget {
  NoteCard({Key? key, required this.noteEntity}) : super(key: key);
  final NoteEntity noteEntity;
  final notesController = Get.find<NotesController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final imageSize = isPortrait ? size.width * .4 : size.height * .3;
    return Padding(
      padding: const EdgeInsets.only(bottom: smallPadding),
      child: Card(
        shape: defaultShape,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------------- Image ----------------
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultRadius),
                topRight: Radius.circular(defaultRadius),
              ),
              child: Image.file(
                File(noteEntity.imagePath),
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(mediumPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- Title & id ----------------
                  Row(
                    children: [
                      // ---------------- Title ----------------
                      Expanded(
                        flex: 2,
                        child: Text(
                          noteEntity.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      // ---------------- Id ----------------
                      Expanded(
                        child: Text(
                          noteEntity.id.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: smallPadding),
                  // ---------------- Description ----------------
                  Text(
                    noteEntity.desc ?? noDescription,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: smallPadding),
                  // ---------------- Date & status ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ---------------- Date ----------------
                      Expanded(
                        flex: 2,
                        child: Text(
                          notesController.defaultDateFormat(noteEntity.date),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      // ---------------- status ----------------
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: noteEntity.status == Status.Closed.name
                                    ? Colors.red
                                    : kPrimaryColor,
                                borderRadius:
                                    BorderRadius.circular(defaultRadius),
                              ),
                              padding: const EdgeInsets.all(smallPadding),
                              child: Text(
                                noteEntity.status,
                                style: TextStyle(
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: mediumPadding),
                  // ---------------- Delete & edit buttons ----------------
                  Row(
                    children: [
                      // ---------------- Edit button ----------------
                      Expanded(
                        child: CustomButton(
                          title: edit,
                          hasSize: false,
                          onPressed: () =>
                              notesController.onUpdateNotePressed(noteEntity),
                        ),
                      ),
                      const SizedBox(width: largePadding),
                      // ---------------- Delete button ----------------
                      Expanded(
                        child: CustomButton(
                          title: delete,
                          hasSize: false,
                          color: Colors.red,
                          onPressed: () =>
                              notesController.onDeleteNotePressed(noteEntity),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
