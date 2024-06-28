import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/services/auth/authentication.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../data/utils/go.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () => checkLogin());
  }

  Future<void> checkLogin() async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      printDebug("current logged-in user's unique id is: ${user.uid}");
      if (!user.isAnonymous) {
        Authentication.initiateEmailVerificationFlow();
      }
      Go.offNamed(Routes.HOME);
    } else {
      Go.offNamed(Routes.LOGIN_OR_REGISTER);
    }
  }
}
