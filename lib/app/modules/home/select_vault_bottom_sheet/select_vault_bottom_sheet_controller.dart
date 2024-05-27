import 'dart:async';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/model/vault_model.dart';
import '../../../data/utils/constants.dart';

class SelectVaultBottomSheetController extends GetxController {
  late StreamSubscription<List<VaultModel>> _vaultListStream;
  Rx<List<VaultModel>> vaultList = Rx<List<VaultModel>>(objectBox.getVaultsList());
  RxInt selectedVaultId = 0.obs;
  Rx<VaultModel> selectedVault = Rx<VaultModel>(objectBox.getVaultsList().first);

  @override
  onInit() {
    super.onInit();
    _vaultListStream = objectBox.getVaults().listen((event) {
      vaultList.value = event;
    });
    fetchSelectedVault();
  }

  @override
  void onClose() {
    super.onClose();
    _vaultListStream.cancel();
  }

  fetchSelectedVault() async {
    selectedVaultId.value = await prefs().getInt(prefSelectedVaultId);
    selectedVault.value = objectBox.getVaultById(selectedVaultId.value);
  }
}
