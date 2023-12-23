import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/custom_text_field.dart';

import '../controllers/settings_controller.dart';

class ChangePasswordView extends GetView<SettingsController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingAppIcon: false,
        leadingBackIcon: true,
        search: false,
        notification: false,
        actions: [],
      ),
      body: Obx(() {
        return Column(
          children: [
            Container(
              width: Get.height,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                'Change Password',
                style: TextStyle(
                  color: ThemePalette.light,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.34,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  CustomTextField(
                    isValid: false,
                    hintText: 'Old Password',
                    onChanged: controller.onChangeOldPassword,
                    obscureText: controller.obscureOldPassword.value,
                    onSuffixTap: controller.toggleObscureOldPassword,
                    showSuffix: true,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isValid: false,
                    hintText: 'New Password',
                    onChanged: controller.onChangeNewPassword,
                    obscureText: controller.obscureNewPassword.value,
                    showSuffix: true,
                    isPassword: true,
                    onSuffixTap: controller.toggleObscureNewPassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isValid: false,
                    hintText: 'Confirm Password',
                    onChanged: controller.onChangeConfirmPassword,
                    obscureText: controller.obscureConfirmPassword.value,
                    onSuffixTap: controller.toggleObscureConfirmPassword,
                    showSuffix: true,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Change Password',
                    inProgress: controller.changePasswordInProgress.value,
                    onPressed: controller.onChangePassword,
                    active: controller.newPassword.value.length > 5 &&
                        (controller.newPassword.value ==
                            controller.confirmPassword.value),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
