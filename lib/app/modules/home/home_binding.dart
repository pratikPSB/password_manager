import 'package:get/get.dart';
import 'package:password_manager/app/modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_binding.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    GeneratePasswordBottomSheetBinding().dependencies();
  }
}
