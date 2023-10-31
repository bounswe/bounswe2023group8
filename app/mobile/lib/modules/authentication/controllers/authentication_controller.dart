import 'dart:async';

import 'package:get/get.dart';
import 'package:mobile/modules/authentication/views/auth_view.dart';
import 'package:uni_links/uni_links.dart';

import '../../../routes/app_pages.dart';


class AuthenticationController extends GetxController {
  var isLogin = true.obs;
  var isForgotPassword = false.obs;

  late StreamSubscription _sub;

  String veriyEmailToken = '';

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        if (uri.pathSegments[0] == 'registration-confirm') {
          veriyEmailToken = uri.queryParameters['token'] ?? '';
          Get.offAllNamed(Routes.bottomNavigation,
              arguments: {'token': veriyEmailToken});
        }
      }
    }, onError: (err) {});
  }


  void navigateToAuth({required bool toLogin}) {
    isLogin.value = toLogin;
    Get.to(() => const AuthView());
  }

  void switchAuthView() {
    isLogin.value = !isLogin.value;
  }

  void toggleForgotPassword() {
    isLogin.value = isForgotPassword.value;
    isForgotPassword.value = !isForgotPassword.value;
  }

  @override
  void onInit() {
    super.onInit();
    isLogin.value = Get.arguments['toLogin'] ?? true;
  }

  @override
  void onClose() {
    _sub.cancel();
  }
}
