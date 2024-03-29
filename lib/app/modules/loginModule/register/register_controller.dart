import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxString email = "".obs;

  openHome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    return () {
      Go.offAllNamed(Routes.HOME);
      // Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
    };
  }
}
