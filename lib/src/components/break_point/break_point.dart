import 'package:flutter/widgets.dart';
import 'package:mugup/src/infrastructure/utils/extensions.dart';
import 'device_sizes_constant.dart';

enum BreakPoint {
  smallPhone._(WidthSizesConstant.extraSmallWidth),
  mediumPhone._(WidthSizesConstant.smallWidth),
  smallTablet._(WidthSizesConstant.mediumWidth),
  largeTablet._(WidthSizesConstant.largeWidth),
  desktop._(WidthSizesConstant.extraLargeWidth),
  tv._(WidthSizesConstant.extraExtraLargeWidth);

  const BreakPoint._(this._maxWidth);

  final double _maxWidth;

  T either<T>({
    required final BuildContext context,
    required final T Function() before,
    required final T Function() after,
  }) => context.screenWidth < _maxWidth ? before() : after();

  T get<T>(
    final BuildContext context,
    T Function() defaultValue, {
    T Function()? smallPhone,
    T Function()? mediumPhone,
    T Function()? smallTablet,
    T Function()? largeTablet,
    T Function()? desktop,
    T Function()? tv,
  }) {
    final double width = MediaQuery.of(context).size.width;
    if (width < BreakPoint.smallPhone._maxWidth) {
      return smallPhone?.call() ?? defaultValue.call();
    } else if (width < BreakPoint.mediumPhone._maxWidth) {
      return mediumPhone?.call() ?? smallPhone?.call() ?? defaultValue.call();
    } else if (width < BreakPoint.smallTablet._maxWidth) {
      return smallTablet?.call() ??
          mediumPhone?.call() ??
          smallPhone?.call() ??
          defaultValue.call();
    } else if (width < BreakPoint.largeTablet._maxWidth) {
      return largeTablet?.call() ??
          smallTablet?.call() ??
          mediumPhone?.call() ??
          smallPhone?.call() ??
          defaultValue.call();
    } else if (width < BreakPoint.desktop._maxWidth) {
      return desktop?.call() ??
          largeTablet?.call() ??
          smallTablet?.call() ??
          mediumPhone?.call() ??
          smallPhone?.call() ??
          defaultValue.call();
    } else {
      return tv?.call() ??
          desktop?.call() ??
          largeTablet?.call() ??
          smallTablet?.call() ??
          mediumPhone?.call() ??
          smallPhone?.call() ??
          defaultValue.call();
    }
  }
}
