import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:weatherapp3/firebase_options.dart';
import 'package:weatherapp3/utils/settings.dart';

// ignore: depend_on_referenced_packages
import "package:path_provider_linux/path_provider_linux.dart";

class AppInformation {
  Settings settings = Settings();

  late String serverToUse;

  void setServer(String server) {
    serverToUse = server;
  }

  setupPlatform() async {
    if (Platform.isLinux) {
      PathProviderLinux.registerWith();
      PackageInfoPlusLinuxPlugin.registerWith();

      settings.setSetting("serverOne", "192.168.1.219:5000", String);
      settings.setSetting("serverTwo", "192.168.0.200:5000", String);
    } else if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (kReleaseMode) {
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        // ignore: unused_local_variable
        FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      }

      const AndroidNotificationChannel dailyChannel =
          AndroidNotificationChannel(
        'daily_notification_channel', // id
        'Daily Notifications', // title
        description: 'This channel is used for daily notifications.',
        importance: Importance.low,
      );

      const AndroidNotificationChannel alertChannel =
          AndroidNotificationChannel(
        'alert_notification_channel', // id
        'Alert Notifications', // title
        description: 'This channel is used for alert notifications.',
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(dailyChannel);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(alertChannel);
    } else if (Platform.isWindows) {
    } else if (Platform.isFuchsia ||
        Platform.isIOS ||
        Platform.isIOS ||
        Platform.isMacOS) {
    } else {
      PathProviderLinux.registerWith();
      PackageInfoPlusLinuxPlugin.registerWith();
    }
  }

  toggleFullscreen() {
    if (settings.getSetting("fullscreenMode", int) == 1) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  ThemeMode getTheme() {
    if (settings.getSetting("themeMode", int) == 0) {
      return ThemeMode.system;
    } else if (settings.getSetting("themeMode", int) == 1) {
      return ThemeMode.light;
    } else if (settings.getSetting("themeMode", int) == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
