import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/db/VaultModel.dart';
import '../../../data/utils/constants.dart';
import '../../../data/utils/extensions.dart';
import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  final RxString email = "".obs;
  final RxString password = "".obs;
  final RxBool isHidePassword = true.obs;

  openHome() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    if (objectBox.getVaultsList().isEmpty) {
      int id = await objectBox.addVault(VaultModel(
          name: "Personal",
          vaultColor: "#232323",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));
      prefs().setInt(prefSelectedVaultId, id);
    }
    return () {
      Go.offAllNamed(Routes.HOME);
      // Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
    };
  }
}
