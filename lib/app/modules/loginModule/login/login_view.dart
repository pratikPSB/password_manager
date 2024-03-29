import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

import '../../../data/resources/assets.dart';
import '../../../data/resources/size_config.dart';
import '../../../data/resources/strings.dart';
import '../../../data/utils/constants.dart';
import '../../../data/utils/widgets.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    imgLogo,
                    fit: BoxFit.fitWidth,
                    width: SizeConfig.screenWidth / 3,
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical),
                  Text(
                    "Sign In",
                    style: Get.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical),
                  const Text("Enter your PM account details."),
                  SizedBox(height: SizeConfig.safeBlockVertical * 5),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: getCommonInputDecoration(email.tr),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return email_empty_error.tr;
                            } else if (!isEmail(text)) {
                              return email_validation_error.tr;
                            }
                            return null;
                          },
                          controller: controller.emailController,
                          onChanged: (text) {
                            controller.email.value = text;
                          },
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 2),
                        Obx(() => TextFormField(
                              obscureText: controller.isHidePassword.value,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              decoration: getCommonInputDecoration(password.tr).copyWith(
                                  errorMaxLines: 2,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.isHidePassword.value =
                                            !controller.isHidePassword.value;
                                        controller.update();
                                      },
                                      icon: Icon(
                                        controller.isHidePassword.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ))),
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return password_empty_error.tr;
                                } else if (!isPasswordValid(text)) {
                                  return password_validation_error.tr;
                                }
                                return null;
                              },
                              controller: controller.pwdController,
                              onChanged: (text) {
                                controller.password.value = text;
                              },
                            )),
                        SizedBox(height: SizeConfig.safeBlockVertical * 5),
                      ])),
                  getElevatedButton(
                      text: "Sign In", onButtonPressed: controller.openHome, fullWidth: true)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
