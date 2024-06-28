import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/services/auth/authentication.dart';
import 'package:password_manager/app/data/utils/widgets.dart';
import 'package:password_manager/app/modules/loginModule/login_or_register/login_or_register_controller.dart';

import '../../../data/utils/extensions.dart';
import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final RxString email = "".obs;

  final TextEditingController nameController = TextEditingController();
  RxString name = "".obs;

  final TextEditingController pwdController = TextEditingController();
  RxString password = "".obs;

  final TextEditingController confirmPwdController = TextEditingController();
  RxString confirmPassword = "".obs;

  final RxBool isHidePassword = true.obs;
  final RxBool isHideConfirmPassword = true.obs;

  void updateIsHidePassword(bool isHidePassword) {
    this.isHidePassword.value = isHidePassword;
    update();
  }

  createAccount() async {
    performHapticFeedback();
    if (formKey.currentState!.validate()) {
      User? user = await Authentication.createUserWithCredentials(
        email: emailController.text,
        password: pwdController.text,
      );
      if (user != null) {
        await Authentication.initiateEmailVerificationFlow();
        await Authentication.updateUserFields(name: nameController.text);
        await Get.find<LoginOrRegisterController>().createDefaultVault();
        return () {
          Go.offAllNamed(Routes.HOME);
        };
      } else {
        return () {};
      }
    }
  }

  skipRegistration() async {
    performHapticFeedback();
    showGetXDialog(
        title: "Skip registration!",
        message: "are you sure you want to skip the registration?",
        positiveButtonText: "skip",
        positiveClick: () async {
          performHapticFeedback();
          if (Get.isDialogOpen == true) Get.back();
          User? user = await Authentication.signInAnonymous();
          if (user != null) {
            await Get.find<LoginOrRegisterController>().createDefaultVault();
            Go.offAllNamed(Routes.HOME);
          }
        },
        negativeButtonText: "Register",
        negativeClick: () {
          if (Get.isDialogOpen == true) Get.back();
        });
    return () {};
  }
}
