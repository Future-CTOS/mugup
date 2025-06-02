import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mugup/src/infrastructure/theme/mugup_text_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../gen/fonts.gen.dart';
import 'infrastructure/routes/route_pages/mugup_pages.dart';
import 'infrastructure/routes/route_paths/route_paths.dart';
import 'infrastructure/theme/themes.dart';

class App extends StatelessWidget {
  final String title;

  const App({required this.title, super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: FontFamily.popins,
      useMaterial3: true,
      textTheme: MugupTextTheme.textTheme,
    ),
    initialRoute: RoutePaths.splash,
    unknownRoute: MugupPages.notFoundPage,
    getPages: MugupPages.routes,
  );
}
