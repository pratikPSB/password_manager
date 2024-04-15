import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/db/CredentialsModel.dart';
import '../../../data/utils/constants.dart';
import '../../../data/utils/encrypt_decrypt.dart';
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
      DateTime dateTime = DateTime.now();
      objectBox.addCredential(CredentialsModel(
        credType: CredentialType.note.name,
        vaultId: id.toString(),
        name: EncryptData.encryptAES(finalKey, titleController.text),
        notes: EncryptData.encryptAES(finalKey, noteController.text),
        createdAt: dateTime,
        updatedAt: dateTime,
      ));
      Get.back();
    }
  }
}
