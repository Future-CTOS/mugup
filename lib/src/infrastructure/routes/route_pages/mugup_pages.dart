import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../pages/home/bindings/home_page_binding.dart';
import '../../../pages/login/bindings/login_binding.dart';
import '../../../pages/signup/bindings/singup_binding.dart';
import '../../../pages/splash/bindings/splash_binding.dart';
import '../../../pages/splash/views/splash_screen.dart';
import '../route_paths/route_paths.dart';

class MugupPages {
  MugupPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: RoutePaths.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: RoutePaths.singUp,
      page: () => Placeholder(),
      binding: SingupBinding(),
    ),

    GetPage(
      name: RoutePaths.login,
      page: () => Placeholder(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: RoutePaths.home,
      page: () => Placeholder(),
      binding: HomePageBinding(),
    ),
  ];
}
