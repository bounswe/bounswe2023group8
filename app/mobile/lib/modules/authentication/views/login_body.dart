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
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Obx(
        () {
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
              Text(
                'Log in',
                style: TextStyle(
                  color: ThemePalette.main,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(flex: 4),
              CustomTextField(
                hintText: 'E-mail or Username',
                initialValue: controller.loginUsername.value,
                isValid: controller.loginUsernameValid.value,
                onChanged: (value) => controller.onChangeUsername(value),
                circularBorder: true,
                showSuffix: false,
              ),
              const Spacer(flex: 2),
              CustomTextField(
                hintText: 'Password',
                initialValue: controller.loginPassword.value,
                isPassword: true,
                obscureText: controller.hideLoginPassword.value,
                onChanged: (value) => controller.onChangePassword(value),
                circularBorder: true,
                onSuffixTap: () => controller.togglePasswordVisibility(),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      controller.navigateToForgotPassword();
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 28.0,
                    width: 28.0,
                    child: Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.toggleRememberMe();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      activeColor: ThemePalette.main,
                      side: BorderSide(color: ThemePalette.dark),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      color: ThemePalette.dark,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 6),
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
                    controller.loginPasswordValid.value,
              ),
              const Spacer(flex: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: ThemePalette.dark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.35,
                    ),
                  ),
                  InkWell(
                    onTap: controller.navigateToSignUp,
                    child: Text(
                      ' Sign up',
                      style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.35,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 14),
            ],
          );
        },
      ),
    );
  }
}
