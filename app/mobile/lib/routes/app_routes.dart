part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const opening = _Paths.opening;
  static const authentication = _Paths.authentication;
}

abstract class _Paths {
  _Paths._();
  static const opening = '/opening';
  static const authentication = '/authentication';
}
