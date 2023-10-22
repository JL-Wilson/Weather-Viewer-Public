import 'package:flutter/material.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';

import 'package:intl/intl.dart';

class ForecastDay {
  late String date;
  late List<Map> forecasts = [];

  Map<String, List<dynamic>> forecastWeatherTypes = {
    "NA": [
      "n/a",
      ForecastIcons.na,
      [Colors.white]
    ],
    "0": ["Clear Night", ForecastIcons.moon],
    "1": [
      "Sunny Day",
      ForecastIcons.sun,
      [Colors.red, Colors.blue]
    ],
    "2": ["Partly Cloudy", ForecastIcons.cloud_moon],
    "3": ["Partly Cloudy", ForecastIcons.cloud_sun],
    "4": ["n/a", ForecastIcons.na],
    "5": ["Mist", ForecastIcons.mist],
    "6": ["Fog", ForecastIcons.fog],
    "7": ["Cloudy", ForecastIcons.cloud],
    "8": ["Overcast", ForecastIcons.clouds],
    "9": ["Light Rain Shower", ForecastIcons.drizzle],
    "10": ["Light Rain Shower", ForecastIcons.drizzle],
    "11": ["Drizzle", ForecastIcons.drizzle],
    "12": ["Light Rain", ForecastIcons.drizzle],
    "13": ["Heavy Rain Shower", ForecastIcons.rain],
    "14": ["Heavy Rain Shower", ForecastIcons.rain],
    "15": ["Heavy Rain", ForecastIcons.rain],
    "16": ["Sleet Shower", ForecastIcons.hail],
    "17": ["Sleet Shower", ForecastIcons.hail],
    "18": ["Sleet", ForecastIcons.hail],
    "19": ["Hail Shower", ForecastIcons.hail],
    "20": ["Hail Shower", ForecastIcons.hail],
    "21": ["Hail", ForecastIcons.hail],
    "22": ["Light Snow Shower", ForecastIcons.snow_alt],
    "23": ["Light Snow Shower", ForecastIcons.snow_alt],
    "24": ["Light Snow", ForecastIcons.snow_alt],
    "25": ["Heavy Snow Shower", ForecastIcons.snow_heavy],
    "26": ["Heavy Snow Shower", ForecastIcons.snow_heavy],
    "27": ["Heavy Snow", ForecastIcons.snow_heavy],
    "28": ["Thunder Shower", ForecastIcons.cloud_flash_alt],
    "29": ["Thunder Shower", ForecastIcons.cloud_flash_alt],
    "30": ["Thunder", ForecastIcons.cloud_flash_alt],
  };

  ForecastDay(data) {
    date = data["value"].substring(0, data["value"].length - 1);

    for (var slice in data["Rep"]) {
      Map temp = slice;
      temp["time"] = (int.parse(temp[r"$"]) ~/ 60);
      temp["displayTime"] = "${int.parse(temp[r"$"]) ~/ 60}:00";
      temp.remove(r"$");
      temp["type"] = temp["W"];
      temp["W"] = forecastWeatherTypes[temp["W"]]![0];
      temp["I"] = forecastWeatherTypes[temp["type"]]![1];
      temp["DD"] = date;

      forecasts.add(temp);
    }
  }

  returnDay() {
    return date;
  }

  String shortDate() {
    DateFormat shortDate = DateFormat("EEEE");
    return shortDate.format(DateTime.parse(returnDay()));
  }
}
