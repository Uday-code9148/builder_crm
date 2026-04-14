import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_color_tokens.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

/// Theme-adaptive color accessors for widget trees.
///
/// Adaptive tokens (surface, primary, text) resolve from [ColorScheme] /
/// [AppColorTokens] so they change with the active theme.
/// Static brand/status tokens (paidGreen, warningAmber, etc.) are the same
/// in every theme.
///
/// Usage: `final colors = context.colors;`
class AppColors {
  const AppColors._(this._cs, this._tokens);

  factory AppColors.of(BuildContext context) =>
      AppColors._(Theme.of(context).colorScheme, Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark);

  final ColorScheme _cs;
  final AppColorTokens _tokens;

  // ─── Adaptive — Surface ───────────────────────────────────────────────────
  Color get surface => _cs.surface;

  Color get surfaceContainerLowest => _cs.surfaceContainerLowest;

  Color get surfaceContainerLow => _cs.surfaceContainerLow;

  Color get surfaceContainer => _cs.surfaceContainer;

  Color get surfaceContainerHigh => _cs.surfaceContainerHigh;

  Color get surfaceContainerHighest => _cs.surfaceContainerHighest;

  // ─── Adaptive — Text on Surface ──────────────────────────────────────────
  Color get onSurface => _cs.onSurface;

  Color get onSurfaceVariant => _cs.onSurfaceVariant;

  Color get onSurfaceDim => _tokens.onSurfaceDim;

  // ─── Adaptive — Borders ──────────────────────────────────────────────────
  Color get outlineVariant => _cs.outlineVariant;

  Color get outline => _cs.outline;

  // ─── Adaptive — Primary Teal ─────────────────────────────────────────────
  Color get primaryTeal => _cs.primary;

  Color get onPrimaryTeal => _cs.onPrimary;

  Color get primaryTealContainer => _cs.primaryContainer;

  Color get onPrimaryTealContainer => _cs.onPrimaryContainer;

  // ─── Adaptive — Semantic ─────────────────────────────────────────────────
  Color get warningContainer => _tokens.warningContainer;

  Color get onWarningContainer => _tokens.onWarningContainer;

  Color get successContainer => _tokens.successContainer;

  Color get onSuccessContainer => _tokens.onSuccessContainer;

  Color get errorContainer => _cs.errorContainer;

  Color get onErrorContainer => _cs.onErrorContainer;

  Color get error => _cs.error;

  // ─── Static — Brand / Status (same in all themes) ────────────────────────
  Color get primaryTealFixed => ColorPalette.primaryTealFixed;

  Color get primaryTealFixedDim => ColorPalette.primaryTealFixedDim;

  Color get warningAmber => ColorPalette.warningAmber;

  Color get paidGreen => ColorPalette.paidGreen;

  Color get overdueRed => ColorPalette.overdueRed;

  Color get pendingTeal => ColorPalette.pendingTeal;

  Color get upcomingGrey => ColorPalette.upcomingGrey;

  Color get secondaryPurple => ColorPalette.secondaryPurple;

  Color get tertiaryTeal => ColorPalette.tertiaryTeal;

  Color get errorDeep => ColorPalette.errorDeep;

  Color get white => ColorPalette.white;
}

extension AppColorsX on BuildContext {
  AppColors get colors => AppColors.of(this);
}
