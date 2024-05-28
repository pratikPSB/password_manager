import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import '../select_vault_bottom_sheet/select_vault_bottom_sheet_controller.dart';
import '../select_vault_bottom_sheet/select_vault_bottom_sheet_view.dart';
import 'generate_note_controller.dart';

class GenerateNoteView extends GetView<GenerateNoteController> {
  const GenerateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(text: "save note", onButtonPressed: controller.insertNote),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2),
        child: Form(
          key: controller.formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Obx(() => ListTile(
              contentPadding: const EdgeInsetsDirectional.only(start: 10),
              shape: 50.modifyShapeBorder(),
              leading: SizedBox(
                width: 50,
                height: 50,
                child: getImageView(
                  assetPath: Get.find<SelectVaultBottomSheetController>()
                      .selectedVault
                      .value
                      .iconPath,
                  bgColor: Get.find<SelectVaultBottomSheetController>()
                      .selectedVault
                      .value
                      .vaultColor,
                ),
              ),
              trailing: IconButton(
                iconSize: 24,
                onPressed: () {
                  performHapticFeedback();
                  Get.bottomSheet(const SelectVaultBottomSheetView(),
                      backgroundColor: Get.theme.colorScheme.secondaryContainer);
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
              horizontalTitleGap: 10,
              minVerticalPadding: 20,
              title: Text(
                "${Get.find<SelectVaultBottomSheetController>().selectedVault.value.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () async {
                performHapticFeedback();
                Get.bottomSheet(const SelectVaultBottomSheetView(),
                    backgroundColor: Get.theme.colorScheme.secondaryContainer);
              },
            )),
            TextFormField(
              decoration: getCommonInputDecoration("Title").copyWith(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,
                labelStyle: titleTextStyle,
                hintStyle: titleTextStyle,
                alignLabelWithHint: true,
              ),
              style: titleTextStyle,
              controller: controller.titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title is required.";
                }
                return null;
              },
            ),
            Expanded(
              child: TextFormField(
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: getCommonInputDecoration("Note").copyWith(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                controller: controller.noteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Note is required.";
                  }
                  return null;
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
