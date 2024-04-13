import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import 'generate_note_controller.dart';

class GenerateNoteView extends GetView<GenerateNoteController> {
  const GenerateNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(
          text: "save note", onButtonPressed: controller.insertNote),
      body: const Center(
        child: Text(
          'GenerateNoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
