import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';

class OpeningView extends GetView<OpeningController> {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              text: 'Log in',
              onPressed: () {
                controller.navigateToAuthentication(toLogin: true);
              }),
          const SizedBox(height: 16),
          CustomButton(
              text: 'Sign up',
              onPressed: () {
                controller.navigateToAuthentication(toLogin: false);
              }),
        ],
      ),
    ));
  }
}
