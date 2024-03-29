import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/resources/theme_utils.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../customClasses/easy_button.dart';

Widget _getButton(
    {required String text,
    required EasyButtonType buttonType,
    required Function() onButtonPressed,
    required bool fullWidth}) {
  return EasyButton(
    onPressed: onButtonPressed,
    type: buttonType,
    useWidthAnimation: true,
    useEqualLoadingStateWidgetDimension: (buttonType == EasyButtonType.text) ? false : true,
    width: fullWidth
        ? double.infinity
        : SizeConfig.screenWidth - (SizeConfig.safeBlockHorizontal * 10),
    height: 50,
    contentGap: 6.0,
    borderRadius: 50,
    idleStateWidget: Text(
      text,
      style: (buttonType != EasyButtonType.elevated)
          ? styleLight.copyWith(color: Get.theme.colorScheme.primary)
          : styleDark.copyWith(color: Get.theme.colorScheme.onPrimary),
    ),
    loadingStateWidget: CircularProgressIndicator(
      strokeWidth: 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        (buttonType != EasyButtonType.elevated)
            ? Get.theme.colorScheme.primary
            : Get.theme.colorScheme.onPrimary,
      ),
    ),
  );
}

Widget getElevatedButton(
    {required String text, required Function() onButtonPressed, bool fullWidth = false}) {
  return _getButton(
      text: text,
      buttonType: EasyButtonType.elevated,
      onButtonPressed: onButtonPressed,
      fullWidth: fullWidth);
}

Widget getTextButton(
    {required String text, required Function() onButtonPressed, bool fullWidth = false}) {
  return _getButton(
      text: text,
      buttonType: EasyButtonType.text,
      onButtonPressed: onButtonPressed,
      fullWidth: fullWidth);
}

Widget getOutlinedButton(
    {required String text, required Function() onButtonPressed, bool fullWidth = false}) {
  return _getButton(
      text: text,
      buttonType: EasyButtonType.outlined,
      onButtonPressed: onButtonPressed,
      fullWidth: fullWidth);
}

GetSnackBar getSnackBar({required String message, String? title}) => GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 250),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
      overlayBlur: 1,
    );

InputDecoration getCommonInputDecoration(String labelText) {
  return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: 100.modifyCorners()),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      floatingLabelBehavior: FloatingLabelBehavior.auto);
}
