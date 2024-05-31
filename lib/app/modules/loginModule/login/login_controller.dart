import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/services/auth/authentication.dart';
import '../../../data/utils/extensions.dart';
import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';
import '../login_or_register/login_or_register_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  final RxString email = "".obs;
  final RxString password = "".obs;
  final RxBool isHidePassword = true.obs;

  performSignIn() async {
    performHapticFeedback();
    if (formKey.currentState!.validate()) {
      User? user = await Authentication.signInWithCredentials(
        email: emailController.text,
        password: pwdController.text,
      );
      if (user != null) {
        // await Authentication.initiateEmailVerificationFlow();
        await Get.find<LoginOrRegisterController>().createDefaultVault();
        return () {
          Go.offAllNamed(Routes.HOME);
        };
      } else {
        return () {};
      }
    }
  }
}
