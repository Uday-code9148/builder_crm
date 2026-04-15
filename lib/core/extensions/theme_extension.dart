import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  /// Returns [light] when the app is in light mode, [dark] otherwise.
  T getThemeValue<T>({required T light, required T dark}) => Theme.of(this).brightness == Brightness.light ? light : dark;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
