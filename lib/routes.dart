import 'package:get/get.dart';
import 'package:visual_notes/screens/z_screen.dart';

const notesScreen = '/notes_screen';
const noteDataScreen = '/note_data_screen';
final pages = [
  GetPage(
      name: notesScreen,
      page: () => const NotesScreen(),
      transition: Transition.zoom),
  GetPage(
      name: noteDataScreen,
      page: () => const NoteDataScreen(),
      transition: Transition.zoom),
];
