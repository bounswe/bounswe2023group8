import 'package:get/get.dart';
import 'package:mobile/modules/authentication/controllers/login_controller.dart';
import 'package:mobile/modules/authentication/controllers/sign_up_controller.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
