import 'package:flutter/widgets.dart';

class Utils {
  Utils._();

  static const double tinySpace = 2;
  static const double smallSpace = 4;
  static const double mediumSpace = 8;
  static const double semiLargeSpace = 12;
  static const double largeSpace = 16;
  static const double giantSpace = 32;

  // ---------------
  static const SizedBox tinyVerticalSpace = SizedBox(height: tinySpace);
  static const SizedBox smallVerticalSpace = SizedBox(height: smallSpace);
  static const SizedBox mediumVerticalSpace = SizedBox(height: mediumSpace);
  static const SizedBox semiLargeVerticalSpace = SizedBox(
    height: semiLargeSpace,
  );

  // ---------------
  static const SizedBox smallHorizontalSpace = SizedBox(width: smallSpace);
  static const SizedBox mediumHorizontalSpace = SizedBox(width: mediumSpace);

  // ---------------
  static const EdgeInsets tinyPadding = EdgeInsets.all(tinySpace);
  static const EdgeInsets smallPadding = EdgeInsets.all(smallSpace);
  static const EdgeInsets mediumPadding = EdgeInsets.all(mediumSpace);
  static const EdgeInsets semiLargePadding = EdgeInsets.all(semiLargeSpace);
}
