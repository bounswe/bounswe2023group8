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
  static const editPost = _Paths.editPost;
  static const newIa = _Paths.newIa;
  static const interestArea = _Paths.interestArea;
  static const visitorExplore = _Paths.visitorExplore;
  static const postDetails = _Paths.postDetails;
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
  static const editPost = '/edit-post';
  static const newIa = '/new-ia';
  static const interestArea = '/interest-area';
  static const visitorExplore = '/visitor-explore';
  static const postDetails = '/post-details';
}
