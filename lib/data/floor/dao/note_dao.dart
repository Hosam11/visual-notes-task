import 'package:floor/floor.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';

/// responsible for declare crud operation
@dao
abstract class NoteDao {
  @insert
  Future<int> insertNote(NoteEntity note);

  @update
  Future<int> updateNote(NoteEntity note);

  @delete
  Future<void> deleteNote(NoteEntity note);

  @Query('SELECT * FROM NoteEntity')
  Future<List<NoteEntity>> getAllNotes();

  @Query('DELETE FROM NoteEntity')
  Future<void> deleteAllNotes();
}
