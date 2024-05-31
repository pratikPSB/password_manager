import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/services/auth/authentication.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../../../main.dart';
import '../../../data/model/vault_model.dart';
import '../../../data/resources/assets.dart';
import '../../../data/utils/constants.dart';

class LoginOrRegisterController extends GetxController {
  openLogin() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 500), () => 42);
    return () {
      Go.toNamed(Routes.LOGIN);
    };
  }

  openRegister() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 500), () => 42);
    return () {
      Go.toNamed(Routes.REGISTER);
    };
  }

  loginWithGoogle() async {
    performHapticFeedback();
    User? user = await Authentication.signInWithGoogle();
    if (user != null) {
      await createDefaultVault();
      return () {
        Go.offAllNamed(Routes.HOME);
      };
    } else {
      return () {};
    }
  }

  createDefaultVault() async {
    if (objectBox.getVaultsList().isEmpty) {
      int id = await objectBox.addVault(VaultModel(
          name: "Personal",
          iconPath: CustomIcons.phone,
          vaultColor: "#9ECAff",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()));
      prefs().setInt(prefSelectedVaultId, id);
    }
  }
}
