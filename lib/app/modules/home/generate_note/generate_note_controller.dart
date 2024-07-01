import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/model/credentials_model.dart';
import '../../../data/services/firestore/firestore_operations.dart';
import '../../../data/utils/encrypt_decrypt.dart';
import '../../../data/utils/extensions.dart';
import '../select_vault_bottom_sheet/select_vault_bottom_sheet_controller.dart';

class GenerateNoteController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  CredentialsModel? arguments = Get.arguments;

  @override
  onInit() {
    super.onInit();
    Get.find<SelectVaultBottomSheetController>().fetchSelectedVault();
    if (arguments != null) {
      titleController.text = arguments!.name!;
      noteController.text = EncryptionUtils().decryptAES(arguments!.notes!);
    }
  }

  insertNote() async {
    performHapticFeedback();
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000), () => 42);
      String? id = Get.find<SelectVaultBottomSheetController>()
          .selectedVault
          .value.firebaseDocId;
      DateTime dateTime = DateTime.now();
      if (arguments != null) {
        CredentialsModel model = arguments!.copyWith(
          vaultId: id.toString(),
          name: titleController.text,
          notes: EncryptionUtils().encryptAES(noteController.text),
          updatedAt: dateTime,
        );
        await FireStoreOperations.addCredentialToVault(id!, model, fsCredId: arguments!.firebaseDocId);
        model.id = arguments!.id;
        objectBox.addCredential(model);
      } else {
        CredentialsModel model = CredentialsModel(
          credType: CredentialType.note.name,
          vaultId: id.toString(),
          name: EncryptionUtils().encryptAES(titleController.text),
          notes: EncryptionUtils().encryptAES(noteController.text),
          createdAt: dateTime,
          updatedAt: dateTime,
        );
        DocumentReference<Map<String, dynamic>>? credRef =
        await FireStoreOperations.addCredentialToVault(id!, model);
        model.firebaseDocId = credRef?.id;
        objectBox.addCredential(model);
      }
      Get.back();
    }
  }
}
