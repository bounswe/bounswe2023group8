import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/settings/views/privacy_view.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingAppIcon: true,
        search: false,
        notification: false,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 32, right: 16, top: 56, bottom: 16),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.regular,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail',
                        style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BackgroundPalette.light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.bottomNavigationController.signedInUser
                                  ?.email ??
                              '',
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BackgroundPalette.light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '@${controller.bottomNavigationController.signedInUser?.username}',
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              color: ThemePalette.dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.24,
                            ),
                          ),
                          InkWell(
                            onTap: controller.navigateToChangePassword,
                            child: Image.asset(
                              Assets.edit,
                              width: 12,
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BackgroundPalette.light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '*' * 8,
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Birthday',
                        style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BackgroundPalette.light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.bottomNavigationController.signedInUser
                                  ?.birthday ??
                              '',
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: controller.onDeleteUser,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              color: ThemePalette.negative,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                  color: ThemePalette.light,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: BackgroundPalette.dark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Account',
                    style: TextStyle(
                      color: ThemePalette.light,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.34,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const PrivacyAndSafetyView());
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: BackgroundPalette.dark,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: ThemePalette.light,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.34,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: controller.onLogout,
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: BackgroundPalette.dark,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Log out',
                  style: TextStyle(
                    color: ThemePalette.light,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.34,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
