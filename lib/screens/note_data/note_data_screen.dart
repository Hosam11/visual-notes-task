import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/constants/z_constants.dart';
import 'package:visual_notes/data/floor/entities/note_entity.dart';
import 'package:visual_notes/screens/note_data/note_data_controller.dart';
import 'package:visual_notes/screens/note_data/widgets/z_widgets.dart';
import 'package:visual_notes/shared_widgets/z_shared_widgets.dart';

// FIXME: remove it after finished screen
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
///  responsible add or update note data
class NoteDataScreen extends StatelessWidget {
  const NoteDataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: noteData),
      body: SingleChildScrollView(
        child: Padding(
          padding: screenPadding,
          child: GetX<NoteDataController>(
            init: NoteDataController(Get.arguments as NoteEntity?),
            builder: (noteDataController) => Form(
              key: noteDataController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- Image ----------------
                  LabelText(label: picture, isRequired: true),
                  Center(
                    child: PickImage(
                      image: noteDataController.imagePath,
                      onImagePressed: noteDataController.onImagePressed,
                      isImageError: noteDataController.imageError,
                    ),
                  ),
                  // ---------------- Image  validator ----------------
                  if (noteDataController.imageError)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: smallPadding, left: mediumPadding),
                      child: Text(
                        requiredField,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: Theme.of(context).errorColor),
                      ),
                    ),
                  const SizedBox(height: mediumPadding),
                  // ---------------- Id ----------------
                  LabelText(label: id, isRequired: true),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    validator: noteDataController.validateEmptyField,
                    controller: noteDataController.idController,
                    isEnabled: !noteDataController.isEdit,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: mediumPadding),
                  // ---------------- Title ----------------
                  LabelText(label: title, isRequired: true),
                  CustomTextField(
                    validator: noteDataController.validateEmptyField,
                    controller: noteDataController.titleController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: mediumPadding),
                  // ---------------- Description ----------------
                  LabelText(label: description),
                  CustomTextField(
                    controller: noteDataController.descController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: mediumPadding),
                  // ---------------- Status ----------------
                  LabelText(label: status),
                  CustomDropDown(
                    value: noteDataController.selectedStatus,
                    listItem: noteDataController.statuses,
                    mOnChanged: noteDataController.onDropDownChanged,
                    mValidator: noteDataController.validateEmptyField,
                  ),
                  const SizedBox(height: largePadding * 2),
                  // ---------------- Save button ----------------
                  CustomButton(
                    title: noteDataController.isEdit ? update : save,
                    onPressed: noteDataController.onSavedPressed,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
