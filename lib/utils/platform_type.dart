import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:weatherapp3/config/config_variables.dart';

enum DisplaySize { portrait, landscape }

enum SystemOS { android, windows, linux, macos, web, ios, fuchsia }

enum AppType { desktop, mobile, display }

class SystemInformation {
  AppType getAppType(BuildContext context) {
    if ((getSystemOS() == SystemOS.linux) &&
        (MediaQuery.of(context).size.width.floor() == 585) &&
        (MediaQuery.of(context).size.height.floor() == 351)) {
      return AppType.display;
    } else if ((getSystemOS() == SystemOS.windows) ||
        (getSystemOS() == SystemOS.linux) ||
        (getSystemOS() == SystemOS.macos)) {
      return AppType.desktop;
    } else if ((getSystemOS() == SystemOS.android) ||
        (getSystemOS() == SystemOS.ios)) {
      return AppType.mobile;
    } else {
      return AppType.mobile;
    }
  }

  DisplaySize getDisplaySize(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1000 &&
        ((MediaQuery.of(context).orientation == Orientation.landscape) ||
            (getAppType(context) == AppType.desktop))) {
      return DisplaySize.landscape;
    } else if (getAppType(context) == AppType.display) {
      return DisplaySize.landscape;
    } else if (getAppType(context) == AppType.mobile) {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        return DisplaySize.landscape;
      } else {
        return DisplaySize.portrait;
      }
    } else {
      return DisplaySize.portrait;
    }
  }

  SystemOS getSystemOS() {
    if (kIsWeb) {
      return SystemOS.web;
    } else if (Platform.isAndroid) {
      return SystemOS.android;
    } else if (Platform.isIOS) {
      return SystemOS.ios;
    } else if (Platform.isWindows) {
      return SystemOS.windows;
    } else if (Platform.isMacOS) {
      return SystemOS.macos;
    } else if (Platform.isFuchsia) {
      return SystemOS.fuchsia;
    } else {
      return SystemOS.linux;
    }
  }

  String getAppName() {
    String returnAppName = appName;
    if (returnAppName.isEmpty) {
      returnAppName = "Weather App";
    }

    return returnAppName;
  }

  String getOSString() {
    return getSystemOS().name.toString();
  }
}
