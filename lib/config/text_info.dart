// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp3/utils/platform_type.dart';

// Default font weights
FontWeight regular = FontWeight.w400;
FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight bold = FontWeight.bold;

getTextTheme(context) {
  const double displayScale =
      0.75; // Due to some issues with the display used the font-size is manually adjusted.
  bool isDisplay = SystemInformation().getAppType(context) ==
      AppType.display; // Is the device running on a raspberry pi with display

  return GoogleFonts.nunitoTextTheme(TextTheme(
    displayLarge: TextStyle(
        fontWeight: bold, fontSize: isDisplay ? 57 * displayScale : 57),
    displayMedium: TextStyle(
      fontSize: isDisplay ? 45 * displayScale : 45,
    ),
    displaySmall: TextStyle(fontSize: isDisplay ? 36 * displayScale : 36),
    headlineLarge: TextStyle(fontSize: isDisplay ? 32 * displayScale : 32),
    headlineMedium: TextStyle(fontSize: isDisplay ? 28 * displayScale : 28),
    headlineSmall: TextStyle(fontSize: isDisplay ? 24 * displayScale : 24),
    titleLarge: TextStyle(fontSize: isDisplay ? 22 * displayScale : 22),
    titleMedium: TextStyle(fontSize: isDisplay ? 16 * displayScale : 16),
    titleSmall: TextStyle(fontSize: isDisplay ? 14 * displayScale : 14),
    labelLarge: TextStyle(fontSize: isDisplay ? 14 * displayScale : 14),
    labelMedium: TextStyle(fontSize: isDisplay ? 12 * displayScale : 12),
    labelSmall: TextStyle(fontSize: isDisplay ? 11 * displayScale : 11),
    bodyLarge: TextStyle(fontSize: isDisplay ? 16 * displayScale : 16),
    bodyMedium: TextStyle(fontSize: isDisplay ? 14 * displayScale : 14),
    bodySmall: TextStyle(fontSize: isDisplay ? 12 * displayScale : 12),
  ));
}
