import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/main.dart';

/// Global loading overlay — shows a blurred backdrop with a spinner.
///
/// Usage:
/// ```dart
/// AppLoadingDialog.show(message: 'Signing in...');
/// AppLoadingDialog.hide();
/// ```
class AppLoadingDialog {
  AppLoadingDialog._();

  static OverlayEntry? _entry;
  static bool _pending = false;

  static void show({String message = 'Loading...'}) {
    hide();
    _pending = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_pending) return;

      final overlay = MyApp.navigatorKey.currentState?.overlay;
      if (overlay == null) return;

      hide();

      _entry = OverlayEntry(
        builder: (_) => Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Material(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: ColorPalette.primaryGreen),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: AppTextStyles.s12Bold.copyWith(color: ColorPalette.primaryGreen),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      overlay.insert(_entry!);
    });
  }

  static void hide() {
    _pending = false;
    _entry?.remove();
    _entry = null;
  }
}
