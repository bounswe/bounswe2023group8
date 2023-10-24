import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/authentication/controllers/authentication_controller.dart';
import 'package:mobile/modules/authentication/views/forgot_password_body.dart';
import 'package:mobile/modules/authentication/views/login_body.dart';
import 'package:mobile/modules/authentication/views/sign_up_body.dart';

class AuthView extends GetView<AuthenticationController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.scaffoldBackgroundColor,
        body: Obx(() {
          if (controller.isLogin.value) {
            return const LoginBody();
          } else {
            if(controller.isForgotPassword.value){
              return const ForgotPasswordBody();
            }else{
              return const SignUpBody();
            }
          }
        }));
  }
}
