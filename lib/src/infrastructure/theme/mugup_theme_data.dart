import 'package:flutter/material.dart';

import '../../../gen/fonts.gen.dart';
import '../utils/utils.dart';

import '../../infrastructure/theme/theme_names.dart';

class MugupThemeData {
  MugupThemeData._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: ThemeNames.primaryColor,
    disabledColor: ThemeNames.disableColor,
    secondaryHeaderColor: ThemeNames.surfaceColor,
    fontFamily: FontFamily.popins,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ThemeNames.primaryColor,
      primary: ThemeNames.primaryColor,
      secondary: ThemeNames.disableColor,
    ),
    tabBarTheme: _tabBarTheme,
    iconTheme: _iconTheme,
    bottomNavigationBarTheme: _navigationBarTheme,
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: _textTheme,
  );

  static final BottomNavigationBarThemeData _navigationBarTheme =
      BottomNavigationBarThemeData(
        selectedIconTheme: _iconTheme,
        unselectedIconTheme: _iconTheme.copyWith(
          color: ThemeNames.disableColor,
        ),
        selectedLabelStyle: _textTheme.labelSmall,
        unselectedLabelStyle: _textTheme.labelSmall?.copyWith(
          color: ThemeNames.disableColor,
        ),
      );

  static final TabBarThemeData _tabBarTheme = TabBarThemeData(
    unselectedLabelColor: ThemeNames.disableColor,
    dividerColor: ThemeNames.disableColor,
    labelPadding: Utils.mediumPadding,
    labelStyle: _textTheme.titleMedium,
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelStyle: _textTheme.titleMedium?.copyWith(
      color: ThemeNames.disableColor,
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          vertical: Utils.mediumSpace,
          horizontal: Utils.semiLargeSpace,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeNames.primaryColor, width: 1.2),
          borderRadius: BorderRadius.circular(Utils.largeSpace),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeNames.disableColor, width: 2.5),
          borderRadius: BorderRadius.circular(Utils.largeSpace),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeNames.primaryColor, width: 1.8),
          borderRadius: BorderRadius.circular(Utils.largeSpace),
        ),
        hintStyle: TextStyle(
          color: ThemeNames.disableColor.withOpacity(0.7),
          fontWeight: FontWeight.w400,
        ),
      );

  static final TextTheme _textTheme = TextTheme(
    titleSmall: TextStyle(
      color: ThemeNames.disableColor,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: ThemeNames.primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: ThemeNames.headingColor,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      color: ThemeNames.headingColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: ThemeNames.paragraphColor,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: ThemeNames.paragraphColor,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      color: ThemeNames.primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 10,
    ),
  );

  static final IconThemeData _iconTheme = IconThemeData(
    color: ThemeNames.primaryColor,
  );
}
