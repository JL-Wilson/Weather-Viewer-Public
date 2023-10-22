// jlwilson
// 27/02/22
// Used within the application to fetch user settings

// Imports of third party packages
import "package:hive_flutter/hive_flutter.dart";

class Settings {
  // Instance of storage

  Box settingsBox = Hive.box("settings");

  // Default settings to use if they are not already set
  Map<String, dynamic> defaultSettings = {
    "temperatureUnits": 0,
    "windUnits": 0,
    "rainUnits": 0,
    "fullscreenMode": 0,
    "homepageMeasurement": 0,
    "homepageChartPeriod": 6,
    "forecastLocation": 0,
    "dailyNotification": 0,
    "rainNotification": 0,
    "rainComparisonPeriod": 0,
    "rainComparisonTimePeriod": 6,
    "homepageChartSelection": "gTemp:1",
    "themeMode": 1,
    "experimentalFeatures": 0,
    "windDisplayType": 0,
    "lightThemeColour": 4,
    "darkThemeColour": 4,
    "materialYou": 0,
    "serverOne": "192.168.1.219:5000",
    "serverTwo": "192.168.1.215:5000",
    "highTempNotification": 0,
    "indoorOutdoorTemperatureNotification": 0,
    "homepageMapSetting": 0,
  };

  getSetting(settingName, type) {
    // If it is a valid setting
    if (defaultSettings.containsKey(settingName)) {
      // If the setting is null return a default value

      if (settingsBox.get(settingName) == null) {
        settingsBox.put(settingName, defaultSettings[settingName]);
      }

      dynamic setting = settingsBox.get(settingName);

      if (type == int) {
        setting = int.parse(setting.toString());
      } else if (type == bool) {
        setting = (int.parse(setting.toString()) == 0 ? false : true);
      } else if (type == List) {
        setting = setting.toString().split("/");
      }

      return setting;
    }
  }

  // Set a setting
  setSetting(settingName, value, type) {
    if (type == int) {
    } else if (type == bool) {
      value = value ? 1 : 0;
    } else if (type == String) {
      value = value.toString();
    } else if (type == List) {
      String string = "";

      for (var item in value) {
        string = "${string + item}/";
      }

      value = string;
    }
    settingsBox.put(settingName, value);
  }

  // Invert a setting if it a boolean or int (0 or 1)
  toggleSetting(settingName) {
    dynamic settingValue = getSetting(settingName, "int");
    if (settingValue == false || settingValue == true) {
      setSetting(settingName, !settingValue, bool);
      return;
    } else if (settingValue == 0) {
      setSetting(settingName, 1, int);
      return;
    } else if (settingValue == 1) {
      setSetting(settingName, 0, int);
      return;
    }
  }

  // Reset all settings to default values
  resetSettings() {
    for (var key in defaultSettings.keys) {
      setSetting(key, defaultSettings[key], int);
    }
  }
}
