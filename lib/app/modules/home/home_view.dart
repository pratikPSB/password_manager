import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../data/resources/size_config.dart';
import 'generate_password_bottom_sheet/generate_password_bottom_sheet_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          performHapticFeedback();
          Get.bottomSheet(buildCredentialInsertionOptionBottomSheet());
        },
        tooltip: "Add password",
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget buildCredentialInsertionOptionBottomSheet() => Wrap(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.toDouble()), topRight: Radius.circular(30.toDouble())),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            child: Column(children: [
              addCredentialInsertionTypeRow(
                icon: Icons.person_outline_rounded,
                title: "Login",
                subTitle: "Add login details for an app or site",
                onPressed: () {
                  Go.toNamed(Routes.GENERATE_CREDENTIALS);
                },
              ),
              addCredentialInsertionTypeRow(
                icon: Icons.masks_outlined,
                title: "Alias",
                subTitle: "Get an email alias to use on new apps",
                onPressed: () {},
              ),
              addCredentialInsertionTypeRow(
                icon: Icons.credit_card,
                title: "Credit card",
                subTitle: "securely store your payment information",
                onPressed: () {},
              ),
              addCredentialInsertionTypeRow(
                icon: Icons.sticky_note_2_outlined,
                title: "note",
                subTitle: "jot down a PIN, code, or note to self",
                onPressed: () {},
              ),
              addCredentialInsertionTypeRow(
                icon: Icons.key_outlined,
                title: "Password",
                subTitle: "Generate a secure password",
                onPressed: () {
                  Get.bottomSheet(const GeneratePasswordBottomSheetView());
                },
              ),
            ]),
          ),
        ),
      ]);

  Widget addCredentialInsertionTypeRow(
          {required IconData icon,
          required String title,
          required String subTitle,
          required Function() onPressed}) =>
      InkWell(
        borderRadius: 5.modifyCorners(),
        onTap: () async {
          performHapticFeedback();
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
          //250 millis delay as bottomSheet's default dismiss time is 250 in get Lib.
          await Future.delayed(
            const Duration(milliseconds: 250),
            () {
              onPressed();
            },
          );
        },
        child: Ink(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical, horizontal: SizeConfig.safeBlockVertical),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: 10.modifyCorners(),
                    color: Get.theme.colorScheme.onPrimary.withAlpha(50)),
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                  Text(
                    subTitle,
                    style: Get.theme.textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
