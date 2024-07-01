import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/model/credentials_model.dart';
import 'package:password_manager/app/modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_controller.dart';
import 'package:password_manager/main.dart';

import '../../../data/services/firestore/firestore_operations.dart';
import '../../../data/utils/encrypt_decrypt.dart';
import '../../../data/utils/extensions.dart';
import '../select_vault_bottom_sheet/select_vault_bottom_sheet_controller.dart';

class GenerateCredentialsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final FocusNode titleNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode websiteNode = FocusNode();
  final FocusNode notesNode = FocusNode();

  late StreamSubscription<String> stream;

  final RxBool isHidePassword = true.obs;
  final RxBool isShowButtons = false.obs;
  final RxString showWhichButton = "EMAIL".obs;

  CredentialsModel? arguments = Get.arguments;

  void updateIsHidePassword(bool isHidePassword) {
    this.isHidePassword.value = isHidePassword;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    Get.find<SelectVaultBottomSheetController>().fetchSelectedVault();
    initStreams();
    addFocusNodeListeners();

    if (arguments != null) {
      titleController.text = arguments!.name!;
      emailController.text = EncryptionUtils().decryptAES(arguments!.email!);
      pwdController.text = EncryptionUtils().decryptAES(arguments!.password!);
      websiteController.text = arguments!.websites![0];
      noteController.text = EncryptionUtils().decryptAES(arguments!.notes!);
    }
  }

  initStreams() {
    stream = Get.find<GeneratePasswordBottomSheetController>().password.listen((password) {
      pwdController.text = password;
    });
  }

  @override
  void onClose() {
    super.onClose();
    stream.cancel();
    titleController.dispose();
    emailController.dispose();
    pwdController.dispose();
    websiteController.dispose();
    noteController.dispose();
  }

  insertCredentialsToDB() async {
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
          email: EncryptionUtils().encryptAES(emailController.text),
          password: EncryptionUtils().encryptAES(pwdController.text),
          websites: [websiteController.text],
          notes: EncryptionUtils().encryptAES(noteController.text),
          updatedAt: dateTime,
        );
        await FireStoreOperations.addCredentialToVault(id!, model, fsCredId: arguments!.firebaseDocId);
        model.id = arguments!.id;
        await objectBox.addCredential(model);
      } else {
        CredentialsModel model = CredentialsModel(
          vaultId: id.toString(),
          credType: CredentialType.login.name,
          name: titleController.text,
          email: EncryptionUtils().encryptAES(emailController.text),
          password: EncryptionUtils().encryptAES(pwdController.text),
          websites: [websiteController.text],
          notes: EncryptionUtils().encryptAES(noteController.text),
          createdAt: dateTime,
          updatedAt: dateTime,
        );
        DocumentReference<Map<String, dynamic>>? credRef =
        await FireStoreOperations.addCredentialToVault(id!, model);
        model.firebaseDocId = credRef?.id;
        await objectBox.addCredential(model);
      }
      Get.back();
    }
  }

  addFocusNodeListeners() {
    titleNode.addListener(() {
      if (titleNode.hasFocus) {
        isShowButtons.value = false;
      }
    });
    titleNode.requestFocus(emailNode);

    emailNode.addListener(() {
      if (emailNode.hasFocus) {
        isShowButtons.value = true;
        showWhichButton.value = "EMAIL";
      }
    });
    emailNode.requestFocus(passwordNode);

    passwordNode.addListener(() {
      if (passwordNode.hasFocus) {
        isShowButtons.value = true;
        showWhichButton.value = "PASSWORD";
      }
    });
    passwordNode.requestFocus(websiteNode);

    websiteNode.addListener(() {
      if (websiteNode.hasFocus) {
        isShowButtons.value = false;
      }
    });
    websiteNode.requestFocus(notesNode);

    notesNode.addListener(() {
      if (notesNode.hasFocus) {
        isShowButtons.value = false;
      }
    });
  }
}
