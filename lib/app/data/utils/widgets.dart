import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/resources/theme_utils.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../customClasses/easy_button.dart';
import '../resources/assets.dart';

Widget _getButton(
    {required String text,
    required EasyButtonType buttonType,
    required Function() onButtonPressed,
    required bool fullWidth}) {
  printDebug(Get.theme.colorScheme.primary.toString());
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

Widget getCustomSizedButton(
    {required String text,
    required EasyButtonType buttonType,
    required Function() onButtonPressed,
    double width = double.infinity,
    double height = 50,
    double contentGap = 6.0,
    double progressStrokeWidth = 3.0}) {
  return EasyButton(
    onPressed: onButtonPressed,
    type: buttonType,
    useWidthAnimation: true,
    useEqualLoadingStateWidgetDimension: (buttonType == EasyButtonType.text) ? false : true,
    width: width,
    height: height,
    contentGap: contentGap,
    borderRadius: 50,
    idleStateWidget: Text(
      text,
      style: (buttonType != EasyButtonType.elevated)
          ? styleLight.copyWith(color: Get.theme.colorScheme.primary)
          : styleDark.copyWith(color: Get.theme.colorScheme.onPrimary),
    ),
    loadingStateWidget: CircularProgressIndicator(
      strokeWidth: progressStrokeWidth,
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

AppBar getCommonAppBar({
  required String text,
  required Function() onButtonPressed,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          performHapticFeedback();
          Get.back();
        },
        icon: const Icon(
          Icons.close_rounded,
          size: 24,
        ),
      ),
      actions: [
        getCustomSizedButton(
          text: text,
          buttonType: EasyButtonType.elevated,
          width: 100,
          height: 35,
          contentGap: 6.0,
          progressStrokeWidth: 2.0,
          onButtonPressed: onButtonPressed,
        ),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal * 2,
        ),
      ],
    );

InputDecoration getCommonInputDecoration(String labelText, {String hintText = ""}) {
  return InputDecoration(
      labelText: labelText,
      hintText: (hintText.isEmpty) ? labelText : hintText,
      border: OutlineInputBorder(borderRadius: 10.modifyCorners()),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.auto);
}

TextStyle titleTextStyle = const TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

showGetXDialog({
  required String title,
  required dynamic message,
  String positiveButtonText = "",
  String negativeButtonText = "",
  void Function()? positiveClick,
  void Function()? negativeClick,
  Future<bool> Function()? onDismiss,
}) {
  Get.defaultDialog(
    titlePadding: const EdgeInsets.only(
      left: 24.0,
      top: 24.0,
      right: 24.0,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    title: title,
    content: (message is String) ? Text(message) : message,
    actions: <Widget>[
      if (negativeButtonText.isNotEmpty)
        OutlinedButton(
          onPressed: () {
            performHapticFeedback();
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            negativeClick?.call();
          },
          child: Text(negativeButtonText),
        ),
      if (positiveButtonText.isNotEmpty)
        FilledButton(
          onPressed: () {
            performHapticFeedback();
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            positiveClick?.call();
          },
          child: Text(positiveButtonText),
        ),
    ],
    onWillPop: onDismiss,
  );
}

AlertDialog buildAlertDialog({
  required String title,
  required dynamic message,
  String positiveButtonText = "",
  String negativeButtonText = "",
  void Function()? positiveClick,
  void Function()? negativeClick,
}) {
  return AlertDialog(
    title: Text(title),
    content: (message is String) ? Text(message) : message,
    actions: <Widget>[
      if (negativeButtonText.isNotEmpty)
        TextButton(
          onPressed: () {
            performHapticFeedback();
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            negativeClick?.call();
          },
          child: Text(negativeButtonText),
        ),
      if (positiveButtonText.isNotEmpty)
        TextButton(
          onPressed: () {
            performHapticFeedback();
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            positiveClick?.call();
          },
          child: Text(positiveButtonText),
        ),
    ],
  );
}

Widget getImageView({
  required String? assetPath,
  required String? bgColor,
  bool isSelected = false,
  double margin = 0,
}) {
  return Container(
    width: 50,
    height: 50,
    margin: EdgeInsets.all(margin),
    alignment: AlignmentDirectional.center,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color((bgColor ?? "#9ECAff").getColorHexFromStr()).withOpacity(0.25),
        border: isSelected
            ? Border.all(
                color: Color((bgColor ?? "#9ECAff").getColorHexFromStr()).withOpacity(0.75),
                strokeAlign: BorderSide.strokeAlignOutside,
                width: 2,
              )
            : null),
    child: Image.asset(
      assetPath ?? CustomIcons.phone,
      width: 25,
      height: 25,
      color: Color((bgColor ?? "#9ECAff").getColorHexFromStr()),
    ),
  );
}

Widget buildPopupMenu(
        {required List<String> list, required Function(String itemName) onPopupItemSelected}) =>
    PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      onSelected: onPopupItemSelected,
      itemBuilder: (BuildContext context) {
        return list.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );

Widget noDataWidget() => SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            noDataJson,
            width: 250,
            height: 250,
            frameRate: FrameRate.max,
            fit: BoxFit.fitWidth,
            repeat: true,
          ),
        ],
      ),
    );
