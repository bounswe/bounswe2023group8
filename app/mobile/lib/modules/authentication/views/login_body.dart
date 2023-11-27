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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ThemePalette.main)),
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
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.navigateToForgotPassword();
                  },
                  child: Text('Forgot password?',
                      style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 18,
                      )),
                ),
              ],
            ),
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
                    activeColor: ThemePalette.main,
                    side: BorderSide(color: ThemePalette.dark),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Remember me',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
            const Spacer(flex: 5),
            CustomButton(
                onPressed: controller.onSignIn,
                width: 152,
                height: 50,
                shadow: true,
                text: 'Log in',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                inProgress: controller.loginInProgress.value,
                active: controller.loginUsernameValid.value &&
                    controller.loginPasswordValid.value),
            const Spacer(flex: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                InkWell(
                  onTap: controller.navigateToSignUp,
                  child: Text(' Sign up',
                      style: TextStyle(
                          color: ThemePalette.main,
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
