import 'package:get/get.dart';
import 'package:mobile/modules/authentication/views/auth_view.dart';
import 'package:mobile/modules/opening/bindings/opening_binding.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/opening/views/opening_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.opening;

  static final routes = [
    GetPage(
      name: _Paths.opening,
      page: () => const OpeningView(),
      binding: OpeningBinding(),
    ),
    GetPage(
      name: _Paths.authentication,
      page: () => const AuthView(),
      binding: AuthenticationBinding(),
    )
  ];
}
