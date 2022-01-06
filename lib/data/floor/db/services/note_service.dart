import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:visual_notes/data/floor/dao/note_dao.dart';
import 'package:visual_notes/data/floor/db/services/db_service.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';

class NoteService extends GetxService {
  late NoteDao _noteDao;

  NoteService init() {
    _noteDao = Get.find<DBService>().db.noteDao;
    Fimber.i('_noteDao.hasCode= ${_noteDao.hashCode}');
    return this;
  }

  Future<int> insertNote(NoteEntity note) async =>
      await _noteDao.insertNote(note);

  Future<List<NoteEntity>> getAllNotes() async => await _noteDao.getAllNotes();

  Future<int> updateNote(NoteEntity note) async =>
      await _noteDao.updateNote(note);

  Future<void> deleteNote(int id) async => await _noteDao.deleteNote(id);

  // NOT used for test only to clear table
  Future<void> deleteAll() async => await _noteDao.deleteAllNotes();
}
