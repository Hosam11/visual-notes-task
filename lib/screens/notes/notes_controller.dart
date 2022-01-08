import 'package:fimber/fimber.dart';
import 'package:visual_notes/data/floor/db/services/note_service.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';
import 'package:visual_notes/routes.dart';
import 'package:visual_notes/screens/base_controller.dart';
import 'package:get/get.dart';

class NotesController extends BaseController {
  final _notes = <NoteEntity>[].obs;
  final noteService = Get.find<NoteService>();
  List<NoteEntity> get notes => _notes;

  Future<void> getNotes() async {
    _notes.value = await noteService.getAllNotes();
  }

  Future<void> onAddPressed() async {
    await Get.toNamed(noteDataScreen);
    Fimber.i('after popped=');
    // getNotes here to retrieve saved data
    getNotes();
  }

  Future<void> onDeleteNotePressed(NoteEntity note) async {
    Fimber.i('delete');
    await noteService.deleteNote(note);
    _notes.remove(note);
  }

  onUpdateNotePressed(NoteEntity noteEntity) async {
    await Get.toNamed(noteDataScreen, arguments: noteEntity);
    getNotes();
  }
}
