import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/widgets.dart';

import '../../../data/customClasses/easy_button.dart';
import '../../../data/utils/extensions.dart';
import 'generate_credentials_controller.dart';

class GenerateCredentialsView extends GetView<GenerateCredentialsController> {
  const GenerateCredentialsView({super.key});

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
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
