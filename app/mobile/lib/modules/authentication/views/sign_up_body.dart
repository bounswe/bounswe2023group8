import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/authentication/controllers/sign_up_controller.dart';

class SignUpBody extends GetView<SignUpController> {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sign up'),
    );
  }
}
