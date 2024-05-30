import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/constants.dart';

import '../../data/resources/assets.dart';
import '../../data/resources/size_config.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    enableHapticFeedback(isEnabled: true);
    return Scaffold(
      body: getAppNameView(),
    );
  }

  Widget getAppNameView() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withAlpha(50),
                  Colors.blue.withAlpha(25),
                  Colors.blue.withAlpha(5)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                transform: const GradientRotation(pi / 13),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: "app_logo",
                  child: Image.asset(
                    imgLogo,
                    width: 192,
                    height: 192,
                    fit: BoxFit.cover, // Or use desired BoxFit
                  ),
                ),
                // Add a print statement here to verify image loading:
                // Text(Image.asset(imgLogo).toString()),
              ],
            ),
          ),
          Container(
            height: SizeConfig.safeScreenHeight / 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Get.theme.colorScheme.background.withAlpha(99),
                  Get.theme.colorScheme.background
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 3,
                vertical: SizeConfig.safeBlockVertical * 9,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    imgLogo,
                    fit: BoxFit.fitWidth,
                    width: SizeConfig.screenWidth / 10,
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 3),
                  Text(
                    "Password Manager",
                    style: Get.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
