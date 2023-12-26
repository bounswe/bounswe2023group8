import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/authentication/controllers/authentication_controller.dart';
import 'package:mobile/modules/authentication/views/login_body.dart';
import 'package:mobile/modules/authentication/views/sign_up_body.dart';

class AuthView extends GetView<AuthenticationController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leadingBackIcon: true,
          leadingAppIcon: false,
          backgroundColor: BackgroundPalette.soft,
          search: false,
          notification: false,
          elevation: 0,
          actions: [],
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: BackgroundPalette.soft,
        body: Obx(() {
          if (controller.isLogin.value) {
            return const LoginBody();
          } else {
            return const SignUpBody();
          }
        }));
  }
}
