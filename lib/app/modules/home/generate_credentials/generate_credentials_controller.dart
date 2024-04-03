import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_controller.dart';

class GenerateCredentialsController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

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

    Get.find<GeneratePasswordBottomSheetController>().password.listen((password) {
      pwdController.text = password;
    });
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    emailController.dispose();
    pwdController.dispose();
    websiteController.dispose();
    noteController.dispose();
  }
}
