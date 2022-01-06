// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorDBBuilder databaseBuilder(String name) =>
      _$FloorDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorDBBuilder inMemoryDatabaseBuilder() => _$FloorDBBuilder(null);
}

class _$FloorDBBuilder {
  _$FloorDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorDB extends FloorDB {
  _$FloorDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteEntity` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `desc` TEXT, `imagePath` TEXT NOT NULL, `date` INTEGER NOT NULL, `status` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteEntityInsertionAdapter = InsertionAdapter(
            database,
            'NoteEntity',
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'desc': item.desc,
                  'imagePath': item.imagePath,
                  'date': _dateTimeConverter.encode(item.date),
                  'status': item.status
                }),
        _noteEntityUpdateAdapter = UpdateAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'desc': item.desc,
                  'imagePath': item.imagePath,
                  'date': _dateTimeConverter.encode(item.date),
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteEntity> _noteEntityInsertionAdapter;

  final UpdateAdapter<NoteEntity> _noteEntityUpdateAdapter;

  @override
  Future<void> deleteNote(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM NoteEntity WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM NoteEntity',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            imagePath: row['imagePath'] as String,
            desc: row['desc'] as String?,
            date: _dateTimeConverter.decode(row['date'] as int),
            status: row['status'] as String));
  }

  @override
  Future<void> deleteAllNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM NoteEntity');
  }

  @override
  Future<int> insertNote(NoteEntity note) {
    return _noteEntityInsertionAdapter.insertAndReturnId(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNote(NoteEntity note) {
    return _noteEntityUpdateAdapter.updateAndReturnChangedRows(
        note, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
