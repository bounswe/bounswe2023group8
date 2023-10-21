import 'package:get/get.dart';
import 'package:mobile/modules/authentication/views/auth_view.dart';

class AuthenticationController extends GetxController {
  var isLogin = true.obs;

  void navigateToAuth({required bool toLogin}) {
    isLogin.value = toLogin;
    Get.to(() => const AuthView());
  }

  void switchAuthView() {
    isLogin.value = !isLogin.value;
  }

  @override
  void onInit() {
    super.onInit();
    isLogin.value = Get.arguments['toLogin'] ?? true;
  }

  @override
  void onClose() {}
}
