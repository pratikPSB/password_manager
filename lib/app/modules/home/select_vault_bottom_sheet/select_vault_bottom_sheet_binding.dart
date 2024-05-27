import 'package:get/get.dart';

import 'select_vault_bottom_sheet_controller.dart';

class SelectVaultBottomSheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectVaultBottomSheetController());
  }
}
