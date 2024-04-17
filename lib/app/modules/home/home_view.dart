import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:password_manager/app/data/resources/assets.dart';
import 'package:password_manager/app/data/utils/constants.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../../main.dart';
import '../../data/customClasses/easy_button.dart';
import '../../data/db/CredentialsModel.dart';
import '../../data/resources/size_config.dart';
import '../../data/utils/widgets.dart';
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
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: DrawerHeader(
                    curve: Curves.elasticIn,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          imgLogo,
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                        Text(
                          "Password Manager",
                          style: Get.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 5.0),
                    child: Text(
                      "Vaults",
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount:
                      objectBox.getVaultsList().isNotEmpty ? objectBox.getVaultsList().length : 0,
                  itemBuilder: (context, index) {
                    VaultModel model = objectBox.getVaultsList()[index];
                    return FutureBuilder<bool>(
                      future: controller.isSelectedVault(model),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return ListTile(
                          selected: snapshot.data!,
                          contentPadding: const EdgeInsetsDirectional.only(start: 10),
                          leading: ProfilePicture(
                              name: model.name!,
                              radius: 30,
                              fontsize: Get.textTheme.bodyLarge!.fontSize!),
                          trailing: IconButton(
                              iconSize: 24,
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert_rounded)),
                          horizontalTitleGap: 10,
                          minVerticalPadding: 10,
                          title: Text(
                            "${model.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "${model.name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            performHapticFeedback();
                            prefs().setInt(prefSelectedVaultId, model.id);
                            Get.back();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getCustomSizedButton(
                text: "create vault",
                buttonType: EasyButtonType.outlined,
                height: 40,
                contentGap: 6.0,
                progressStrokeWidth: 2.0,
                onButtonPressed: () {
                  Get.back();
                  performHapticFeedback();
                  Get.bottomSheet(const GeneratePasswordBottomSheetView());
                },
              ),
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          performHapticFeedback();
          Get.bottomSheet(buildCredentialInsertionOptionBottomSheet());
        },
        tooltip: "Add password",
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<CredentialsModel>>(
        stream: controller.streamCredentials,
        builder: (context, snapshot) => ListView.builder(
          key: controller.lvbCredentialsKey,
          itemCount: snapshot.hasData ? snapshot.data?.length : 0,
          itemBuilder: (context, index) {
            CredentialsModel model = snapshot.data![index];
            return ListTile(
              contentPadding: const EdgeInsetsDirectional.only(start: 10),
              leading: ProfilePicture(
                  name: model.name!, radius: 30, fontsize: Get.textTheme.bodyLarge!.fontSize!),
              trailing: IconButton(
                iconSize: 24,
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () async {
                  performHapticFeedback();
                  bool isAuthenticated = await controller.authenticate();
                  if (isAuthenticated) {
                    Get.dialog(
                      buildAlertDialog(
                        model.name!,
                        controller.getTextForSubtitle(model),
                        negativeButtonText: "Edit",
                        negativeClick: () {
                          controller.handleEdit(model);
                        },
                      ),
                    );
                    Future.delayed(const Duration(seconds: 10),
                        () => (Get.isDialogOpen ?? false) ? Get.back() : ());
                  }
                },
              ),
              horizontalTitleGap: 10,
              minVerticalPadding: 10,
              title: Text(
                "${model.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                controller.getTextForSubtitle(model),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {},
            );
          },
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
              /*addCredentialInsertionTypeRow(
                icon: Icons.masks_outlined,
                title: "Alias",
                subTitle: "Get an email alias to use on new apps",
                onPressed: () {},
              ),*/
              addCredentialInsertionTypeRow(
                icon: Icons.credit_card,
                title: "Credit card",
                subTitle: "securely store your payment information",
                onPressed: () {
                  Go.toNamed(Routes.GENERATE_CARD_CREDENTIALS);
                },
              ),
              addCredentialInsertionTypeRow(
                icon: Icons.sticky_note_2_outlined,
                title: "note",
                subTitle: "jot down a PIN, code, or note to self",
                onPressed: () {
                  Go.toNamed(Routes.GENERATE_NOTE);
                },
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
          await Future.delayed(const Duration(milliseconds: 250), () {
            onPressed();
          });
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
