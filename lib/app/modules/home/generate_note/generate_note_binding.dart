import 'package:get/get.dart';

import 'generate_note_controller.dart';

class GenerateNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateNoteController>(
      () => GenerateNoteController(),
    );
  }
}
