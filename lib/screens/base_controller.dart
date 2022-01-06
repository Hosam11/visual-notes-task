import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/shared_widgets/z_shared_widgets.dart';

/// responsible for shared behaviour among all controllers
class BaseController extends GetxController {
  // ---------------- Methods ----------------

  /// if input value equals is empty or null return validate message otherwise
  /// returning null means everything is fine
  String? validateEmptyField(String? value) {
    if (value == null) {
      return requiredField;
    } else if (value.isEmpty) {
      return requiredField;
    } else {
      return null;
    }
  }

  /// Move image from cache to app directory because "Images picked using the
  /// camera are saved to your application's local cache, and should therefore
  /// be expected to only be around temporarily. so we have to move it to
  /// more permanent location.
  Future<File> moveImage(String imagePath) async {
    Fimber.i('imagePath= $imagePath');
    final dir = await getApplicationDocumentsDirectory();
    Fimber.i('dir= $dir');
    Fimber.i('dir.path= ${dir.path}');
    String newDir = join(dir.path, '${DateTime.now().toIso8601String()}.png');
    Fimber.i('newDir= $newDir');
    final sourceFile = File(imagePath);

    /// use to move file from file system to another File.rename works only if
    /// source file and destination path are on the same file system, otherwise
    /// you will get a FileSystemException
    try {
      Fimber.i('try');
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newDir);
    } on FileSystemException catch (e) {
      Fimber.i('moveFile(), e=$e');
      // if rename fails, copy the source file and then delete it from cache
      final newFile = await sourceFile.copy(newDir);
      await sourceFile.delete();
      return newFile;
    }
  }

  // ---------------- Dialogs ----------------

  /// showing loading progress indicator when an operation happened that takes
  /// time
  Future startLoading() async => await Get.dialog(
        const Center(child: CircularProgressIndicator(color: kPrimaryColor)),
        barrierDismissible: false,
      );

  /// stop loading progress indicator when operation ends
  void stopLoading() => Get.back();

  /// show dialog with given [msg]
  Future showInfoDialog(String msg) => showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          shape: dialogShape,
          content: Text(msg.tr, textAlign: TextAlign.center),
          actions: [
            Center(
              child: CustomButton(
                title: ok,
                hasSize: false,
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      );
}
