import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

import '../../../data/resources/assets.dart';
import '../../../data/resources/size_config.dart';
import '../../../data/resources/strings.dart';
import '../../../data/utils/widgets.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
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
              SizedBox(height: SizeConfig.safeBlockVertical * 5),
              getElevatedButton(
                  text: "Create an account", onButtonPressed: controller.openHome, fullWidth: true),
              SizedBox(height: SizeConfig.safeBlockVertical),
            ],
          ),
        ),
      ),
    );
  }
}
