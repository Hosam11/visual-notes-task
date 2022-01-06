import 'package:fimber/fimber.dart';
import 'package:get/get.dart';
import 'package:visual_notes/constants/z_constants.dart';

// responsible for shared behaviour among all controllers
class BaseController extends GetxController {
  String? validateEmptyField(String? value) {
    Fimber.i('value= $value');
    if (value == null) {
      return requiredField;
    } else if (value.isEmpty) {
      return requiredField;
    } else {
      return null;
    }
  }
}
