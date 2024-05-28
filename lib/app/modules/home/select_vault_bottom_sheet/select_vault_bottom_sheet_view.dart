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
      child: Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount:
            controller.vaultList.value.isNotEmpty ? controller.vaultList.value.length + 1 : 0,
        itemBuilder: (context, index) {
          if (index < controller.vaultList.value.length) {
            VaultModel model = controller.vaultList.value[index];
            return ListTile(
                selected: model.id == controller.selectedVaultId.value,
                contentPadding: const EdgeInsetsDirectional.only(start: 10),
                shape: 50.modifyShapeBorder(),
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: getImageView(
                    assetPath: model.iconPath,
                    bgColor: model.vaultColor,
                  ),
                ),
                trailing: (model.id == controller.selectedVaultId.value)
                    ? IconButton(
                        iconSize: 24,
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                      )
                    : null,
                horizontalTitleGap: 10,
                minVerticalPadding: 20,
                title: Text(
                  "${model.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () async {
                  performHapticFeedback();
                  await controller.fetchSelectedVault(model);
                  Get.back();
                },
              );
          } else {
            return ListTile(
              contentPadding: const EdgeInsetsDirectional.only(start: 10),
              shape: 50.modifyShapeBorder(),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color("#9ECAff".getColorHexFromStr()).withOpacity(0.25),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 25,
                  color: Color("#9ECAff".getColorHexFromStr()),
                ),
              ),
              horizontalTitleGap: 10,
              minVerticalPadding: 20,
              title: const Text(
                "Add new vault",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () async {
                performHapticFeedback();
                await controller.goToCreateVaultScreen();
              },
            );
          }
        },
      ),
    ));
  }
}
