import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/authentication/controllers/forgot_password_controller.dart';

import '../../../data/widgets/custom_button.dart';
import '../../../data/widgets/custom_text_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemePalette.white,
      appBar: CustomAppBar(
        search: false,
        notification: false,
        actions: [],
        elevation: 0,
        leadingBackIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 7),
              Image.asset(
                Assets.logo,
                height: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              const Spacer(flex: 1),
              Text('Forgot Password?',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemePalette.main)),
              const Spacer(flex: 4),
              CustomTextField(
                hintText: 'E-mail',
                initialValue: controller.email.value,
                isValid: controller.emailValid.value,
                onChanged: (value) => controller.onChangeUsername(value),
                circularBorder: true,
                showSuffix: false,
              ),
              const Spacer(flex: 1),
              controller.verificationFailed.value
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Couldn't verify your email!",
                          style: TextStyle(color: ThemePalette.negative),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const Spacer(flex: 3),
              CustomButton(
                  onPressed: controller.onSubmit,
                  width: Get.width * 0.3,
                  shadow: true,
                  text: 'Submit',
                  active: controller.emailValid.value),
              const Spacer(flex: 18),
            ],
          );
        }),
      ),
    );
  }
}
