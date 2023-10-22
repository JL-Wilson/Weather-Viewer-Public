import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp3/config/text_info.dart';
import 'package:weatherapp3/utils/settings.dart';

Map<int, List> colourMap = {
  0: [Colors.redAccent, Null],
  1: [Colors.orangeAccent, Null],
  2: [Colors.yellowAccent, Null],
  3: [Colors.greenAccent, Null],
  4: [Colors.blueAccent, Null],
  5: [Colors.indigoAccent, Null],
  6: [Colors.black, Colors.white],
  7: [const Color.fromRGBO(14, 134, 212, 1), Null]
};

class AppTheme {
  static ThemeData lightTheme(
      BuildContext context, ColorScheme? lightColorScheme) {
    Settings setting = Settings();

    late ColorScheme scheme;

    if (setting.getSetting("materialYou", bool)) {
      // IF material you selected
      scheme = lightColorScheme ??
          ColorScheme.fromSeed(seedColor: const Color(0x00004dbe));
    } else {
      scheme = ColorScheme.fromSeed(
        seedColor: colourMap[setting.getSetting("lightThemeColour", int)]![0],
      );
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: getTextTheme(context),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
    );
  }

  static ThemeData darkTheme(
      BuildContext context, ColorScheme? darkColorScheme) {
    Settings setting = Settings();
    late ColorScheme scheme;

    if (setting.getSetting("materialYou", bool)) {
      // If material you selected
      scheme = darkColorScheme ??
          ColorScheme.fromSeed(
              seedColor: const Color(0x00004dbe), brightness: Brightness.dark);
    } else {
      scheme = ColorScheme.fromSeed(
        seedColor: colourMap[setting.getSetting("darkThemeColour", int)]![0],
        primary: colourMap[setting.getSetting("darkThemeColour", int)]![0],
        brightness: Brightness.dark,
      );

      dynamic tempColour =
          colourMap[setting.getSetting("darkThemeColour", int)]![1];

      if (colourMap[setting.getSetting("darkThemeColour", int)]![1] == Null) {
        tempColour = scheme.onPrimary;
      }

      scheme = ColorScheme.fromSeed(
        seedColor: colourMap[setting.getSetting("darkThemeColour", int)]![0],
        primary: colourMap[setting.getSetting("darkThemeColour", int)]![0],
        onPrimary: tempColour,
        brightness: Brightness.dark,
      );
    }
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: getTextTheme(context),
      appBarTheme: const AppBarTheme(
        // backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
    );
  }
}
