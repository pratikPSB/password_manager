import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';

import '../../../main.dart';
import '../../data/utils/constants.dart';

class HomeController extends GetxController {
  final streamCredentials = objectBox.getCredentials();
  final lvbCredentialsKey = const PageStorageKey("keep credentials alive");

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
}
