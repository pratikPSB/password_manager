import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/vault_model.dart';
import 'package:password_manager/app/data/resources/assets.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../../../main.dart';

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
        model.id = arguments!.id;
        objectBox.addVault(model);
      } else {
        objectBox.addVault(VaultModel(
          iconPath: selectedIconPath.value,
          name: titleController.text,
          vaultColor: selectedColorString.value,
          createdAt: dateTime,
          updatedAt: dateTime,
        ));
      }
      Get.back();
    }
  }
}
