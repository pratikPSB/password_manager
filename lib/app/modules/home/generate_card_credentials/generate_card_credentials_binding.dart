import 'package:get/get.dart';

import 'generate_card_credentials_controller.dart';

class GenerateCardCredentialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateCardCredentialsController>(
      () => GenerateCardCredentialsController(),
    );
  }
}
