import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../../main.dart';
import '../../data/utils/constants.dart';
import '../../data/utils/go.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController {
  final streamCredentials = objectBox.getCredentials();
  final lvbCredentialsKey = const PageStorageKey("keep credentials alive");

  final LocalAuthentication auth = LocalAuthentication();

  String getTextForSubtitle(CredentialsModel data) {
    switch (CredentialType.values.byName(data.credType!)) {
      case CredentialType.login:
        return EncryptionUtils().decryptAES(data.email!);
      case CredentialType.card:
        return EncryptionUtils().decryptAES(data.cardNumber!);
      case CredentialType.alias:
        return EncryptionUtils().decryptAES(data.email!);
      case CredentialType.note:
        return EncryptionUtils().decryptAES(data.notes!);
    }
  }

  Future<bool> isSelectedVault(VaultModel model) async {
    int selectedId = await prefs().getInt(prefSelectedVaultId);
    return model.id == selectedId;
  }

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'to view the credentials please authenticate your identity.',
        options: const AuthenticationOptions(
          sensitiveTransaction: true,
          // stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      printDebug(e);
      return false;
    }
  }

  void handleEdit(CredentialsModel data) {
    switch (CredentialType.values.byName(data.credType!)) {
      case CredentialType.login:
        Go.toNamed(Routes.GENERATE_CREDENTIALS, arguments: data);
        break;
      case CredentialType.card:
        Go.toNamed(Routes.GENERATE_CARD_CREDENTIALS, arguments: data);
        break;
      case CredentialType.note:
        Go.toNamed(Routes.GENERATE_NOTE, arguments: data);
        break;
      case CredentialType.alias:
        break;
    }
  }
}
