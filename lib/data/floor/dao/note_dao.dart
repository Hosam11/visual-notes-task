import 'package:floor/floor.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';

@dao
abstract class NoteDao {
  @insert
  Future<int> insertNote(NoteEntity note);

  @update
  Future<int> updateNote(NoteEntity note);

  @Query('DELETE FROM NoteEntity WHERE id= :id')
  Future<void> deleteNote(int id);

  @Query('SELECT * FROM NoteEntity')
  Future<List<NoteEntity>> getAllNotes();

  @Query('DELETE FROM NoteEntity')
  Future<void> deleteAllNotes();
}
