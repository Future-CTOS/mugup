import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mugup/src/infrastructure/routes/route_paths/route_paths.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'infrastructure/routes/route_pages/mugup_pages.dart';

class App extends StatelessWidget {
  final String title;

  const App({required this.title, super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    initialRoute: RoutePaths.splash,
    unknownRoute: MugupPages.notFoundPage,
    getPages: MugupPages.routes,
  );
}
