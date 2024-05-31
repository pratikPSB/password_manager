import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart' as validator;

import '../../../data/customClasses/easy_button.dart';
import '../../../data/resources/assets.dart';
import '../../../data/resources/size_config.dart';
import '../../../data/resources/strings.dart';
import '../../../data/utils/constants.dart';
import '../../../data/utils/widgets.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          getCustomSizedButton(
            text: "skip",
            buttonType: EasyButtonType.outlined,
            width: 70,
            height: 35,
            contentGap: 6.0,
            progressStrokeWidth: 2.0,
            onButtonPressed: controller.skipRegistration,
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal * 2,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
              child: Center(
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
                      "Create PM account",
                      style: Get.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical),
                    const Text("Don't worry about privacy. We care for it."),
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: getCommonInputDecoration(name.tr),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return name_empty_error.tr;
                              } else if (!validator.isLength(text, 5)) {
                                return name_validation_error.tr;
                              }
                              return null;
                            },
                            controller: controller.nameController,
                            onChanged: (text) {
                              controller.name.value = text;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            decoration: getCommonInputDecoration(email.tr),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return email_empty_error.tr;
                              } else if (!validator.isEmail(text)) {
                                return email_validation_error.tr;
                              }
                              return null;
                            },
                            controller: controller.emailController,
                            onChanged: (text) {
                              controller.email.value = text;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Obx(() => TextFormField(
                                obscureText: controller.isHidePassword.value,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                decoration: getCommonInputDecoration(password.tr).copyWith(
                                    errorMaxLines: 2,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.updateIsHidePassword(
                                              !controller.isHidePassword.value);
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
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Obx(() => TextFormField(
                                obscureText: controller.isHideConfirmPassword.value,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                decoration: getCommonInputDecoration(confirm_password.tr).copyWith(
                                    errorMaxLines: 2,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.isHideConfirmPassword.value =
                                              !controller.isHideConfirmPassword.value;
                                        },
                                        icon: Icon(
                                          controller.isHideConfirmPassword.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                        ))),
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return password_empty_error.tr;
                                  } else if (controller.password.value != text) {
                                    return confirm_password_validation_error.tr;
                                  }
                                  return null;
                                },
                                controller: controller.confirmPwdController,
                                onChanged: (text) {
                                  controller.confirmPassword.value = text;
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    getElevatedButton(
                        text: "Create an account",
                        onButtonPressed: controller.createAccount,
                        fullWidth: true),
                    SizedBox(height: SizeConfig.safeBlockVertical),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
