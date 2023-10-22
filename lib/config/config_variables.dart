// jlwilson
// 26/02/22
// Contains several variables that are used throughout the program

// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dataPointAPIKey =
    "[DATAPOINT API KEY]"; // API key for MetOffice datapoint
String dataPasskey = "sMrGTBMtu24PCZjorWXt"; // API key for local weather data

Map<String, List<String>> measurementCategories = {
  // Sorts various measurement id's into categories
  "temperature": [
    "gTemp",
    "feelsLike",
    "srTemp",
    "atticTemp",
    "garageTemp",
    "driveTemp"
  ],
  "rain": ["rain", "rainChange"],
  "wind": ["gust", "wsp"],
  "humidity": ["oHumid"],
  "other": ["atpres", "rain", "wdir"]
};

const Color primaryColor =
    Color.fromRGBO(0, 119, 190, 1); // The primary color used

DateFormat standardDateFormat =
    DateFormat('yyy-MM-dd'); // Standard date display format
DateFormat standardTimeFormat =
    DateFormat("HH:mm"); // Standard Time display Format
DateFormat standardDateTimeFormat =
    DateFormat('yyy-MM-dd HH:mm'); // Standard DateTime display format

// Set by package info plus during startup
String appName = "n/a";
String packageName = "n/a";
String versionName = "n/a";
String versionCode = "n/a";
