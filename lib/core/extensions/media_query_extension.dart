import 'package:flutter/material.dart';

extension SpacingExtension on BuildContext {
  /// Returns [percentage]% of the screen height.
  /// e.g. `context.height(50)` → half the screen height.
  double height(double percentage) => MediaQuery.of(this).size.height * percentage / 100;

  /// Returns [percentage]% of the screen width.
  double width(double percentage) => MediaQuery.of(this).size.width * percentage / 100;

  double verticalSpacing(double percentage) => MediaQuery.of(this).size.height * percentage / 100;

  double horizontalSpacing(double percentage) => MediaQuery.of(this).size.width * percentage / 100;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get topPadding => MediaQuery.of(this).padding.top;

  double get bottomPadding => MediaQuery.of(this).padding.bottom;
}
