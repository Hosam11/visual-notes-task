import 'package:floor/floor.dart';

@entity
class NoteEntity {
  NoteEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    this.desc,
    required this.date,
    required this.status,
  });
  @PrimaryKey()
  final int id;
  final String title;
  final String? desc;
  final String imagePath;
  final DateTime date;
  final String status;

  @override
  String toString() {
    return 'NoteEntity{id: $id, title: $title, desc: $desc, imagePath: $imagePath, date: $date, status: $status}';
  }
}
