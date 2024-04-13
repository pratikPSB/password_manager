import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/widgets.dart';
import 'package:password_manager/app/modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_view.dart';
import 'package:validators/validators.dart' as validator;

import '../../../data/resources/size_config.dart';
import '../../../data/resources/strings.dart' as string_util;
import '../../../data/utils/constants.dart';
import '../../../data/utils/extensions.dart';
import 'generate_credentials_controller.dart';

class GenerateCredentialsView extends GetView<GenerateCredentialsController> {
  const GenerateCredentialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          getCommonAppBar(text: "create login", onButtonPressed: controller.insertCredentialsToDB),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                  child: Form(
                    key: controller.formKey,
                    child: Column(children: [
                      TextFormField(
                        focusNode: controller.titleNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration:
                            getCommonInputDecoration("Title", hintText: "Untitled").copyWith(
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
                            return "title must not be empty";
                          }
                          return null;
                        },
                        controller: controller.titleController,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      TextFormField(
                        focusNode: controller.emailNode,
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
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      Obx(() => TextFormField(
                            focusNode: controller.passwordNode,
                            obscureText: controller.isHidePassword.value,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            decoration: getCommonInputDecoration(string_util.password.tr).copyWith(
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              errorMaxLines: 2,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.updateIsHidePassword(!controller.isHidePassword.value);
                                },
                                child: Icon(
                                  controller.isHidePassword.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return string_util.password_empty_error.tr;
                              } else if (!isPasswordValid(text)) {
                                return string_util.password_validation_error.tr;
                              }
                              return null;
                            },
                            controller: controller.pwdController,
                          )),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      TextFormField(
                        focusNode: controller.websiteNode,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.next,
                        decoration: getCommonInputDecoration("Website").copyWith(
                            hintText: "",
                            prefixIcon: const Icon(Icons.web_asset_sharp),
                            prefixText: "https://"),
                        controller: controller.websiteController,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      TextFormField(
                        focusNode: controller.notesNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: getCommonInputDecoration("Note")
                            .copyWith(prefixIcon: const Icon(Icons.sticky_note_2_rounded)),
                        controller: controller.noteController,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Obx(() {
            if (controller.isShowButtons.value) {
              if (controller.showWhichButton.value == "EMAIL") {
                return getTextButton(
                  text: "pick registered email",
                  onButtonPressed: () {
                    performHapticFeedback();
                    Get.bottomSheet(const GeneratePasswordBottomSheetView());
                  },
                  fullWidth: true,
                );
              } else {
                return getTextButton(
                  text: "generate a password",
                  onButtonPressed: () {
                    performHapticFeedback();
                    Get.bottomSheet(const GeneratePasswordBottomSheetView());
                  },
                  fullWidth: true,
                );
              }
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}