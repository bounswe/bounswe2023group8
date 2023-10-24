import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/authentication/controllers/forgot_password_controller.dart';

import '../../../data/widgets/custom_button.dart';
import '../../../data/widgets/custom_text_field.dart';

class ForgotPasswordBody extends GetView<ForgotPasswordController> {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    color: Palette.primaryColor)),
            const Spacer(flex: 4),
            CustomTextField(
              hintText: 'E-mail',
              initialValue: controller.loginEmail.value,
              isValid: controller.loginEmailValid.value,
              onChanged: (value) => controller.onChangeUsername(value),
              circularBorder: true,
              showSuffix: false,
            ),
            const Spacer(flex: 1),
            controller.verificationFailed.value ? const Row(
              children: [
                SizedBox(width: 20,),
                Text("Couldn't verify your email!", style: TextStyle(
                  color: Colors.red
                ),),
              ],
            ) : const SizedBox(),
            const Spacer(flex: 3),
            CustomButton(
                onPressed: controller.onSubmit,
                width: Get.width * 0.3,
                shadow: true,
                text: 'Submit',
                active: controller.loginEmailValid.value),
            const Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => controller.navigateToLogin(),
                  child: const Text('Go Back To Login Page',
                      style: TextStyle(
                          fontSize: 16,
                      )),
                ),
              ],
            ),
            const Spacer(flex: 15),
          ],
        );
      }),
    );
  }
}
