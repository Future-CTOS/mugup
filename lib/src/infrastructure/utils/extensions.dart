import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => (theme.brightness == Brightness.dark);

  Color? get iconColor => theme.iconTheme.color;

  TextTheme get textTheme => Theme.of(this).textTheme;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
