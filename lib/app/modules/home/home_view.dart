import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

import '../../data/db/CredentialsModel.dart';
import '../../data/resources/size_config.dart';
import 'generate_password_bottom_sheet/generate_password_bottom_sheet_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  late final StreamBuilder<List<VaultModel>> streamBuilder = StreamBuilder<List<VaultModel>>(
    key: controller.streamVaultKey,
    stream: controller.streamVault,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      return SliverList.builder(
        key: controller.lvbVaultKey,
        itemCount: snapshot.hasData ? snapshot.data?.length : 0,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsetsDirectional.only(start: 10),
            leading: ProfilePicture(
                name: snapshot.data![index].name!,
                radius: 30,
                fontsize: Get.textTheme.bodyLarge!.fontSize!),
            trailing: IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded)),
            horizontalTitleGap: 10,
            minVerticalPadding: 10,
            title: Text(
              "${snapshot.data?[index].name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text("${snapshot.data?[index].name}",
                maxLines: 2, overflow: TextOverflow.ellipsis),
            onTap: () {},
          );
        },
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  "Vaults",
                  style: Get.textTheme.headlineSmall,
                ),
              ),
              streamBuilder,
            ],
          ),
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
            return ListTile(
              contentPadding: const EdgeInsetsDirectional.only(start: 10),
              leading: ProfilePicture(
                  name: snapshot.data![index].name!,
                  radius: 30,
                  fontsize: Get.textTheme.bodyLarge!.fontSize!),
              trailing: IconButton(
                  iconSize: 24, onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
              horizontalTitleGap: 10,
              minVerticalPadding: 10,
              title: Expanded(
                child: Text(
                  "${snapshot.data?[index].name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Expanded(
                child: Text("${snapshot.data?[index].email}",
                    maxLines: 2, overflow: TextOverflow.ellipsis),
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
