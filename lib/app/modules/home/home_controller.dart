import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class HomeController extends GetxController {
  final streamVaultKey = GlobalKey<FormState>();
  final streamCredentialsKey = GlobalKey<FormState>();

  final streamVault = objectBox.getVaults();
  final streamCredentials = objectBox.getCredentials();

  final lvbVaultKey = const PageStorageKey("keep vault alive");
  final lvbCredentialsKey = const PageStorageKey("keep credentials alive");
}
