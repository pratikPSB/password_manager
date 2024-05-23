import 'package:get/get.dart';

import 'select_vault_controller.dart';

class SelectVaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectVaultController>(
      () => SelectVaultController(),
    );
  }
}
