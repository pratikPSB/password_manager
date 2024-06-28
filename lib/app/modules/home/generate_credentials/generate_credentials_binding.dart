import 'package:get/get.dart';

import 'generate_credentials_controller.dart';

class GenerateCredentialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateCredentialsController>(
      () => GenerateCredentialsController(),
    );
  }
}
