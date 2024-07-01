import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/model/vault_model.dart';
import 'package:password_manager/app/data/resources/assets.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../../../main.dart';
import '../../../data/services/firestore/firestore_operations.dart';

class CreateVaultController extends GetxController {
  List<String> iconList = CustomIcons.getIconList();
  RxInt selectedIconPos = 0.obs;
  RxString selectedIconPath = "".obs;

  List<String> colorList = [
    "#9ECAff",
    "#FF8E92",
    "#FED47D",
    "#87C59C",
    "#83B3EE",
    "#F589D2",
    "#DA566F",
    "#EEA16D",
    "#E5E5E5",
    "#8BE1E6"
  ];
  RxInt selectedColorPos = 0.obs;
  RxString selectedColorString = "".obs;

  final TextEditingController titleController = TextEditingController();
  VaultModel? arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    selectedIconPath.value = iconList[0];
    selectedColorString.value = colorList[0];
    if (arguments != null) {
      titleController.text = arguments!.name!;
      selectedIconPos.value = iconList.indexOf(arguments!.iconPath!);
      selectedColorPos.value = iconList.indexOf(arguments!.vaultColor!);
    }
  }

  buildVault() async {
    performHapticFeedback();
    if (titleController.text.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 1000), () => 42);
      DateTime dateTime = DateTime.now();
      if (arguments != null) {
        VaultModel model = arguments!.copyWith(
          iconPath: selectedIconPath.value,
          name: titleController.text,
          vaultColor: selectedColorString.value,
          updatedAt: dateTime,
        );
        await FireStoreOperations.addVault(model, fbVaultId: arguments!.firebaseDocId);
        model.id = arguments!.id;
        objectBox.addVault(model);
      } else {
        VaultModel vault = VaultModel(
          iconPath: selectedIconPath.value,
          name: titleController.text,
          vaultColor: selectedColorString.value,
          createdAt: dateTime,
          updatedAt: dateTime,
        );
        DocumentReference<Map<String, dynamic>>? vaultRef =
            await FireStoreOperations.addVault(vault);
        vault.firebaseDocId = vaultRef?.id;
        await objectBox.addVault(vault);
      }
      Get.back();
    }
  }
}
