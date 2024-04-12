import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:get/get.dart';

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

  insertCardToDB() async {
    performHapticFeedback();
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000), () => 42);
      int id = await prefs().getInt(prefSelectedVaultId);
      objectBox.addCredential(CredentialsModel(
        vaultId: id.toString(),
        name: titleController.text,
        nameOnCard: nameOnCardController.text,
        credType: CredentialType.card.name,
        cardNumber: cardNumberController.text,
        expiryDate: expDateController.text,
        cvvCode: cvvController.text,
        cardPin: cardPinController.text,
        notes: noteController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
      Get.back();
    }
  }


}
