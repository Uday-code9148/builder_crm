import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Predefined [TextStyle]s using **Lexend Deca** (Google Fonts).
///
/// Naming convention: `s{size}{Weight}`
/// e.g. `AppTextStyles.s14Bold`, `AppTextStyles.s12Regular`
class AppTextStyles {
  static TextStyle _base(double size, FontWeight weight) =>
      GoogleFonts.lexendDeca(fontSize: size, fontWeight: weight).copyWith(overflow: TextOverflow.visible);

  // ─── 8 ────────────────────────────────────────────────────────────────────
  static TextStyle get s8Thin => _base(8, FontWeight.w100);

  static TextStyle get s8ExtraLight => _base(8, FontWeight.w200);

  static TextStyle get s8Light => _base(8, FontWeight.w300);

  static TextStyle get s8Regular => _base(8, FontWeight.w400);

  static TextStyle get s8Medium => _base(8, FontWeight.w500);

  static TextStyle get s8SemiBold => _base(8, FontWeight.w600);

  static TextStyle get s8Bold => _base(8, FontWeight.w700);

  static TextStyle get s8ExtraBold => _base(8, FontWeight.w800);

  static TextStyle get s8Black => _base(8, FontWeight.w900);

  // ─── 9 ────────────────────────────────────────────────────────────────────
  static TextStyle get s9Thin => _base(9, FontWeight.w100);

  static TextStyle get s9ExtraLight => _base(9, FontWeight.w200);

  static TextStyle get s9Light => _base(9, FontWeight.w300);

  static TextStyle get s9Regular => _base(9, FontWeight.w400);

  static TextStyle get s9Medium => _base(9, FontWeight.w500);

  static TextStyle get s9SemiBold => _base(9, FontWeight.w600);

  static TextStyle get s9Bold => _base(9, FontWeight.w700);

  static TextStyle get s9ExtraBold => _base(9, FontWeight.w800);

  static TextStyle get s9Black => _base(9, FontWeight.w900);

  // ─── 10 ───────────────────────────────────────────────────────────────────
  static TextStyle get s10Thin => _base(10, FontWeight.w100);

  static TextStyle get s10ExtraLight => _base(10, FontWeight.w200);

  static TextStyle get s10Light => _base(10, FontWeight.w300);

  static TextStyle get s10Regular => _base(10, FontWeight.w400);

  static TextStyle get s10Medium => _base(10, FontWeight.w500);

  static TextStyle get s10SemiBold => _base(10, FontWeight.w600);

  static TextStyle get s10Bold => _base(10, FontWeight.w700);

  static TextStyle get s10ExtraBold => _base(10, FontWeight.w800);

  static TextStyle get s10Black => _base(10, FontWeight.w900);

  // ─── 11 ───────────────────────────────────────────────────────────────────
  static TextStyle get s11Thin => _base(11, FontWeight.w100);

  static TextStyle get s11ExtraLight => _base(11, FontWeight.w200);

  static TextStyle get s11Light => _base(11, FontWeight.w300);

  static TextStyle get s11Regular => _base(11, FontWeight.w400);

  static TextStyle get s11Medium => _base(11, FontWeight.w500);

  static TextStyle get s11SemiBold => _base(11, FontWeight.w600);

  static TextStyle get s11Bold => _base(11, FontWeight.w700);

  static TextStyle get s11ExtraBold => _base(11, FontWeight.w800);

  static TextStyle get s11Black => _base(11, FontWeight.w900);

  // ─── 12 ───────────────────────────────────────────────────────────────────
  static TextStyle get s12Thin => _base(12, FontWeight.w100);

  static TextStyle get s12ExtraLight => _base(12, FontWeight.w200);

  static TextStyle get s12Light => _base(12, FontWeight.w300);

  static TextStyle get s12Regular => _base(12, FontWeight.w400);

  static TextStyle get s12Medium => _base(12, FontWeight.w500);

  static TextStyle get s12SemiBold => _base(12, FontWeight.w600);

  static TextStyle get s12Bold => _base(12, FontWeight.w700);

  static TextStyle get s12ExtraBold => _base(12, FontWeight.w800);

  static TextStyle get s12Black => _base(12, FontWeight.w900);

  // ─── 13 ───────────────────────────────────────────────────────────────────
  static TextStyle get s13Thin => _base(13, FontWeight.w100);

  static TextStyle get s13ExtraLight => _base(13, FontWeight.w200);

  static TextStyle get s13Light => _base(13, FontWeight.w300);

  static TextStyle get s13Regular => _base(13, FontWeight.w400);

  static TextStyle get s13Medium => _base(13, FontWeight.w500);

  static TextStyle get s13SemiBold => _base(13, FontWeight.w600);

  static TextStyle get s13Bold => _base(13, FontWeight.w700);

  static TextStyle get s13ExtraBold => _base(13, FontWeight.w800);

  static TextStyle get s13Black => _base(13, FontWeight.w900);

  // ─── 14 ───────────────────────────────────────────────────────────────────
  static TextStyle get s14Thin => _base(14, FontWeight.w100);

  static TextStyle get s14ExtraLight => _base(14, FontWeight.w200);

  static TextStyle get s14Light => _base(14, FontWeight.w300);

  static TextStyle get s14Regular => _base(14, FontWeight.w400);

  static TextStyle get s14Medium => _base(14, FontWeight.w500);

  static TextStyle get s14SemiBold => _base(14, FontWeight.w600);

  static TextStyle get s14Bold => _base(14, FontWeight.w700);

  static TextStyle get s14ExtraBold => _base(14, FontWeight.w800);

  static TextStyle get s14Black => _base(14, FontWeight.w900);

  // ─── 15 ───────────────────────────────────────────────────────────────────
  static TextStyle get s15Thin => _base(15, FontWeight.w100);

  static TextStyle get s15ExtraLight => _base(15, FontWeight.w200);

  static TextStyle get s15Light => _base(15, FontWeight.w300);

  static TextStyle get s15Regular => _base(15, FontWeight.w400);

  static TextStyle get s15Medium => _base(15, FontWeight.w500);

  static TextStyle get s15SemiBold => _base(15, FontWeight.w600);

  static TextStyle get s15Bold => _base(15, FontWeight.w700);

  static TextStyle get s15ExtraBold => _base(15, FontWeight.w800);

  static TextStyle get s15Black => _base(15, FontWeight.w900);

  // ─── 16 ───────────────────────────────────────────────────────────────────
  static TextStyle get s16Thin => _base(16, FontWeight.w100);

  static TextStyle get s16ExtraLight => _base(16, FontWeight.w200);

  static TextStyle get s16Light => _base(16, FontWeight.w300);

  static TextStyle get s16Regular => _base(16, FontWeight.w400);

  static TextStyle get s16Medium => _base(16, FontWeight.w500);

  static TextStyle get s16SemiBold => _base(16, FontWeight.w600);

  static TextStyle get s16Bold => _base(16, FontWeight.w700);

  static TextStyle get s16ExtraBold => _base(16, FontWeight.w800);

  static TextStyle get s16Black => _base(16, FontWeight.w900);

  // ─── 17 ───────────────────────────────────────────────────────────────────
  static TextStyle get s17Thin => _base(17, FontWeight.w100);

  static TextStyle get s17ExtraLight => _base(17, FontWeight.w200);

  static TextStyle get s17Light => _base(17, FontWeight.w300);

  static TextStyle get s17Regular => _base(17, FontWeight.w400);

  static TextStyle get s17Medium => _base(17, FontWeight.w500);

  static TextStyle get s17SemiBold => _base(17, FontWeight.w600);

  static TextStyle get s17Bold => _base(17, FontWeight.w700);

  static TextStyle get s17ExtraBold => _base(17, FontWeight.w800);

  static TextStyle get s17Black => _base(17, FontWeight.w900);

  // ─── 18 ───────────────────────────────────────────────────────────────────
  static TextStyle get s18Thin => _base(18, FontWeight.w100);

  static TextStyle get s18ExtraLight => _base(18, FontWeight.w200);

  static TextStyle get s18Light => _base(18, FontWeight.w300);

  static TextStyle get s18Regular => _base(18, FontWeight.w400);

  static TextStyle get s18Medium => _base(18, FontWeight.w500);

  static TextStyle get s18SemiBold => _base(18, FontWeight.w600);

  static TextStyle get s18Bold => _base(18, FontWeight.w700);

  static TextStyle get s18ExtraBold => _base(18, FontWeight.w800);

  static TextStyle get s18Black => _base(18, FontWeight.w900);

  // ─── 20 ───────────────────────────────────────────────────────────────────
  static TextStyle get s20Regular => _base(20, FontWeight.w400);

  static TextStyle get s20Medium => _base(20, FontWeight.w500);

  static TextStyle get s20SemiBold => _base(20, FontWeight.w600);

  static TextStyle get s20Bold => _base(20, FontWeight.w700);

  // ─── 22 ───────────────────────────────────────────────────────────────────
  static TextStyle get s22Thin => _base(22, FontWeight.w100);

  static TextStyle get s22ExtraLight => _base(22, FontWeight.w200);

  static TextStyle get s22Light => _base(22, FontWeight.w300);

  static TextStyle get s22Regular => _base(22, FontWeight.w400);

  static TextStyle get s22Medium => _base(22, FontWeight.w500);

  static TextStyle get s22SemiBold => _base(22, FontWeight.w600);

  static TextStyle get s22Bold => _base(22, FontWeight.w700);

  static TextStyle get s22ExtraBold => _base(22, FontWeight.w800);

  static TextStyle get s22Black => _base(22, FontWeight.w900);

  // ─── 24 ───────────────────────────────────────────────────────────────────
  static TextStyle get s24Regular => _base(24, FontWeight.w400);

  static TextStyle get s24Medium => _base(24, FontWeight.w500);

  static TextStyle get s24SemiBold => _base(24, FontWeight.w600);

  static TextStyle get s24Bold => _base(24, FontWeight.w700);
}
