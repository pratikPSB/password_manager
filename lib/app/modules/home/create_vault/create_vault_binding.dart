import 'package:get/get.dart';

import 'create_vault_controller.dart';

class CreateVaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateVaultController>(
      () => CreateVaultController(),
    );
  }
}
