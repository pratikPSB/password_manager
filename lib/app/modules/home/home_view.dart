import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/resources/assets.dart';
import 'package:password_manager/app/data/utils/constants.dart';
import 'package:password_manager/app/data/utils/encrypt_decrypt.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../data/customClasses/copy_text_view.dart';
import '../../data/customClasses/easy_button.dart';
import '../../data/model/credentials_model.dart';
import '../../data/model/vault_model.dart';
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
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: Scaffold.of(context).openDrawer,
              child: Obx(() => getImageView(
                  assetPath: controller.selectedVault.value.iconPath,
                  bgColor: controller.selectedVault.value.vaultColor,
                  margin: 8)),
            );
          },
        ),
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
                Obx(
                  () => SliverList.builder(
                    itemCount: controller.vaultList.value.isNotEmpty
                        ? controller.vaultList.value.length
                        : 0,
                    itemBuilder: (context, index) {
                      VaultModel model = controller.vaultList.value[index];
                      return Obx(
                        () => ListTile(
                          selected: model.id == controller.selectedVaultId.value,
                          contentPadding: const EdgeInsetsDirectional.only(start: 10),
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: getImageView(
                              assetPath: model.iconPath,
                              bgColor: model.vaultColor,
                            ),
                          ),
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
                          onTap: () async {
                            performHapticFeedback();
                            prefs().setInt(prefSelectedVaultId, model.id);
                            await controller.fetchSelectedVault();
                            Get.back();
                            controller.updateCredentialStream();
                          },
                        ),
                      );
                    },
                  ),
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
                onButtonPressed: () async {
                  Get.back();
                  performHapticFeedback();
                  await Future.delayed(const Duration(milliseconds: 250), () {
                    Go.toNamed(Routes.CREATE_VAULT);
                  });
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
          Get.bottomSheet(buildCredentialInsertionOptionBottomSheet(),
              backgroundColor: Get.theme.colorScheme.secondaryContainer);
        },
        tooltip: "Add password",
        child: const Icon(Icons.add),
      ),
      body: Obx(() => (controller.credentialsList.value.isEmpty)
          ? noDataWidget()
          : ListView.builder(
              key: controller.lvCredentialsKey,
              itemCount: controller.credentialsList.value.length,
              itemBuilder: (context, index) {
                CredentialsModel model = controller.credentialsList.value[index];
                return ListTile(
                  contentPadding: const EdgeInsetsDirectional.only(start: 10),
                  leading: ProfilePicture(
                      name: model.name!, radius: 30, fontsize: Get.textTheme.bodyLarge!.fontSize!),
                  trailing: buildPopupMenu(
                    list: controller.menuOptionsList,
                    onPopupItemSelected: (value) {
                      switch (value) {
                        case "Edit":
                          controller.handleEdit(model);
                          break;
                        case "Delete":
                          controller.handleDelete(model);
                          break;
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
                  onTap: () async {
                    performHapticFeedback();
                    bool isAuthenticated = await controller.authenticate();
                    if (isAuthenticated) {
                      showGetXDialog(
                          title: model.name!,
                          message: getCredentialCopyableData(model: model),
                          negativeButtonText: "Edit",
                          negativeClick: () {
                            controller.handleEdit(model);
                          },
                          onDismiss: () {
                            return Future(() {
                              controller.cancelTimer();
                              return true;
                            });
                          });
                      controller.assignAndStartTimer();
                    }
                  },
                );
              },
            )),
    );
  }

  Widget buildCredentialInsertionOptionBottomSheet() => Wrap(
        children: [
          Padding(
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
                  Get.bottomSheet(const GeneratePasswordBottomSheetView(),
                      backgroundColor: Get.theme.colorScheme.secondaryContainer);
                },
              ),
            ]),
          ),
        ],
      );

  Widget addCredentialInsertionTypeRow(
          {required IconData icon,
          required String title,
          required String subTitle,
          required Function() onPressed}) =>
      ListTile(
          contentPadding: const EdgeInsetsDirectional.only(start: 10),
          shape: 50.modifyShapeBorder(),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color("#9ECAff".getColorHexFromStr()).withOpacity(0.25),
            ),
            child: Icon(
              icon,
              size: 25,
              color: Color("#9ECAff".getColorHexFromStr()),
            ),
          ),
          horizontalTitleGap: 10,
          minVerticalPadding: 10,
          title: Text(
            title,
          ),
          subtitle: Text(
            subTitle,
          ),
          onTap: () async {
            performHapticFeedback();
            if (Get.isBottomSheetOpen ?? false) {
              Get.back();
            }
            //250 millis delay as bottomSheet's default dismiss time is 250 in get Lib.
            await Future.delayed(const Duration(milliseconds: 250), () {
              onPressed();
            });
          });

  Widget getCredentialCopyableData({required CredentialsModel model}) {
    switch (CredentialType.values.byName(model.credType!)) {
      case CredentialType.login:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CopyTextView(text: controller.getTextForSubtitle(model)),
            CopyTextView(text: EncryptionUtils().decryptAES(model.password!), obscureText: true),
          ],
        );
      case CredentialType.card:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CopyTextView(text: controller.getTextForSubtitle(model), obscureText: true),
            CopyTextView(text: EncryptionUtils().decryptAES(model.nameOnCard!)),
            CopyTextView(text: EncryptionUtils().decryptAES(model.expiryDate!)),
            CopyTextView(text: EncryptionUtils().decryptAES(model.cvvCode!), obscureText: true),
          ],
        );
      case CredentialType.note:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CopyTextView(text: EncryptionUtils().decryptAES(model.password!), obscureText: true),
            CopyTextView(text: controller.getTextForSubtitle(model)),
          ],
        );
      case CredentialType.alias:
        return Container();
    }
  }
}
