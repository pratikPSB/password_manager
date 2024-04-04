import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:password_manager/app/data/utils/constants.dart';
import 'package:password_manager/app/modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_controller.dart';
import 'package:password_manager/main.dart';

import '../../../data/utils/extensions.dart';

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
  final RxBool isShowButtons = true.obs;
  final RxString showWhichButton = "EMAIL".obs;

  RxString title = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString website = "".obs;
  RxString note = "".obs;

  void updateIsHidePassword(bool isHidePassword) {
    this.isHidePassword.value = isHidePassword;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initTextControllers();
    addFocusNodeListeners();
  }

  initTextControllers() {
    titleController.addListener(() {
      title.value = titleController.text;
    });

    emailController.addListener(() {
      email.value = emailController.text;
    });

    pwdController.addListener(() {
      password.value = pwdController.text;
    });

    websiteController.addListener(() {
      website.value = websiteController.text;
    });

    noteController.addListener(() {
      note.value = noteController.text;
    });

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
    if(formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000), () => 42);
      int id = await prefs().getInt(prefSelectedVaultId);
      objectBox.addCredential(CredentialsModel(
        vaultId: id.toString(),
        name: titleController.text,
        email: emailController.text,
        password: pwdController.text,
        websites: [websiteController.text],
        notes: noteController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
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
