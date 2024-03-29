import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkLogin();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkLogin() {
    Go.offNamed(Routes.LOGIN_OR_REGISTER);
  }
}
