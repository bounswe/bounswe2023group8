import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../data/constants/assets.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              Assets.logo,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            controller.logout();
          },
          child: const Text('Log Out'),
        )));
  }
}
