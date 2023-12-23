import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/custom_text_field.dart';

import '../controllers/settings_controller.dart';

class ChangePasswordView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leadingAppIcon: true),
      body: Obx(() {
        return Column(
          children: [
            Container(
              width: Get.height,
              decoration: const BoxDecoration(
                color: Color(0xFF486375),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: const Text(
                textAlign: TextAlign.center,
                'Change Password',
                style: TextStyle(
                  color: Color(0xFFF1F1F1),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
