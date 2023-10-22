// jlwilson
// 11/02/22
// This file contains the data objects used throughout the app

// Imports of third party packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/map_utils.dart';
import 'package:weatherapp3/utils/url_request.dart';
import 'package:intl/intl.dart';

// Imports of other code written for this app
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/settings.dart';
import 'converter.dart';
import 'forecast_data.dart';

// This class is a collection of data slices, it is used in the chart system
class DataCollection {
  // The URL to fetch data from
  final String _fetchURL;

  // The collection of data slices
  final List<DataSlice> _collectionContainer = [];

  // Min, max, and avg data for the collection
  final Map<String, dynamic> _minMaxAvg = {};

  Color chartLabelColor = Colors.black;

  DataCollection(this._fetchURL);

  // Fetch the data and put in the collection container as DataSlices
  // Does not calculate the min, max, and avg automatically so save time
  createCollection() async {
    dynamic response = await apiRequest(_fetchURL, 60);

    if (response != false) {
      response = jsonDecode(response);

      for (var data in response) {
        DataSlice temp = DataSlice();
        temp.setAllData(data);
        _collectionContainer.add(temp);
      }

      return true;
    } else {
      return false;
    }
  }

  DataSlice getOldestSlice() {
    return _collectionContainer.first;
  }

  DataSlice getLatestSlice() {
    return _collectionContainer[_collectionContainer.length - 2];
  }

  // Returns the data slice at the given index
  DataSlice getValueAtIndex(index) {
    return _collectionContainer[index];
  }

  // Returns the number of data slices
  int getCollectionLength() {
    return _collectionContainer.length;
  }

  // Returns the list of data slices
  List<DataSlice> getCollection() {
    return _collectionContainer;
  }

  // Return the min, max, or avg of the dataSlice at the given index
  getMinMaxAvg(index, type) {
    return _minMaxAvg[index][type];
  }

  // Calculate the minimum, maximum, and averge for the collection
  void calculateMinMaxAvg() {
    // List of numerical values to work out the min max and avg for
    dynamic dataKeys = _collectionContainer[0].validDataKeys;

    // Fill out the blank map
    for (var key in dataKeys) {
      _minMaxAvg[key] = {
        "min": Null,
        "max": Null,
        "avg": 0,
      };
    }

    for (var slice in _collectionContainer) {
      for (var key in dataKeys) {
        // This checks if it is a double or an int
        if ((slice.returnValue(key).getType() == 1) ||
            (slice.returnValue(key).getType() == 3)) {
          if (_minMaxAvg[key]["min"] == Null) {
            _minMaxAvg[key]["min"] = slice.returnValue(key).getValue();
          } else if (_minMaxAvg[key]["min"] >
              slice.returnValue(key).getValue()) {
            _minMaxAvg[key]["min"] = slice.returnValue(key).getValue();
          }

          if (_minMaxAvg[key]["max"] == Null) {
            _minMaxAvg[key]["max"] = slice.returnValue(key).getValue();
          } else if (_minMaxAvg[key]["max"] <
              slice.returnValue(key).getValue()) {
            _minMaxAvg[key]["max"] = slice.returnValue(key).getValue();
          }

          _minMaxAvg[key]["avg"] =
              _minMaxAvg[key]["avg"] + slice.returnValue(key).getValue();
        }
      }
    }

    for (var key in dataKeys) {
      _minMaxAvg[key]["avg"] = roundDouble(
          (_minMaxAvg[key]["avg"] / _collectionContainer.length), 1);
    }

    // Set the value inside each data slice
    for (var slice in _collectionContainer) {
      for (var key in dataKeys) {
        slice.returnValue(key).setMin(_minMaxAvg[key]["min"]);
        slice.returnValue(key).setMax(_minMaxAvg[key]["max"]);
        slice.returnValue(key).setAvg(_minMaxAvg[key]["avg"]);
      }
    }
  }
}

// Contains the set of values for an instance of time
class DataSlice {
  final Settings _storage = Settings();

  // List Format = [CurrentValue, ChangeIcon, Min, Max, Avg, Units, dataType, DisplayName, roundingDegree, measurementType, settings, shortUnits, shortDisplay]
  // DataType: 0 = String, 1 = double, 2 = DateTime, 3 = int

  // Create the blank value objects
  late final Value _tstamp = Value("n/a", Icons.remove, Null, Null, Null, "", 2,
      "Timestamp", 2, "datetime", _storage, "", "Date");
  late final Value _dlta = Value("n/a", Icons.remove, Null, Null, Null, "", 3,
      "Wind Direction", 0, "direction", _storage, "°", "Direction");
  late final Value _atpres = Value("n/a", Icons.remove, Null, Null, Null, "hpa",
      1, "Pressure", 1, "pressure", _storage, "hpa", "Pressure");
  late final Value _gTemp = Value("n/a", Icons.remove, Null, Null, Null, "", 1,
      "Garden", 1, "temperature", _storage, "°", "Garden");
  late final Value _oHumid = Value("n/a", Icons.remove, Null, Null, Null, "%RH",
      3, "Outdoor Humidity", 0, "humidity", _storage, "%", "Outdoors");
  late final Value _wsp = Value("n/a", Icons.remove, Null, Null, Null, "", 1,
      "Wind Speed", 1, "wind", _storage, "", "Average");
  late final Value _gust = Value("n/a", Icons.remove, Null, Null, Null, "", 1,
      "Wind Gust", 1, "wind", _storage, "", "Gust");
  late final Value _rain = Value("n/a", Icons.remove, Null, Null, Null, "", 1,
      "Rainfall", 1, "rain", _storage, '', "Rain");
  late final Value _feelsLike = Value("n/a", Icons.remove, Null, Null, Null, "",
      1, "Feels Like", 1, "temperature", _storage, "°", "Feels Like");
  late final Value _forecast = Value("n/a", Icons.remove, Null, Null, Null, "",
      1, "Forecast", 1, "temperature", _storage, "°", "Forecast");
  late final Value _forecastTime = Value("n/a", Icons.remove, Null, Null, Null,
      "", 2, "Forecast Timestamp", 2, "datetime", _storage, "", "Date");
  late final Value _rainChange = Value("n/a", Icons.remove, Null, Null, Null,
      "", 1, "Rainfall", 1, "rain", _storage, "", "Rain");
  late final Value _wdir = Value("n/a", Icons.remove, Null, Null, Null, "", 0,
      "Direction", 0, "string", _storage, "", "Direction");

  late final Value _srTemp = Value("n/a", Icons.remove, Null, Null, Null, "", 1,
      "Indoors", 1, "temperature", _storage, "°", "Indoors");
  late final Value _atticTemp = Value("n/a", Icons.remove, Null, Null, Null, "",
      1, "Attic", 1, "temperature", _storage, "°", "Attic");
  late final Value _garageTemp = Value("n/a", Icons.remove, Null, Null, Null,
      "", 1, "Garage", 1, "temperature", _storage, "°", "Garage");
  late final Value _driveTemp = Value("n/a", Icons.remove, Null, Null, Null, "",
      1, "Drive", 1, "temperature", _storage, "°", "Drive");

  // This allows access to the objects via a string
  late final Map<String, Value> _valueMap = {
    "tstamp": _tstamp,
    "dlta": _dlta,
    "atpres": _atpres,
    "gTemp": _gTemp,
    "oHumid": _oHumid,
    "wsp": _wsp,
    "gust": _gust,
    "rain": _rain,
    "feelsLike": _feelsLike,
    "forecast": _forecast,
    "forecastTime": _forecastTime,
    "rainChange": _rainChange,
    "srTemp": _srTemp,
    "atticTemp": _atticTemp,
    "garageTemp": _garageTemp,
    "driveTemp": _driveTemp,
    "wdir": _wdir,
  };

  // Excludes forecast
  // List of valid values for which to calculate min, max, and avg
  List<String> validDataKeys = [
    "tstamp",
    "dlta",
    "atpres",
    "gTemp",
    "oHumid",
    "wsp",
    "gust",
    "rain",
    "feelsLike",
    "srTemp",
    "atticTemp",
    "garageTemp",
    "driveTemp"
  ];

  // Convert a string of values into a data slice
  void setAllData(valueList) {
    for (var key in valueList.keys) {
      _valueMap[key]?.setValue(valueList[key]);
    }
  }

  // Return the Value object of the given name
  dynamic returnValue(valueName) {
    Value value = _valueMap[valueName]!;

    return value;
  }
}

// This is used in latest data, the only difference from the normal data slice is the inclusion of the forecast.
class CurrentDataSlice extends DataSlice {
  // The message and icon to display on the homepage
  late String homepageMessage = "Fetching Data...";
  late String homepageMessageType = "normal";
  late IconData forecastIcon = ForecastIcons.na;

  Widget homeChart = const CircularProgressIndicator();

  late List<List> locationList = [];
  String currentLocation = "n/a";

  String lastRefresh = "n/a";

  List<ForecastDay> _forecastDataCollection = [];
  Map<String, ForecastDay> dateMap = {};
  Map<String, Map<String, String>> measurements = {};

  bool forecastDataFetched = false;

  bool forecastAvailable = false;

  bool loaded = false;

  MapInfo mapInfo = MapInfo();

  reload() async {
    _forecastDataCollection = [];
    dateMap = {};
    measurements = {};

    // Set values back to default
    homepageMessage = "Fetching Data...";
    homepageMessageType = "normal";
    forecastIcon = Icons.remove;
    forecastDataFetched = false;

    await mapInfo.refresh();

    dynamic response = await apiRequest(
        "/api/v2/request/recent.php?dataType=display&passkey=$dataPasskey", 5);

    if (response != false) {
      response = jsonDecode(response)[0];

      // Set the data
      setAllData(response);

      int location = _storage.getSetting("forecastLocation", int);

      DateTime currentTime = DateTime.now();
      DateTime? dataTime = DateTime.tryParse(returnValue("tstamp").getValue());

      if (dataTime != null) {
        Duration timeDifference = currentTime.difference(dataTime);
        if (timeDifference.inMinutes > 15) {
          homepageMessageType = "error";
          homepageMessage =
              "Data is ${timeDifference.inMinutes} minutes out of date";
        }
      }

      if (forecastAvailable) {
        response = await urlRequest(
            "http://datapoint.metoffice.gov.uk/public/data/val/wxfcs/all/json/$location?res=3hourly&key=$dataPointAPIKey",
            5);

        if (response != false) {
          response = jsonDecode(response);

          var responseData = response["SiteRep"]["DV"]["Location"]["Period"];

          for (var unitInfo in response["SiteRep"]["Wx"]["Param"]) {
            measurements[unitInfo["name"]] = {
              "units": unitInfo["units"],
              "DisplayName": unitInfo[r"$"],
            };
          }

          for (var data in responseData) {
            ForecastDay currentDay = ForecastDay(data);
            _forecastDataCollection.add(currentDay);
            dateMap[currentDay.date] = currentDay;
          }

          forecastIcon = nextForecast()["I"];

          forecastDataFetched = true;

          if (homepageMessageType != "error") {
            homepageMessage = nextForecast()["W"];
          }

          var temp = await fetchLocationData();

          if (temp != false) {
            locationList = temp;
            currentLocation = currentSetLocation(type: "short");
          }
        } else {
          debugPrint(response.statusCode);
          return false;
        }
      } else {
        homepageMessage = "Forecast Unavailable";
      }

      double? gardenTemp =
          double.tryParse(returnValue("gTemp").getValue().toString());
      double? indoorTemp =
          double.tryParse(returnValue("srTemp").getValue().toString());

      if (gardenTemp != null && indoorTemp != null) {
        if ((gardenTemp > 27 || indoorTemp > 27) &&
            homepageMessageType != "error") {
          if (gardenTemp > indoorTemp) {
            sethomepageMessage("It is warmer outside");
          } else if (indoorTemp > gardenTemp) {
            sethomepageMessage("It is warmer inside");
          }
        }
      }

      lastRefresh = DateFormat("dd/MM/yyyy h:mm a").format(DateTime.now());
    } else {
      return false;
    }
  }

  sethomepageMessage(message) {
    homepageMessage = message;
  }

  fetchLocationData() async {
    List<List> tempLocationList = [];

    dynamic response = await urlRequest(
        "http://datapoint.metoffice.gov.uk/public/data/val/wxfcs/all/json/sitelist?key=$dataPointAPIKey",
        5);

    if (response != false) {
      response = jsonDecode(response);

      var responseData = response["Locations"]["Location"];

      for (var i in responseData) {
        dynamic temp = "";

        if (i["unitaryAuthArea"] != null) {
          temp = i["name"] + ", " + i["unitaryAuthArea"];
        } else {
          temp = i["name"];
        }

        temp = [temp, i["id"], (temp + " " + i["id"].toString()), i["name"]];
        tempLocationList.add(temp);
      }
      return tempLocationList;
    } else {
      return false;
    }
  }

  currentSetLocation({String type = "long"}) {
    int currentLocation = _storage.getSetting("forecastLocation", int);
    for (var location in locationList) {
      if (location[1].toString() == currentLocation.toString()) {
        if (type == "short") {
          return location[3];
        } else {
          return location[0];
        }
      }
    }
    return "n/a";
  }

  currentSetLocationID() {
    int currentLocation = _storage.getSetting("forecastLocation", int);
    for (var location in locationList) {
      if (location[1].toString() == currentLocation.toString()) {
        return location[1];
      }
    }
    return "n/a";
  }

  findForecastAfter(List<ForecastDay> forecasts, currentTime) {
    if (forecasts.isEmpty) {
    } else {
      for (var data in forecasts[0].forecasts) {
        if ((data["time"] > currentTime) &&
            (forecasts[0].date ==
                DateFormat("yyyy-MM-dd").format(DateTime.now()))) {
          return data;
        }
      }
      return forecasts[1].forecasts[0];
    }
  }

  nextForecast() {
    DateTime now = DateTime.now();

    DateFormat customTimeFormat = DateFormat("HH");

    int currentTime = int.parse(customTimeFormat.format(now));

    var nextForecast = findForecastAfter(_forecastDataCollection, currentTime);
    return nextForecast;
  }

  List<ForecastDay> returnForecasts() {
    return _forecastDataCollection;
  }

  // Set the forecast data
  void setForecastData(data) {
    _forecast.setValue(data["gTemp"]);
    _forecastTime.setValue(data["tstamp"]);
  }

  // This is not fully implemented and used
  void setMinMax() {
    DataCollection historicalData = DataCollection(
        "/api/v2/request/within.php?&passkey=$dataPasskey&units=hours&number=");
    historicalData.createCollection();
    historicalData.calculateMinMaxAvg();
  }

  @override
  dynamic returnValue(valueName) {
    Map<String, String> dataToForecast = {
      "forecastFeelsLike": "F",
      "forecastGust": "G",
      "forecastHumidity": "H",
      "forecastTemp": "T",
      "forecastVisibility": "V",
      "forecastWindDirection": "D",
      "forecastWindSpeed": "S",
      "forecastUV": "U",
      "forecastWeatherType": "W",
      "forecastPrecipitationProbability": "Pp",
    };

    if (dataToForecast[valueName] != null) {
      dynamic temp;
      if (forecastDataFetched) {
        temp = nextForecast()[dataToForecast[valueName]];
      } else {
        return "n/a";
      }

      return temp;
    } else {
      return _valueMap[valueName];
    }
  }

  void setValue(valueName, value) {
    _valueMap[valueName]?.setValue(value);
  }
}

// The most basic type of data
class Value {
  dynamic _currentValue;
  final IconData _changeIcon;
  dynamic _min;
  dynamic _max;
  dynamic _avg;
  String _unit;
  final String _shortUnits;
  final int _dataType;
  final String _displayName;
  final int _roundingDegree;
  final String _measurementType;
  final Settings _settings;
  final String _shortName;

  Value(
      this._currentValue,
      this._changeIcon,
      this._min,
      this._max,
      this._avg,
      this._unit,
      this._dataType,
      this._displayName,
      this._roundingDegree,
      this._measurementType,
      this._settings,
      this._shortUnits,
      this._shortName) {
    _unit = getUnits();
  }

  // Return the display name of the value
  String getDisplayName() {
    return _displayName;
  }

  // Set the converted value, and update the units
  void setValue(value) {
    value = convertValue(
        value, _measurementType, _roundingDegree, _settings, _dataType);
    _currentValue = value;
    _unit = getUnits();
  }

  // Get the current value
  dynamic getValue() {
    return _currentValue;
  }

  String getShortUnits() {
    return _shortUnits;
  }

  String getShortName() {
    return _shortName;
  }

  // Get the data type
  int getType() {
    return _dataType;
  }

  // Set the minimum value
  void setMin(value) {
    _min = value;
  }

  // Set the maximum value
  void setMax(value) {
    _max = value;
  }

  // Set the average value
  void setAvg(value) {
    _avg = value;
  }

  // Return the correct units based on user setting
  String getUnits() {
    String tempUnit = "";
    if (_measurementType == "temperature") {
      var temp = _settings.getSetting("temperatureUnits", int);

      if (temp == 0) {
        tempUnit = "°C";
      } else if (temp == 1) {
        tempUnit = "°F";
      } else if (temp == 2) {
        tempUnit = "K";
      }
    } else if (_measurementType == "wind") {
      var temp = _settings.getSetting("windUnits", int);

      if (temp == 0) {
        tempUnit = "km/h";
      } else if (temp == 1) {
        tempUnit = "mph";
      }
    } else if (_measurementType == "rain") {
      var temp = _settings.getSetting("rainUnits", int);

      if (temp == 0) {
        tempUnit = "mm";
      } else if (temp == 1) {
        tempUnit = "inches";
      }
    } else if (_measurementType == "direction") {
      tempUnit = "°";
    } else {
      tempUnit = _unit;
    }

    return tempUnit;
  }
}
