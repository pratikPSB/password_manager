import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/app/data/model/credentials_model.dart';
import 'package:password_manager/app/data/model/vault_model.dart';
import 'package:password_manager/app/data/services/firestore/firestore_operations.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../../main.dart';
import '../../data/utils/constants.dart';
import '../../data/utils/go.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController {
  late StreamSubscription<List<VaultModel>> _vaultListStream;
  Rx<List<VaultModel>> vaultList = Rx<List<VaultModel>>(objectBox.getVaultsList());
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _vaultListStreamSubscriptionFs;
  RxString selectedVaultId = "".obs;
  Rx<VaultModel> selectedVault = Rx<VaultModel>(objectBox.getVaultsList().first);

  StreamSubscription<List<CredentialsModel>>? _credentialsStream;
  Rx<List<CredentialsModel>> credentialsList = Rx<List<CredentialsModel>>([]);
  final lvCredentialsKey = const PageStorageKey("keep credentials alive");

  final menuOptionsList = ['Edit', 'Delete'];

  final LocalAuthentication _auth = LocalAuthentication();

  late Timer _timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchSelectedVault();
    _vaultListStream = objectBox.getVaults().listen((event) {
      vaultList.value = event;
    });
    Stream<QuerySnapshot<Map<String, dynamic>>>? vaultListStreamFs =
        await FireStoreOperations.getVaultList();
    _vaultListStreamSubscriptionFs = vaultListStreamFs?.listen((event) {
      if (event.docs.isNotEmpty) {
        List<VaultModel> list = [];
        for (var action in event.docs) {
          VaultModel model = VaultModel.fromJson(action.data());
          model.firebaseDocId = action.id;
          list.add(model);
        }
        vaultList.value = list;
      }
    });
    updateCredentialStream();
  }

  @override
  void onClose() {
    super.onClose();
    _vaultListStream.cancel();
    _vaultListStreamSubscriptionFs?.cancel();
    if (_credentialsStream != null) _credentialsStream?.cancel();
  }

  updateCredentialStream() {
    if (_credentialsStream != null) _credentialsStream?.cancel();
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
    selectedVaultId.value = await prefs().getString(prefSelectedVaultId);
    selectedVault.value = objectBox.getVaultByFirebaseDocId(selectedVaultId.value);
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
      return true;
      // return false;
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

  assignAndStartTimer() {
    _timer = Timer(const Duration(seconds: 10), () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    });
  }

  cancelTimer() {
    _timer.cancel();
  }

  Future<void> handleDelete(CredentialsModel model) async {
    await FireStoreOperations.deleteCredentialFromVault(model.vaultId!, model.firebaseDocId!);
    await objectBox.removeCredential(model.id);
  }
}
