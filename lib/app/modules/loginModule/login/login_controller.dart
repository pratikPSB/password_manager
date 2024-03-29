import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/utils/extensions.dart';
import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  final RxString email = "".obs;
  final RxString password = "".obs;
  final RxBool isHidePassword = true.obs;

  openHome() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    return () {
      Go.offAllNamed(Routes.HOME);
      // Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
    };
  }
}
