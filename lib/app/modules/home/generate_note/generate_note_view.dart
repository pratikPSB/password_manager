import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import 'generate_note_controller.dart';

class GenerateNoteView extends GetView<GenerateNoteController> {
  const GenerateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(text: "save note", onButtonPressed: controller.insertNote),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2),
        child: Form(
          key: controller.formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              decoration: getCommonInputDecoration("Title").copyWith(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,
                labelStyle: titleTextStyle,
                hintStyle: titleTextStyle,
                alignLabelWithHint: true,
              ),
              style: titleTextStyle,
              controller: controller.titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title is required.";
                }
                return null;
              },
            ),
            Expanded(
              child: TextFormField(
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: getCommonInputDecoration("Note").copyWith(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                controller: controller.noteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Note is required.";
                  }
                  return null;
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
