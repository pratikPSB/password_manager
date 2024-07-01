import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';
import 'package:password_manager/app/modules/home/select_vault_bottom_sheet/select_vault_bottom_sheet_controller.dart';

import '../../../../main.dart';
import '../../../data/model/credentials_model.dart';
import '../../../data/services/firestore/firestore_operations.dart';
import '../../../data/utils/extensions.dart';

class GenerateCardCredentialsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleNode = FocusNode();

  final TextEditingController nameOnCardController = TextEditingController();
  final FocusNode nameOnCardNode = FocusNode();

  final TextEditingController cardNumberController = TextEditingController();
  final FocusNode cardNumberNode = FocusNode();
  Rx<CardSystemData?> cardSystemData = Rxn<CardSystemData?>();

  final TextEditingController expDateController = TextEditingController();
  final FocusNode expDateNode = FocusNode();

  final TextEditingController cvvController = TextEditingController();
  final FocusNode cvvNode = FocusNode();

  final TextEditingController cardPinController = TextEditingController();
  final FocusNode cardPinNode = FocusNode();

  final TextEditingController noteController = TextEditingController();
  final FocusNode noteNode = FocusNode();

  CredentialsModel? arguments = Get.arguments;

  @override
  onInit() {
    super.onInit();
    Get.find<SelectVaultBottomSheetController>().fetchSelectedVault();
    if (arguments != null) {
      titleController.text = arguments!.name!;
      nameOnCardController.text = EncryptionUtils().decryptAES(arguments!.nameOnCard!);
      cardNumberController.text = EncryptionUtils().decryptAES(arguments!.cardNumber!);
      expDateController.text = EncryptionUtils().decryptAES(arguments!.expiryDate!);
      cvvController.text = EncryptionUtils().decryptAES(arguments!.cvvCode!);
      cardPinController.text = EncryptionUtils().decryptAES(arguments!.cardPin!);
      noteController.text = EncryptionUtils().decryptAES(arguments!.notes!);
    }
  }

  insertCardToDB() async {
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
          nameOnCard: EncryptionUtils().encryptAES(nameOnCardController.text),
          cardNumber: EncryptionUtils().encryptAES(cardNumberController.text),
          expiryDate: EncryptionUtils().encryptAES(expDateController.text),
          cvvCode: EncryptionUtils().encryptAES(cvvController.text),
          cardPin: EncryptionUtils().encryptAES(cardPinController.text),
          notes: EncryptionUtils().encryptAES(noteController.text),
          updatedAt: dateTime,
        );
        await FireStoreOperations.addCredentialToVault(id!, model, fsCredId: arguments!.firebaseDocId);
        model.id = arguments!.id;
        objectBox.addCredential(model);
      } else {
        CredentialsModel model = CredentialsModel(
          vaultId: id.toString(),
          name: titleController.text,
          nameOnCard: EncryptionUtils().encryptAES(nameOnCardController.text),
          credType: CredentialType.card.name,
          cardNumber: EncryptionUtils().encryptAES(cardNumberController.text),
          expiryDate: EncryptionUtils().encryptAES(expDateController.text),
          cvvCode: EncryptionUtils().encryptAES(cvvController.text),
          cardPin: EncryptionUtils().encryptAES(cardPinController.text),
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
