import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import 'create_vault_controller.dart';

class CreateVaultView extends GetView<CreateVaultController> {
  const CreateVaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(text: "Build vault", onButtonPressed: controller.buildVault),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => getImageView(
                      assetPath: controller.selectedIconPath.value,
                      bgColor: controller.selectedColorString.value,
                      isSelected: false,
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 3),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: getCommonInputDecoration("Title", hintText: "Untitled").copyWith(
                        hintStyle: titleTextStyle,
                      ),
                      style: titleTextStyle,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      controller: controller.titleController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisExtent: 55,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: controller.colorList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.selectedColorPos.value = index;
                      controller.selectedColorString.value = controller.colorList[index];
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(controller.colorList[index].getColorHexFromStr())
                              .withOpacity(0.25),
                          border: controller.selectedColorPos.value == index
                              ? Border.all(
                                  color: Color(controller.colorList[index].getColorHexFromStr())
                                      .withOpacity(0.75),
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  width: 2,
                                )
                              : null),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(controller.colorList[index].getColorHexFromStr()),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisExtent: 55,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: controller.iconList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedIconPos.value = index;
                    controller.selectedIconPath.value = controller.iconList[index];
                  },
                  child: Obx(
                    () => getImageView(
                        assetPath: controller.iconList[index],
                        bgColor: controller.selectedColorString.value,
                        isSelected: controller.selectedIconPos.value == index),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
          ),
        ],
      ),
    );
  }
}
