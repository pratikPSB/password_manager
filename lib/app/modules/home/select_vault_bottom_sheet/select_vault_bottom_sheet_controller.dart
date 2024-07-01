import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../../../main.dart';
import '../../../data/model/vault_model.dart';
import '../../../data/services/firestore/firestore_operations.dart';
import '../../../data/utils/constants.dart';

class SelectVaultBottomSheetController extends GetxController {
  late StreamSubscription<List<VaultModel>> _vaultListStream;
  Rx<List<VaultModel>> vaultList = Rx<List<VaultModel>>(objectBox.getVaultsList());
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _vaultListStreamSubscriptionFs;

  RxString selectedVaultId = "".obs;
  Rx<VaultModel> selectedVault = Rx<VaultModel>(objectBox.getVaultsList().first);

  @override
  onInit() async {
    super.onInit();
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

    fetchSelectedVault();
  }

  @override
  void onClose() {
    super.onClose();
    _vaultListStream.cancel();
    _vaultListStreamSubscriptionFs?.cancel();
  }

  fetchSelectedVault([VaultModel? model]) async {
    if (model != null) {
      selectedVaultId.value = model.firebaseDocId!;
    } else {
      selectedVaultId.value = await prefs().getString(prefSelectedVaultId);
    }
    selectedVault.value = objectBox.getVaultByFirebaseDocId(selectedVaultId.value);
  }

  goToCreateVaultScreen() {
    Go.toNamed(Routes.CREATE_VAULT);
  }
}
