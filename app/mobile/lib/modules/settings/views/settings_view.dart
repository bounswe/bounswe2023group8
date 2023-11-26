import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingAppIcon: true,
      ),
      body: Center(
          child: CustomButton(text: 'Logout', onPressed: controller.onLogout)
      ),
    );
  }
}
