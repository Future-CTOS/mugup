import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mugup/src/infrastructure/routes/route_paths/route_paths.dart';

import 'infrastructure/routes/route_pages/mugup_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'mugup',
    debugShowCheckedModeBanner: false,
    initialRoute: RoutePaths.splash,
    unknownRoute: MugupPages.notFoundPage,
    getPages: MugupPages.routes,
  );
}
