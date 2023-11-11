part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const opening = _Paths.opening;
  static const authentication = _Paths.authentication;
  static const bottomNavigation = _Paths.bottomNavigation;
  static const settings = _Paths.settings;
  static const home = _Paths.home;
  static const profile = _Paths.profile;
  static const newPost = _Paths.newPost;
  static const newIa = _Paths.newIa;
  static const visitorExplore = _Paths.visitorExplore;
}

abstract class _Paths {
  _Paths._();
  static const opening = '/opening';
  static const authentication = '/authentication';
  static const bottomNavigation = '/bottom-navigation';
  static const settings = '/settings';
  static const home = '/home';
  static const profile = '/profile';
  static const newPost = '/new-post';
  static const newIa = '/new-ia';
  static const visitorExplore = '/visitor-explore';
}
