import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../pages/details_product/common/details_product_binding.dart';
import '../../../pages/details_product/views/details_product_page.dart';
import '../../../pages/home/bindings/home_page_binding.dart';
import '../../../pages/home/controllers/home_page_controller.dart';
import '../../../pages/home/views/home_page.dart';
import '../../../pages/login/bindings/login_binding.dart';
import '../../../pages/login/controllers/login_controller.dart';
import '../../../pages/shared/views/not_found_page.dart';
import '../../../pages/signup/bindings/singup_binding.dart';
import '../../../pages/signup/controllers/signup_controller.dart';
import '../../../pages/splash/bindings/splash_binding.dart';
import '../../../pages/splash/controllers/splash_controller.dart';
import '../../../pages/splash/views/splash_screen.dart';
import '../route_paths/route_paths.dart';

class MugupPages {
  MugupPages._();

  static final List<GetPage> routes = [_splash, _signup, _login, _home];

  static GetPage<HomePageController> get _home => GetPage(
    name: RoutePaths.home,
    page: () => HomePage(),
    binding: HomePageBinding(),
    children: [_detailsProduct],
  );

  static GetPage<SplashController> get _splash => GetPage(
    name: RoutePaths.splash,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  );

  static GetPage<SignupController> get _signup => GetPage(
    name: RoutePaths.singUp,
    page: () => Placeholder(),
    binding: SingupBinding(),
  );

  static GetPage<LoginController> get _login => GetPage(
    name: RoutePaths.login,
    page: () => Placeholder(),
    binding: LoginBinding(),
  );

  static GetPage<LoginController> get _detailsProduct => GetPage(
    name: RoutePaths.detailsProduct,
    page: () => DetailsProductPage(),
    binding: DetailsProductBinding(),
  );

  static GetPage get notFoundPage =>
      GetPage(name: RoutePaths.notFound, page: () => NotFoundPage());
}
