import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/vault_model.dart';
import 'package:password_manager/app/data/resources/assets.dart';

class CreateVaultController extends GetxController {
  List<String> iconList = CustomIcons.getIconList();
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
  RxInt selectedIcon = 0.obs;
  RxInt selectedColor = 0.obs;
  RxString selectedIconPath = "".obs;
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
      selectedIcon.value = iconList.indexOf(arguments!.iconPath!);
      selectedColor.value = iconList.indexOf(arguments!.vaultColor!);
    }
  }
}
