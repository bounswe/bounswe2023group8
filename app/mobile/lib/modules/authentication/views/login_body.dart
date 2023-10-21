import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/authentication/controllers/login_controller.dart';

import '../../../data/widgets/custom_button.dart';
import '../../../data/widgets/custom_text_field.dart';

class LoginBody extends GetView<LoginController> {
  const LoginBody({super.key});

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
            Text('Log in',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Palette.primaryColor)),
            const Spacer(flex: 4),
            CustomTextField(
              hintText: 'E-mail or Username',
              initialValue: controller.loginUsername.value,
              isValid: controller.loginUsernameValid.value,
              onChanged: (value) => controller.onChangeUsername(value),
              circularBorder: true,
              showSuffix: false,
            ),
            const Spacer(flex: 1),
            CustomTextField(
                hintText: 'Password',
                initialValue: controller.loginPassword.value,
                isPassword: true,
                obscureText: controller.hideLoginPassword.value,
                onChanged: (value) => controller.onChangePassword(value),
                circularBorder: true,
                onSuffixTap: () => controller.togglePasswordVisibility()),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 26.0,
                      width: 26.0,
                      child: Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.toggleRememberMe();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: Colors.green,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('Remember me',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Text('Forgot password?',
                      style: TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 16,
                      )),
                ),
              ],
            ),
            const Spacer(flex: 5),
            CustomButton(
                onPressed: controller.onSignIn,
                width: Get.width * 0.3,
                shadow: true,
                text: 'Log in',
                inProgress: controller.loginInProgress.value,
                active: controller.loginUsernameValid.value &&
                    controller.loginPasswordValid.value),
            const Spacer(flex: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                InkWell(
                  onTap: controller.navigateToSignUp,
                  child: Text(' Sign up',
                      style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
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
