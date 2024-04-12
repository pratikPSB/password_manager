import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';

import '../../../main.dart';
import '../../data/utils/constants.dart';

class HomeController extends GetxController {
  final streamCredentials = objectBox.getCredentials();
  final lvbCredentialsKey = const PageStorageKey("keep credentials alive");

  String getTextForSubtitle(CredentialsModel data) {
    switch (CredentialType.values.byName(data.credType!)) {
      case CredentialType.login:
        return data.email!;
      case CredentialType.card:
        return data.cardNumber!;
      case CredentialType.alias:
        return data.email!;
      case CredentialType.note:
        return data.notes!;
    }
  }

  Future<bool> isSelectedVault(VaultModel model) async {
    int selectedId = await prefs().getInt(prefSelectedVaultId);
    return model.id == selectedId;
  }
}
