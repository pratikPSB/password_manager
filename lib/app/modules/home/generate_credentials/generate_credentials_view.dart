import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'generate_credentials_controller.dart';

class GenerateCredentialsView extends GetView<GenerateCredentialsController> {
  const GenerateCredentialsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenerateCredentialsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenerateCredentialsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
