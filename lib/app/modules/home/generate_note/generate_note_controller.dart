import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/db/CredentialsModel.dart';
import '../../../data/utils/constants.dart';
import '../../../data/utils/extensions.dart';

class GenerateNoteController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  insertNote() async {
    performHapticFeedback();
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000), () => 42);
      int id = await prefs().getInt(prefSelectedVaultId);
      objectBox.addCredential(CredentialsModel(
        vaultId: id.toString(),
        name: titleController.text,
        notes: noteController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
      Get.back();
    }
  }
}
