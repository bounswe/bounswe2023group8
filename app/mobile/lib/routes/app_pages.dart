import 'package:get/get.dart';

import '../modules/visitor_explore/bindings/visitor_explore_binding.dart';
import '../modules/visitor_explore/views/visitor_explore_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/auth_view.dart';
import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/newIa/bindings/new_ia_binding.dart';
import '../modules/newIa/views/new_ia_view.dart';
import '../modules/newPost/bindings/new_post_binding.dart';
import '../modules/newPost/views/new_post_view.dart';
import '../modules/opening/bindings/opening_binding.dart';
import '../modules/opening/views/opening_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

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
    ),
    GetPage(
        name: _Paths.bottomNavigation,
        page: () => const BottomNavigationView(),
        binding: BottomNavigationBinding()),
    GetPage(
        name: _Paths.settings,
        page: () => const SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: _Paths.home,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.profile,
        page: () => const ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: _Paths.newPost,
        page: () => NewPostView(),
        binding: NewPostBinding()),
    GetPage(
        name: _Paths.newIa,
        page: () => const NewIaView(),
        binding: NewIaBinding()),
    GetPage(
      name: _Paths.visitorExplore,
      page: () => const VisitorExploreView(),
      binding: VisitorExploreBinding(),
    ),
  ];
}
