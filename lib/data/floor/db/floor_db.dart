import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:visual_notes/data/floor/converters/date_time_converter.dart';
import 'package:visual_notes/data/floor/dao/note_dao.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';

part 'floor_db.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [NoteEntity])
abstract class FloorDB extends FloorDatabase {
  NoteDao get noteDao;
}
