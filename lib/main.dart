// jlwilson
// 11/02/22

// Imports of third party packages
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore: depend_on_referenced_packages
import "package:path_provider_linux/path_provider_linux.dart";

// App Imports
import 'package:weatherapp3/utils/app_info.dart';
import 'package:weatherapp3/theme_setup.dart';
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/screens/boot/boot_screen.dart';

AppInformation platformInfo = AppInformation();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  if (Platform.isLinux) {
    PathProviderLinux.registerWith();
    PackageInfoPlusLinuxPlugin.registerWith();
  }

  await Hive.initFlutter();
  await Hive.openBox("settings");
  await platformInfo.setupPlatform();
  await platformInfo.toggleFullscreen();
  await packageInfo();

  runApp(Phoenix(child: const App()));
}

packageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  versionName = packageInfo.version;
  versionCode = packageInfo.buildNumber;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: MaterialApp(
            scrollBehavior:
                const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.invertedStylus
            }),
            // Allows dragging to scroll on desktop
            title: kDebugMode ? "WeatherDev" : "Weather App",
            theme: AppTheme.lightTheme(context, lightColorScheme),
            darkTheme: AppTheme.darkTheme(context, darkColorScheme),
            themeMode: platformInfo.getTheme(),
            home: const BootPage(),
          ),
        );
      },
    );
  }
}
