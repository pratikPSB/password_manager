import 'package:get/get.dart';

import 'login_or_register_controller.dart';

class LoginOrRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginOrRegisterController>(
      () => LoginOrRegisterController(),
    );
  }
}
