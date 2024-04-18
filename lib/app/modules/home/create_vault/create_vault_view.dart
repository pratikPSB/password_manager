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
        appBar: getCommonAppBar(text: "Create vault", onButtonPressed: () {}),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => getImageView(
                          assetPath: controller.selectedIconPath.value,
                          bgColor: controller.selectedColorString.value,
                          isSelected: true),
                    ),
                    SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration:
                            getCommonInputDecoration("Title", hintText: "Untitled").copyWith(
                          hintStyle: titleTextStyle,
                        ),
                        style: titleTextStyle,
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
            SliverPadding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisExtent: 45,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                ),
                itemCount: controller.colorList.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.selectedColor.value = index;
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
                            border: controller.selectedColor.value == index
                                ? Border.all(
                                    color: Color(controller.colorList[index].getColorHexFromStr())
                                        .withOpacity(0.75),
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    width: 2,
                                  )
                                : null),
                        child: Container(
                          height: 30,
                          width: 30,
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
            SliverPadding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisExtent: 60,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                ),
                itemCount: controller.iconList.length,
                itemBuilder: (context, index) {
                  return Obx(
                        () => GestureDetector(
                      onTap: () {
                        controller.selectedIcon.value = index;
                        controller.selectedIconPath.value = controller.iconList[index];
                      },
                      child: getImageView(assetPath: controller.iconList[index], bgColor: controller.selectedColorString.value),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget getImageView(
      {required String assetPath, required String bgColor, bool isSelected = false}) {
    return Container(
      height: 50,
      width: 50,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(bgColor.getColorHexFromStr()).withOpacity(0.25),
          border: isSelected
              ? Border.all(
                  color: Color(bgColor.getColorHexFromStr()).withOpacity(0.75),
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 2,
                )
              : null),
      child: Image.asset(
        assetPath,
        width: 25,
        height: 25,
        color: Color(bgColor.getColorHexFromStr()),
      ),
    );
  }
}
