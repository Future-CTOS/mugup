import 'package:flutter/widgets.dart';

class Utils {
  Utils._();

  static const double _tinySpace = 2;
  static const double _smallSpace = 4;

  static const SizedBox tinyVerticalSpace = SizedBox(height: _tinySpace);

  static const tinyPadding = EdgeInsets.all(_tinySpace);
  static const smallPadding = EdgeInsets.all(_smallSpace);
}
