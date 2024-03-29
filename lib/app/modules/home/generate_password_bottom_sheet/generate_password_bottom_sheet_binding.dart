import 'package:get/get.dart';

import 'generate_password_bottom_sheet_controller.dart';

class GeneratePasswordBottomSheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GeneratePasswordBottomSheetController());
  }
}
