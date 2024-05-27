import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/vault_model.dart';
import '../../../data/resources/size_config.dart';
import '../../../data/utils/extensions.dart';
import '../../../data/utils/widgets.dart';
import 'select_vault_bottom_sheet_controller.dart';

class SelectVaultBottomSheetView extends GetView<SelectVaultBottomSheetController> {
  const SelectVaultBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
      child: Obx(() => ListView.builder(
            itemCount:
                controller.vaultList.value.isNotEmpty ? controller.vaultList.value.length : 0,
            itemBuilder: (context, index) {
              VaultModel model = controller.vaultList.value[index];
              return Obx(
                () => ListTile(
                  selected: model.id == controller.selectedVaultId.value,
                  contentPadding: const EdgeInsetsDirectional.only(start: 10),
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: getImageView(
                      assetPath: model.iconPath,
                      bgColor: model.vaultColor,
                    ),
                  ),
                  trailing: IconButton(
                    iconSize: 24,
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                  ),
                  horizontalTitleGap: 10,
                  minVerticalPadding: 10,
                  title: Text(
                    "${model.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () async {
                    performHapticFeedback();
                    await controller.fetchSelectedVault();
                    Get.back();
                  },
                ),
              );
            },
          )),
    );
  }
}
