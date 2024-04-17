import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';

import '../../../../main.dart';
import '../../../data/db/CredentialsModel.dart';
import '../../../data/utils/constants.dart';
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
      int id = await prefs().getInt(prefSelectedVaultId);
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
        model.id = arguments!.id;
        objectBox.addCredential(model);
      } else {
        objectBox.addCredential(CredentialsModel(
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
        ));
      }
      Get.back();
    }
  }
}
