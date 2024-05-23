import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'select_vault_controller.dart';

class SelectVaultView extends GetView<SelectVaultController> {
  const SelectVaultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectVaultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelectVaultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
