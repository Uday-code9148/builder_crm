import 'package:flutter/material.dart';

class ColorPalette {
  // ═══════════════════════════════════════════════════════════════════════════
  // DEEP EMERALD DESIGN TOKENS — "Architectural Curator" Design System
  // ═══════════════════════════════════════════════════════════════════════════

  // ─── Surface Hierarchy (tonal layering, dark-first) ───────────────────────
  static const Color surface = Color(0xFF101413);               // Base layer
  static const Color surfaceContainerLowest = Color(0xFF0D1210); // Recessed
  static const Color surfaceContainerLow = Color(0xFF181D1B);    // Sectioning
  static const Color surfaceContainer = Color(0xFF1C211F);       // Cards
  static const Color surfaceContainerHigh = Color(0xFF262B29);   // Card content
  static const Color surfaceContainerHighest = Color(0xFF313634); // Separators
  static const Color surfaceBright = Color(0xFF353A38);           // Pop elements

  // ─── Primary Teal ─────────────────────────────────────────────────────────
  static const Color primaryTeal = Color(0xFF79D7C0);             // On-dark primary
  static const Color primaryTealFixed = Color(0xFF399B86);        // Core brand teal
  static const Color primaryTealContainer = Color(0xFF3FA08B);    // Gradient end / container
  static const Color primaryTealFixedDim = Color(0xFF5BBFAB);     // Icon teal
  static const Color onPrimaryTeal = Color(0xFF00382E);           // Dark teal (tinted shadows)
  static const Color onPrimaryTealContainer = Color(0xFFB2DFDB);  // Text on primary container

  // ─── Secondary Purple (urgency — "New Launch", "Exclusive") ──────────────
  static const Color secondaryPurple = Color(0xFFC7BFFF);
  static const Color secondaryPurpleContainer = Color(0xFF4534A9);
  static const Color onSecondaryPurple = Color(0xFFE8D5FF);

  // ─── Semantic / Status ────────────────────────────────────────────────────
  static const Color successEmerald = Color(0xFF2E7D66);
  static const Color successContainer = Color(0xFF1A3D30);
  static const Color onSuccessContainer = Color(0xFFB2DFDB);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFF3D2A00);
  static const Color onWarningContainer = Color(0xFFFFE0A3);
  static const Color errorDeep = Color(0xFFCF6679);
  static const Color errorContainer = Color(0xFF3D1515);
  static const Color onErrorContainer = Color(0xFFFFB3B3);
  static const Color paidGreen = Color(0xFF4CAF50);
  static const Color overdueRed = Color(0xFFE53935);
  static const Color pendingTeal = Color(0xFF26A69A);
  static const Color upcomingGrey = Color(0xFF78909C);

  // ─── Tertiary (aqua accent) ───────────────────────────────────────────────
  static const Color tertiaryTeal = Color(0xFF6DD9C1);            // Paid/success teal
  static const Color tertiaryTealContainer = Color(0xFF2DA28C);   // Container

  // ─── Text on Surface ──────────────────────────────────────────────────────
  static const Color onSurface = Color(0xFFDFE3E0);              // Primary text
  static const Color onSurfaceVariant = Color(0xFFBDC9C4);       // Secondary text
  static const Color onSurfaceDim = Color(0xFF6B8C85);           // Tertiary / hint text

  // ─── Borders ──────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF87938F);
  static const Color outlineVariant = Color(0xFF3E4945);          // Ghost border base

  // ═══════════════════════════════════════════════════════════════════════════
  // LEGACY TOKENS (kept for backward compatibility)
  // ═══════════════════════════════════════════════════════════════════════════

  // ─── Primary ──────────────────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF292A2B);
  static const Color primaryDarkColor = Color(0xFF0D0D0D);
  static const Color primaryLightColor = Color(0xFF343739);
  static const Color lightBackground = Color(0xFF494F56);
  static const Color lightDarkBackground = Color(0xFF2A2D2F);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color cylinderBackGroundColor = Color(0xFF2D3235);

  // ─── Brand green ──────────────────────────────────────────────────────────
  static const Color primaryGreen = Color(0xFF50BEA7);
  static const Color leadratGreen = Color(0xFF3C8979);
  static const Color leadratDarkGreen = Color(0xFF2E6559);
  static const Color leadratBgGreen = Color(0xFF49AC97);
  static const Color lightGreen = Color(0xFFA8DFD3);
  static const Color syncPageLightGreen = Color(0xFF69C8B3);
  static const Color illuminatingEmerald = Color(0xFF348D7A);
  static const Color mountainLakeAzure = Color(0xFF50BFA8);
  static const Color txtGreenColor = Color(0xFF50BDA6);
  static const Color mediumSeaGreen = Color(0xFF6DBA82);
  static const Color candiedSnow = Color(0xFFD6FBF3);
  static const Color fadedGreen = Color(0xFFD1F0C9);

  // ─── Accent ───────────────────────────────────────────────────────────────
  static const Color accentColor = Color(0xFF24B780);
  static const Color accentDarkColor = Color(0xFF008653);
  static const Color accentLightColor = Color(0xFF64EAB0);

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color primaryTextColor = Color(0xFFF5F5F5);
  static const Color secondaryTextColor = Color(0xFFC1C1C6);
  static const Color tertiaryTextColor = Color(0xFF97959E);
  static const Color primaryWhiteTextColor = Color(0xFF4B4E4F);
  static const Color primaryWhite300TextColor = Color(0xFF8C8E8F);
  static const Color placeHolderTextColor = Color(0xFFBFBFBF);
  static const Color txtPinkColor = Color(0xFFE99797);
  static const Color txtGreyColor = Color(0xFFD4D7D6);
  static const Color textDarkDull = Color(0xFF595667);

  // ─── Neutral / grey ───────────────────────────────────────────────────────
  static const Color primary = Color(0xFFCFD0D0);
  static const Color secondary = Color(0xFFC2C4C6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteSolid = Color(0xFFF5F6FB);
  static const Color black = Colors.black;
  static const Color darkBlack = Color(0xFF171717);
  static const Color darkToneInk = Color(0xFF121212);
  static const Color eerieBlack = Color(0xFF1F1F1F);
  static const Color superDarkBlack800 = Color(0xFF1B1B1B);
  static const Color darkCharcoal = Color(0xFF2F2F2F);
  static const Color ravenBlack = Color(0xFF3D3D3D);
  static const Color skyCaptain = Color(0xFF252B32);
  static const Color corbeau = Color(0xFF130F26);
  static const Color leadInfoCardBg = Color(0xFF212121);

  static const Color gray100 = Color(0xFFE1E1E1);
  static const Color gray200 = Color(0xFFC8C8C8);
  static const Color gray300 = Color(0xFFACACAC);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
  static const Color gray950 = Color(0xFF141414);
  static const Color astroscopusGrey = Color(0xFFB1B2B8);
  static const Color wildDove = Color(0xFF8A8A8A);
  static const Color lightGray = Color(0xFF999999);
  static const Color darkGray = Color(0xFF777777);
  static const Color veryLightGray = Color(0xFFDDDDDD);
  static const Color superSilver = Color(0xFFEEEEEE);
  static const Color steam = Color(0xFFDDDDDD);
  static const Color gravelFint = Color(0xFFBBBBBB);
  static const Color silverChalice = Color(0xFFAFAFAF);

  // ─── Red / error ──────────────────────────────────────────────────────────
  static const Color red = Color(0xFFFF4729);
  static const Color red600 = Color(0xFFE53935);
  static const Color mediumRed = Color(0xFFFF5252);
  static const Color lightRed = Color(0xFFFF686B);
  static const Color thickRed = Color(0xFFD7282F);
  static const Color fadedRed = Color(0xFFD7494C);
  static const Color fededRed = Color(0xFFFAD7D7);
  static const Color deepCrimsonRed = Color(0xFFBC0F00);
  static const Color khmerCurry = Color(0xFFED5454);
  static const Color cinnabar = Color(0xFFEA4335);
  static const Color gallant = Color(0xFFFECCCC);
  static const Color hardCandy = Color(0xFFFFBABA);
  static const Color mutedRose = Color(0xFF917676);

  // ─── Orange / yellow ──────────────────────────────────────────────────────
  static const Color orange = Color(0xFFFF9A8A);
  static const Color lightOrange = Color(0xFFF2AC42);
  static const Color fadedOrange = Color(0xFFFEECBA);
  static const Color peanutButter = Color(0xFFF7B267);
  static const Color fadedYellow = Color(0xFFFAC107);
  static const Color yellow100Accent = Color(0xFFFCA400);
  static const Color yellow200Accent = Color(0xFFFFD590);
  static const Color yellow300Accent = Color(0xFFFFE5B9);

  // ─── Blue ─────────────────────────────────────────────────────────────────
  static const Color skyBlue = Color(0xFF7DC8E7);
  static const Color blue100Accent = Color(0xFF3E8EED);
  static const Color blue200Accent = Color(0xFF72ACF1);
  static const Color blue300Accent = Color(0xFFA7CBF6);
  static const Color darkBlue = Color(0xFF10275A);
  static const Color lightBlueAccent = Color(0xFF4E9BF4);
  static const Color azureBlue = Color(0xFF1075db);
  static const Color azureRadiance = Color(0xFF0E83FE);
  static const Color vividSkyBlue = Color(0xFF00A1FC);
  static const Color nocturneShade = Color(0xFF3A6DAF);
  static const Color furnace = Color(0xFF6C90C8);
  static const Color weatheredBlue = Color(0xFFD2E2F7);
  static const Color cyan100Accent = Color(0xFF28C2D1);
  static const Color cyan200Accent = Color(0xFF7BDDEF);
  static const Color cyan300Accent = Color(0xFFC3F2F4);
  static const Color fadedPurple = Color(0xFF7D88E7);

  // ─── Purple ───────────────────────────────────────────────────────────────
  static const Color purple = Color(0xFF4E3EB2);
  static const Color lightPurple = Color(0xFFF1F0F5);
  static const Color tertiary = Color(0xFF2B0B98);
  static const Color circumorbitalRing = Color(0xFF6850BF);
  static const Color melrose = Color(0xFFC3B9E5);

  // ─── Misc ─────────────────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;
}
