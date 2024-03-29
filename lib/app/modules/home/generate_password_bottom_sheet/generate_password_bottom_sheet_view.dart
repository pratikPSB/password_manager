import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/resources/size_config.dart';
import '../../../data/utils/extensions.dart';
import '../../../data/utils/widgets.dart';
import 'generate_password_bottom_sheet_controller.dart';

class GeneratePasswordBottomSheetView extends GetView<GeneratePasswordBottomSheetController> {
  const GeneratePasswordBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.createPassword();
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.toDouble()), topRight: Radius.circular(30.toDouble())),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text("Generate Password")),
                    ),
                    IconButton(
                      onPressed: controller.createPassword,
                      icon: const Icon(Icons.refresh_rounded),
                    )
                  ],
                ),
                SizedBox(width: SizeConfig.safeBlockVertical * 3),
                Obx(() => AutoSizeText(
                      controller.password.value,
                      style: Get.theme.textTheme.headlineMedium?.copyWith(letterSpacing: 1.2),
                      maxLines: 2,
                    )),
                SizedBox(width: SizeConfig.safeBlockVertical),
                Obx(() => Text(controller.pwdStrength.value)),
                SizedBox(width: SizeConfig.safeBlockVertical * 3),
                buildPwdLengthSliderRow(),
                SizedBox(width: SizeConfig.safeBlockVertical * 3),
                buildPwdSwitchRow(
                  tileName: "Special characters (!&*)",
                  type: SwitchType.typeSC,
                ),
                SizedBox(width: SizeConfig.safeBlockVertical * 3),
                buildPwdSwitchRow(
                  tileName: "Capital letters (A-Z)",
                  type: SwitchType.typeCL,
                ),
                SizedBox(width: SizeConfig.safeBlockVertical * 3),
                buildPwdSwitchRow(
                  tileName: "Include numbers (0-9)",
                  type: SwitchType.typeNM,
                ),
                SizedBox(width: SizeConfig.safeBlockVertical * 5),
                getElevatedButton(
                    text: "copy and close",
                    onButtonPressed: () {
                      performHapticFeedback();
                      Clipboard.setData(ClipboardData(text: controller.password.value))
                          .then((_) async {
                        if (Get.isBottomSheetOpen ?? false) {
                          Get.back();
                        }
                        await Future.delayed(const Duration(milliseconds: 250), () {
                          Get.showSnackbar(getSnackBar(
                              title: "Password", message: "copied to clipboard successfully."));
                        });
                      });
                    },
                    fullWidth: true),
                SizedBox(width: SizeConfig.safeBlockVertical * 5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPwdLengthSliderRow() => Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
      child: Row(
        children: [
          Obx(() => Text("${controller.pwdLength.value} words")),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal * 3,
          ),
          Obx(() => Expanded(
                child: Slider(
                  min: 0,
                  max: 60,
                  value: controller.pwdLength.value.toDouble() - 4,
                  onChanged: (value) {
                    int finalValue = value.round() + 4;
                    if (finalValue != controller.pwdLength.value) {
                      performHapticFeedback();
                      controller.updatePwdLengthOption(finalValue);
                    }
                  },
                ),
              ))
        ],
      ));

  Widget buildPwdSwitchRow({
    required String tileName,
    required SwitchType type,
  }) =>
      Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
          child: Row(
            children: [
              Text(tileName),
              const Spacer(),
              Obx(() => Switch(
                    onChanged: (value) {
                      performHapticFeedback();
                      switch (type) {
                        case SwitchType.typeSC:
                          controller.updateSpecialCharOption(value);
                        case SwitchType.typeCL:
                          controller.updateCapitalLettersOption(value);
                        case SwitchType.typeNM:
                          controller.updateNumberOption(value);
                      }
                    },
                    value: switch (type) {
                      SwitchType.typeSC => controller.enableSpecialChars.value,
                      SwitchType.typeCL => controller.enableCapLetters.value,
                      SwitchType.typeNM => controller.enableNumbers.value,
                    },
                  ))
            ],
          ));
}

enum SwitchType { typeSC, typeCL, typeNM }
