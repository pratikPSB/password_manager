import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:password_manager/app/data/utils/constants.dart';
import 'package:password_manager/main.dart';

import '../../../data/utils/extensions.dart';
import '../../../data/utils/go.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxString email = "".obs;

  openHome() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    if (await objectBox.getVaults().isEmpty) {
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
