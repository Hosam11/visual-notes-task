import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_notes/screens/base_controller.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum Status { Open, Closed }

class NoteDataController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  // properties
  final _imagePath = ''.obs;
  final _selectedStatus = ''.obs;
  final _imageError = false.obs;
  // getters
  String get imagePath => _imagePath.value;
  String? get selectedStatus =>
      _selectedStatus.value == '' ? null : _selectedStatus.value;
  bool get imageError => _imageError.value;
  List<String> get statuses =>
      Status.values.map((s) => s.name).toList(growable: false);

  // Methods
  Future<void> onImagePressed() async {
    XFile? image;
    final imgPicker = ImagePicker();
    image = await imgPicker.pickImage(source: ImageSource.camera);
    _imagePath.value = image?.path ?? _imagePath.value;
  }

  void onDropDownChanged(String? status) {
    if (status != null) {
      _selectedStatus.value = status;
    }
  }

  void onSavedPressed() {
    final isValid = formKey.currentState?.validate();
    _imageError.value = _imagePath.value.isEmpty ? true : false;
    if (isValid != null && isValid && !_imageError.value) {
      // all good proceed
      final date = DateTime.now();
      Fimber.i('idController= ${idController.text}'
          'titleController= ${titleController.text}'
          'descController= ${descController.text}'
          '_imagePath= $imagePath'
          '_selectedStatus= $selectedStatus'
          'date= $date');
    }
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    titleController.dispose();
    descController.dispose();
  }
}
