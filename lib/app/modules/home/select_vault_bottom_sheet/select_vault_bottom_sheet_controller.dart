import 'dart:async';

import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

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

  fetchSelectedVault([VaultModel? model]) async {
    if (model != null) {
      selectedVaultId.value = model.id;
    } else {
      selectedVaultId.value = await prefs().getInt(prefSelectedVaultId);
    }
    selectedVault.value = objectBox.getVaultById(selectedVaultId.value);
  }

  goToCreateVaultScreen() {
    Go.toNamed(Routes.CREATE_VAULT);
  }
}
