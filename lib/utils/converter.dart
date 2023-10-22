// jlwilson
// 27/02/22
// Converts data based on user settings as well as rounding

// Imports of other code written for this app
import '../config/config_variables.dart';

// This function converts the value to the correct units and then has it converted to the correct data type
dynamic convertValue(value, type, roundingDegree, settings, dataType) {
  // If the value is an int or float convert to double
  if (dataType == 3 || dataType == 1) {
    value = double.parse(value.toString());
  }

  if (type == "temperature" ||
      measurementCategories["temperature"]!.contains(type)) {
    if (settings.getSetting("temperatureUnits", int) == 0) {
      // Need to have more if statements here if there were more units available.
      value = value;
    } else if (settings.getSetting("temperatureUnits", int) == 1) {
      value = (value * (9 / 5) + 32);
    } else if (settings.getSetting("temperatureUnits", int) == 2) {
      value = value + 273.15;
    }
  } else if (type == "wind" || measurementCategories["wind"]!.contains(type)) {
    if (settings.getSetting("windUnits", int) != 0) {
      value = value / 1.60934;
    }
  } else if (type == "rain" || measurementCategories["rain"]!.contains(type)) {
    if (settings.getSetting("rainUnits", int) != 0) {
      value = value / 25.4;
    }
  } else {
    value = value;
  }

  value = convertDataType(value, dataType, roundingDegree);
  return value;
}

// Round to given number of decimal places
String roundDouble(value, int decimals) {
  if (value.runtimeType != double) {
    value = value.toString();
    value = double.parse(value);
  }
  value = value.toStringAsFixed(decimals);
  return value;
}

// Conver to the correct data type
dynamic convertDataType(value, dataType, roundingDegree) {
  if (dataType == 0) {
    value = value.toString();
  } else if (dataType == 1) {
    value = double.parse(roundDouble(value, roundingDegree));
  } else if (dataType == 2) {
    value = standardDateTimeFormat.format(DateTime.parse(value));
  } else if (dataType == 3) {
    value = int.parse((value).toStringAsFixed(0));
  }

  return value;
}
