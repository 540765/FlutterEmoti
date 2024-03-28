import 'package:emoti/packages.dart';
import 'package:emoti/pages/splash/splash_binding.dart';
import 'package:emoti/pages/splash/splash_view.dart';

class AppPaths {
  static final AppPaths _instance = AppPaths._();
  AppPaths._();
  factory AppPaths() => _instance;
  String splash = '/splash';
  String index = '/index';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._();
  AppRoutes._();
  factory AppRoutes() => _instance;

  String initRoute = AppPaths().splash;

  List<GetPage> routes = [
    GetPage(
      name: AppPaths().splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
