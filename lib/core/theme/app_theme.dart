import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class AppTheme {
  // ─── Dark (Architectural Curator — Deep Emerald) ───────────────────────────
  static final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: ColorPalette.surface,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      foregroundColor: ColorPalette.onSurface,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorPalette.surfaceContainerLow,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorPalette.primaryTeal,
      unselectedItemColor: ColorPalette.onSurfaceDim,
      unselectedLabelStyle: AppTextStyles.s10Regular.copyWith(color: ColorPalette.onSurfaceDim),
      selectedLabelStyle: AppTextStyles.s10Medium.copyWith(color: ColorPalette.primaryTeal),
      showUnselectedLabels: true,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: ColorPalette.surfaceContainerHigh,
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      disabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(ColorPalette.primaryTeal),
      errorBorder: _inputBorder(ColorPalette.errorDeep),
      focusedErrorBorder: _inputBorder(ColorPalette.errorDeep),
      hintStyle: AppTextStyles.s14Regular.copyWith(color: ColorPalette.onSurfaceDim),
      labelStyle: AppTextStyles.s13Regular.copyWith(color: ColorPalette.onSurfaceVariant),
      errorStyle: AppTextStyles.s12Regular.copyWith(color: ColorPalette.errorDeep),
    ),
    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(ColorPalette.surface),
      fillColor: WidgetStatePropertyAll(ColorPalette.primaryTeal),
    ),
    textTheme: GoogleFonts.lexendDecaTextTheme().apply(
      bodyColor: ColorPalette.onSurface,
      displayColor: ColorPalette.onSurface,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      // Primary
      primary: ColorPalette.primaryTeal,
      onPrimary: ColorPalette.onPrimaryTeal,
      primaryContainer: ColorPalette.primaryTealContainer,
      onPrimaryContainer: ColorPalette.onPrimaryTealContainer,
      // Secondary (purple urgency)
      secondary: ColorPalette.secondaryPurple,
      onSecondary: ColorPalette.onSecondaryPurple,
      secondaryContainer: ColorPalette.secondaryPurpleContainer,
      onSecondaryContainer: ColorPalette.onSecondaryPurple,
      // Tertiary (muted teal)
      tertiary: ColorPalette.primaryTealFixedDim,
      onTertiary: ColorPalette.onPrimaryTeal,
      tertiaryContainer: ColorPalette.successContainer,
      onTertiaryContainer: ColorPalette.onSuccessContainer,
      // Surface
      surface: ColorPalette.surface,
      onSurface: ColorPalette.onSurface,
      surfaceContainerHighest: ColorPalette.surfaceContainerHighest,
      surfaceContainerHigh: ColorPalette.surfaceContainerHigh,
      surfaceContainer: ColorPalette.surfaceContainer,
      surfaceContainerLow: ColorPalette.surfaceContainerLow,
      surfaceContainerLowest: ColorPalette.surfaceContainerLowest,
      onSurfaceVariant: ColorPalette.onSurfaceVariant,
      // Error
      error: ColorPalette.errorDeep,
      onError: ColorPalette.onErrorContainer,
      errorContainer: ColorPalette.errorContainer,
      onErrorContainer: ColorPalette.onErrorContainer,
      // Misc
      outline: ColorPalette.outline,
      outlineVariant: ColorPalette.outlineVariant,
      inversePrimary: ColorPalette.primaryTealFixed,
      scrim: Color(0x80000000),
      shadow: ColorPalette.onPrimaryTeal,
    ),
    cardTheme: CardThemeData(
      color: ColorPalette.surfaceContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorPalette.outlineVariant.withValues(alpha: 0.15), width: 1),
      ),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
      space: 0,
    ),
    switchTheme: _switchTheme(),
    timePickerTheme: _timePickerTheme(),
    datePickerTheme: _datePickerTheme(),
  );

  // ─── Light (clean emerald) ──────────────────────────────────────────────────
  static final ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: const Color(0xFFF4F6F5),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.white,
      elevation: 0,
      centerTitle: false,
      foregroundColor: ColorPalette.primaryDarkColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorPalette.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorPalette.primaryTealFixed,
      unselectedItemColor: ColorPalette.gray600,
      unselectedLabelStyle: AppTextStyles.s10Regular.copyWith(color: ColorPalette.gray600),
      selectedLabelStyle: AppTextStyles.s10Medium.copyWith(color: ColorPalette.primaryTealFixed),
      showUnselectedLabels: true,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: const Color(0xFFF0F4F3),
      border: _inputBorderLight(),
      enabledBorder: _inputBorderLight(),
      disabledBorder: _inputBorderLight(),
      focusedBorder: _inputBorderLight(ColorPalette.primaryTealFixed),
      errorBorder: _inputBorderLight(ColorPalette.red600),
      focusedErrorBorder: _inputBorderLight(ColorPalette.red600),
      hintStyle: AppTextStyles.s14Regular.copyWith(color: ColorPalette.gray500),
      labelStyle: AppTextStyles.s13Regular.copyWith(color: ColorPalette.gray700),
    ),
    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(ColorPalette.white),
      fillColor: WidgetStatePropertyAll(ColorPalette.primaryTealFixed),
    ),
    textTheme: GoogleFonts.lexendDecaTextTheme(),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorPalette.primaryTealFixed,
      onPrimary: ColorPalette.white,
      primaryContainer: ColorPalette.lightGreen,
      onPrimaryContainer: ColorPalette.onPrimaryTeal,
      secondary: ColorPalette.secondaryPurple,
      onSecondary: ColorPalette.white,
      secondaryContainer: ColorPalette.melrose,
      onSecondaryContainer: ColorPalette.purple,
      tertiary: ColorPalette.primaryTealFixedDim,
      onTertiary: ColorPalette.white,
      tertiaryContainer: ColorPalette.candiedSnow,
      onTertiaryContainer: ColorPalette.onPrimaryTeal,
      surface: ColorPalette.white,
      onSurface: ColorPalette.primaryDarkColor,
      surfaceContainerHighest: ColorPalette.gray200,
      surfaceContainerHigh: ColorPalette.gray100,
      surfaceContainer: ColorPalette.whiteSolid,
      surfaceContainerLow: const Color(0xFFF0F4F3),
      surfaceContainerLowest: ColorPalette.white,
      onSurfaceVariant: ColorPalette.gray700,
      error: ColorPalette.fadedRed,
      onError: ColorPalette.white,
      errorContainer: ColorPalette.fededRed,
      onErrorContainer: ColorPalette.deepCrimsonRed,
      outline: ColorPalette.gray400,
      outlineVariant: ColorPalette.gray200,
      inversePrimary: ColorPalette.primaryTeal,
      scrim: Color(0x40000000),
      shadow: Color(0x1A000000),
    ),
    cardTheme: CardThemeData(
      color: ColorPalette.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E7E5), width: 1),
      ),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(color: Colors.transparent, space: 0),
    switchTheme: _switchTheme(),
    timePickerTheme: _timePickerTheme(),
    datePickerTheme: _datePickerTheme(),
  );

  // ─── Shared helpers ────────────────────────────────────────────────────────

  static OutlineInputBorder _inputBorder([Color color = ColorPalette.outlineVariant]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(10),
      );

  static OutlineInputBorder _inputBorderLight([Color color = const Color(0xFFDDE4E2)]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(10),
      );

  static SwitchThemeData _switchTheme() => SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorPalette.primaryTeal.withValues(alpha: 0.5);
      }
      return ColorPalette.outlineVariant;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return ColorPalette.primaryTeal;
      return ColorPalette.onSurfaceVariant;
    }),
    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
  );

  static DatePickerThemeData _datePickerTheme() => DatePickerThemeData(
    backgroundColor: ColorPalette.surfaceContainer,
    headerBackgroundColor: ColorPalette.primaryTealFixed,
    headerForegroundColor: ColorPalette.white,
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return ColorPalette.onSurfaceDim;
      if (states.contains(WidgetState.selected)) return ColorPalette.onPrimaryTeal;
      return ColorPalette.onSurface;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return ColorPalette.primaryTeal;
      return null;
    }),
    todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return ColorPalette.primaryTeal;
      return ColorPalette.primaryTeal.withValues(alpha: 0.3);
    }),
    todayForegroundColor: const WidgetStatePropertyAll(ColorPalette.onPrimaryTeal),
    cancelButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(ColorPalette.onSurfaceVariant)),
    confirmButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(ColorPalette.primaryTeal)),
  );

  static TimePickerThemeData _timePickerTheme() => TimePickerThemeData(
    backgroundColor: ColorPalette.surfaceContainer,
    hourMinuteTextColor: ColorPalette.onSurface,
    dialHandColor: ColorPalette.primaryTeal,
    dialBackgroundColor: ColorPalette.surfaceContainerHigh,
    cancelButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(ColorPalette.onSurfaceVariant)),
    confirmButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(ColorPalette.primaryTeal)),
  );
}
