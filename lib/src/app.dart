import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shayan.dart';
import 'infrastructure/routes/route_pages/mugup_pages.dart';
import 'infrastructure/routes/route_paths/route_paths.dart';
import 'infrastructure/theme/mugup_theme_data.dart';

class App extends StatelessWidget {
  final String title;

  const App({required this.title, super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    theme: MugupThemeData.theme,
    home: Shayan(),
    // initialRoute: RoutePaths.splash,
    // unknownRoute: MugupPages.notFoundPage,
    // getPages: MugupPages.routes,
  );
}
