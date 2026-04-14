import 'package:flutter/material.dart';

/// ThemeExtension for design tokens that are NOT in Material's [ColorScheme].
/// Registered in both [AppTheme.darkTheme] and [AppTheme.lightTheme].
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.onSurfaceDim,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color onSurfaceDim;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color successContainer;
  final Color onSuccessContainer;

  // ─── Dark (Deep Emerald) ──────────────────────────────────────────────────
  static const AppColorTokens dark = AppColorTokens(
    onSurfaceDim: Color(0xFF6B8C85),
    warningContainer: Color(0xFF3D2A00),
    onWarningContainer: Color(0xFFFFE0A3),
    successContainer: Color(0xFF1A3D30),
    onSuccessContainer: Color(0xFFB2DFDB),
  );

  // ─── Light (Clean Emerald) ────────────────────────────────────────────────
  static const AppColorTokens light = AppColorTokens(
    onSurfaceDim: Color(0xFF9E9E9E),
    warningContainer: Color(0xFFFFF3CD),
    onWarningContainer: Color(0xFF7A4F00),
    successContainer: Color(0xFFD6FBF3),
    onSuccessContainer: Color(0xFF1A5C45),
  );

  @override
  AppColorTokens copyWith({
    Color? onSurfaceDim,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? successContainer,
    Color? onSuccessContainer,
  }) =>
      AppColorTokens(
        onSurfaceDim: onSurfaceDim ?? this.onSurfaceDim,
        warningContainer: warningContainer ?? this.warningContainer,
        onWarningContainer: onWarningContainer ?? this.onWarningContainer,
        successContainer: successContainer ?? this.successContainer,
        onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      );

  @override
  AppColorTokens lerp(AppColorTokens? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      onSurfaceDim: Color.lerp(onSurfaceDim, other.onSurfaceDim, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
    );
  }
}
