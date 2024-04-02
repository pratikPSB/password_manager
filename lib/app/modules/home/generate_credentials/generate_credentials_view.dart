import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/widgets.dart';
import 'package:validators/validators.dart' as validator;

import '../../../data/customClasses/easy_button.dart';
import '../../../data/resources/size_config.dart';
import '../../../data/resources/strings.dart' as string_util;
import '../../../data/utils/constants.dart';
import '../../../data/utils/extensions.dart';
import 'generate_credentials_controller.dart';

class GenerateCredentialsView extends GetView<GenerateCredentialsController> {
  GenerateCredentialsView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            text: "create login",
            buttonType: EasyButtonType.elevated,
            width: 100,
            height: 35,
            contentGap: 6.0,
            progressStrokeWidth: 2.0,
            onButtonPressed: () async {
              performHapticFeedback();
              await Future.delayed(const Duration(milliseconds: 1000), () => 42);
              return () {
                Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
              };
            },
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
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: getCommonInputDecoration("Title", hintText: "Untitled").copyWith(
                        hintStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return string_util.name_empty_error.tr;
                        } else if (!validator.isLength(text, 5)) {
                          return string_util.name_validation_error.tr;
                        }
                        return null;
                      },
                      controller: controller.titleController,
                      onChanged: (text) {
                        controller.title.value = text;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: getCommonInputDecoration(string_util.email.tr)
                          .copyWith(prefixIcon: const Icon(Icons.person_outline_rounded)),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return string_util.email_empty_error.tr;
                        } else if (!validator.isEmail(text)) {
                          return string_util.email_validation_error.tr;
                        }
                        return null;
                      },
                      controller: controller.emailController,
                      onChanged: (text) {
                        controller.email.value = text;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Obx(() => TextFormField(
                          obscureText: controller.isHidePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          decoration: getCommonInputDecoration(string_util.password.tr).copyWith(
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              errorMaxLines: 2,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller
                                        .updateIsHidePassword(!controller.isHidePassword.value);
                                  },
                                  icon: Icon(
                                    controller.isHidePassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ))),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return string_util.password_empty_error.tr;
                            } else if (!isPasswordValid(text)) {
                              return string_util.password_validation_error.tr;
                            }
                            return null;
                          },
                          controller: controller.pwdController,
                          onChanged: (text) {
                            controller.password.value = text;
                            controller.update();
                          },
                        )),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      decoration: getCommonInputDecoration("Website", hintText: "https://").copyWith(
                        prefixIcon: const Icon(Icons.web_asset_sharp)
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return string_util.dob_empty_error.tr;
                        }
                        return null;
                      },
                      controller: controller.websiteController,
                      onChanged: (text) {
                        controller.website.value = text;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                  ])),
            ),
          )
        ],
      ),
    );
  }
}
