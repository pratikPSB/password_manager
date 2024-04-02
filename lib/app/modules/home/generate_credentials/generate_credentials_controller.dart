import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GenerateCredentialsController extends GetxController {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final RxBool isHidePassword = true.obs;

  RxString title = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString website = "".obs;
  RxString note = "".obs;

  void updateIsHidePassword(bool isHidePassword) {
    this.isHidePassword.value = isHidePassword;
    update();
  }
}
