import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/resources/assets.dart';
import 'package:password_manager/app/data/resources/size_config.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import 'login_or_register_controller.dart';

class LoginOrRegisterView extends GetView<LoginOrRegisterController> {
  const LoginOrRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getAppNameView(),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  Text(
                    "All tour passwords. Securely in one place and\nprotected by the most trusted name in privacy.",
                    style: Get.textTheme.bodySmall,
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  getElevatedButton(
                      text: "Create an account", onButtonPressed: controller.openRegister),
                  SizedBox(height: SizeConfig.safeBlockVertical),
                  getTextButton(text: "Sign in", onButtonPressed: controller.openLogin),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  Text(
                    "or",
                    style: Get.textTheme.bodySmall,
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  getTextButton(text: "Login with Google", onButtonPressed: controller.loginWithGoogle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppNameView() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: SizeConfig.safeScreenHeight / 2,
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
            child: Hero(
              tag: "app_logo",
              child: Image.asset(
                imgLogo,
                width: SizeConfig.screenWidth / 3,
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeScreenHeight / 5,
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
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
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
