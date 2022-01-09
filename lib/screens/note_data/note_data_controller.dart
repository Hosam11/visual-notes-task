import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/data/floor/db/services/note_service.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';
import 'package:visual_notes/screens/base_controller.dart';

// ignore: constant_identifier_names
enum Status { Open, Closed }

class NoteDataController extends BaseController {
  final NoteEntity? _noteEntity;

  NoteDataController(NoteEntity? noteEntity) : _noteEntity = noteEntity {
    Fimber.i('noteEntity= $noteEntity');
    if (_noteEntity != null) {
      idController.text = _noteEntity!.id.toString();
      titleController.text = _noteEntity!.title;
      if (_noteEntity?.desc != null) {
        descController.text = _noteEntity!.desc!;
      }
      _imagePath.value = _noteEntity!.imagePath;
      _selectedStatus.value = _noteEntity!.status;
    }
  }

  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  // ---------------- Properties ----------------
  final _imagePath = ''.obs;
  final _selectedStatus = ''.obs;
  final _imageError = false.obs;

  // ---------------- Getters ----------------
  String get imagePath => _imagePath.value;

  String? get selectedStatus =>
      _selectedStatus.value == '' ? null : _selectedStatus.value;

  bool get imageError => _imageError.value;

  List<String> get statuses =>
      Status.values.map((s) => s.name).toList(growable: false);

  bool get isEdit => _noteEntity != null ? true : false;

  // ---------------- Methods ----------------

  /// when click on image choose image from camera and save it in [_imagePath]
  /// or save old value if return without choose an image
  Future<void> onImagePressed() async {
    XFile? image;
    final imgPicker = ImagePicker();
    try {
      image = await imgPicker.pickImage(source: ImageSource.camera);
      _imagePath.value = image?.path ?? _imagePath.value;
    } on PlatformException catch (e) {
      Fimber.e('e =$e');
      Fimber.e('e =${e.message}');
      showInfoDialog((e.message) ?? cameraError);
    }
  }

  /// when choose value from dropdown list assign it to [_selectedStatus] to
  /// store it later in database
  void onDropDownChanged(String? status) {
    if (status != null) {
      _selectedStatus.value = status;
    }
  }

  /// when saved form data pressed check first if all form data valid so
  /// [moveImage] to new directory and call [saveToDatabase] to save data
  /// in database
  Future<void> onSavedPressed() async {
    final isValid = formKey.currentState?.validate();
    _imageError.value = _imagePath.value.isEmpty ? true : false;
    // if every required field in provided
    if (isValid != null && isValid && !_imageError.value) {
      final newImage = await moveImage(imagePath);

      /// save new image path to  [_imagePath] because if there is error happened
      /// he can access the new path of image
      _imagePath.value = newImage.path;
      Fimber.i('newImagePath= ${newImage.path}');
      final note = NoteEntity(
        id: int.parse(idController.text),
        title: titleController.text,
        imagePath: imagePath,
        desc: descController.text.isEmpty ? null : descController.text,
        // because it date of taken note
        date: isEdit ? _noteEntity!.date : DateTime.now(),
        status: selectedStatus!,
      );
      isEdit ? updateNote(note) : saveToDatabase(note);
    }
  }

  Future<void> updateNote(NoteEntity note) async {
    try {
      startLoading();
      final updatedNote = await Get.find<NoteService>().updateNote(note);
      stopLoading();
      Fimber.i('updatedNote= $updatedNote');
      await showInfoDialog(noteUpdateSuccessfully);
    } catch (e) {
      stopLoading();
      showInfoDialog(errorMsg);
      Fimber.e('error= ${e.runtimeType}');
    }
  }

  /// save [note] to database then show dialog whether operation succeed or failed
  Future<void> saveToDatabase(NoteEntity note) async {
    try {
      startLoading();
      final idInserted = await Get.find<NoteService>().insertNote(note);
      stopLoading();
      if (idInserted == note.id) {
        resetFormData();
        await showInfoDialog(noteAddSuccessfully);
      }
    } catch (e) {
      stopLoading();
      showInfoDialog(errorNoteAdd);
      Fimber.e('error= ${e.runtimeType}');
    }
  }

  /// reset form data so if he want to add new note
  void resetFormData() {
    idController.clear();
    titleController.clear();
    descController.clear();
    _imagePath.value = '';
    _selectedStatus.value = '';
    _imageError.value = false;
  }

  /// dispose all controllers when current controller [NoteDataController]
  /// disposed
  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    titleController.dispose();
    descController.dispose();
  }
}
