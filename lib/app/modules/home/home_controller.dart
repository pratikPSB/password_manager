import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/app/data/db/credentials_model.dart';
import 'package:password_manager/app/data/db/vault_model.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../../main.dart';
import '../../data/utils/constants.dart';
import '../../data/utils/go.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController {
  late StreamSubscription<List<VaultModel>> _vaultListStream;
  Rx<List<VaultModel>> vaultList = Rx<List<VaultModel>>(objectBox.getVaultsList());
  RxInt selectedVaultId = 0.obs;
  Rx<VaultModel> selectedVault = Rx<VaultModel>(objectBox.getVaultsList().first);

  late StreamSubscription<List<CredentialsModel>> _credentialsStream;
  Rx<List<CredentialsModel>> credentialsList = Rx<List<CredentialsModel>>([]);
  final lvbCredentialsKey = const PageStorageKey("keep credentials alive");

  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
    fetchSelectedVault();
    _vaultListStream = objectBox.getVaults().listen((event) {
      vaultList.value = event;
    });
    _credentialsStream =
        objectBox.getCredentialsByVaultId(selectedVaultId.value.toString()).listen((event) {
      credentialsList.value = event;
    });
  }

  @override
  void onClose() {
    super.onClose();
    _vaultListStream.cancel();
    _credentialsStream.cancel();
  }

  updateCredentialStream() {
    _credentialsStream.cancel();
    _credentialsStream =
        objectBox.getCredentialsByVaultId(selectedVaultId.value.toString()).listen((event) {
      credentialsList.value = event;
    });
  }

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

  fetchSelectedVault() async {
    selectedVaultId.value = await prefs().getInt(prefSelectedVaultId);
    selectedVault.value = objectBox.getVaultById(selectedVaultId.value);
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'to view the credentials please authenticate your identity.',
        options: const AuthenticationOptions(
          sensitiveTransaction: true,
          // stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      printDebug(e);
      // return true;
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
