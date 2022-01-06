import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:visual_notes/data/floor/db/floor_db.dart';

/// responsible for build database and store reference to it in [db]
class DBService extends GetxService {
  final _dbName = 'visual_note_db.db';

  late FloorDB db;

  Future<DBService> init() async {
    db = await $FloorFloorDB.databaseBuilder(_dbName).build();
    Fimber.i('dbHashCode= ${db.hashCode}');
    return this;
  }
}
