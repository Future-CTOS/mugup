import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../pages/shared/views/dialogs/retry_dialog.dart';

class Utils {
  Utils._();

  static const double tinySpace = 2;
  static const double smallSpace = 4;
  static const double mediumSpace = 8;
  static const double semiLargeSpace = 12;
  static const double largeSpace = 16;
  static const double giantSpace = 32;

  static const SizedBox tinyVerticalSpace = SizedBox(height: tinySpace);
  static const SizedBox tinyHorizontalSpace = SizedBox(width: tinySpace);
  static const SizedBox smallVerticalSpace = SizedBox(height: smallSpace);
  static const SizedBox mediumVerticalSpace = SizedBox(height: mediumSpace);
  static const SizedBox semiLargeVerticalSpace = SizedBox(
    height: semiLargeSpace,
  );

  static const SizedBox smallHorizontalSpace = SizedBox(width: smallSpace);
  static const SizedBox semiLargeHorizontalSpace = SizedBox(
    width: semiLargeSpace,
  );
  static const SizedBox mediumHorizontalSpace = SizedBox(width: mediumSpace);

  static const EdgeInsets tinyPadding = EdgeInsets.all(tinySpace);
  static const EdgeInsets smallPadding = EdgeInsets.all(smallSpace);
  static const EdgeInsets mediumPadding = EdgeInsets.all(mediumSpace);
  static const EdgeInsets semiLargePadding = EdgeInsets.all(semiLargeSpace);

  static BorderRadius get normalCircularRadius => BorderRadius.circular(8);

  static void showRetryDialog(Future<void> Function() retry) {
    if (Get.context != null) {
      RetryDialog(onRetryTapped: retry).show(Get.context!);
    }
  }

  static String showProductPrice(double price) {
    if (_isEnglish) {
      return '\$${price.toStringAsFixed(4)}';
    }
    return 'تومان${price.toStringAsFixed(4)}';
  }

  static bool get _isEnglish =>
      (Get.locale?.languageCode ?? Get.deviceLocale?.languageCode) == 'en';
}
