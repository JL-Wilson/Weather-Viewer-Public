import 'package:flutter/material.dart';

import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class HomePageSettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const HomePageSettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<HomePageSettingsPage> createState() => _HomePageSettingsPageState();
}

class _HomePageSettingsPageState extends State<HomePageSettingsPage> {
  late Settings settings;
  late CurrentDataSlice latestData;

  final Map<String, bool> _chartMeasurementSelectStatus = {
    "gTemp": false,
    "feelsLike": false,
    "oHumid": false,
    "wsp": false,
    "gust": false,
    "atpres": false,
    "rain": false,
    "srTemp": false,
    "atticTemp": false,
    "garageTemp": false,
    "driveTemp": false,
  };

  @override
  void initState() {
    settings = widget.settings;
    latestData = widget.latestData;

    loadSettings();

    super.initState();
  }

  loadSettings() {
    List<String> savedSettings =
        settings.getSetting("homepageChartSelection", List);

    for (var type in savedSettings) {
      List<String> setting = type.split(":");

      _chartMeasurementSelectStatus[setting[0]] =
          (int.parse(setting[1].toString()) == 0 ? false : true);
    }

    setState(() {});
    return true;
  }

  saveSettings() {
    String tempStr = "";
    for (var key in _chartMeasurementSelectStatus.keys) {
      bool? temp = _chartMeasurementSelectStatus[key];

      int boolValue;
      if (temp == true) {
        boolValue = 1;
      } else {
        boolValue = 0;
      }

      tempStr = "$tempStr$key:$boolValue/";
    }

    tempStr = tempStr.substring(0, tempStr.length - 1);

    settings.setSetting("homepageChartSelection", tempStr, String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Homepage Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          primary: false,
          physics: const BouncingScrollPhysics(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Card(
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Select Measurements: ",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          )),

                      // Temperature Select
                      Card(
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "gTemp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "gTemp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "gTemp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "gTemp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Outdoors",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "srTemp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "srTemp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "srTemp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "srTemp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Indoors",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "garageTemp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "garageTemp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "garageTemp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "garageTemp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Garage",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "feelsLike"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "feelsLike"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "feelsLike"] =
                                                !_chartMeasurementSelectStatus[
                                                    "feelsLike"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Feels Like",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "atticTemp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "atticTemp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "atticTemp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "atticTemp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Attic",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "driveTemp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "driveTemp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "driveTemp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "driveTemp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Drive",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),

                      // Humidity Select
                      Card(
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "oHumid"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "oHumid"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "oHumid"] =
                                                !_chartMeasurementSelectStatus[
                                                    "oHumid"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Humidity",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),

                      // Wind Select
                      Card(
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "wsp"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "wsp"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "wsp"] =
                                                !_chartMeasurementSelectStatus[
                                                    "wsp"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Average",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "gust"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "gust"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "gust"] =
                                                !_chartMeasurementSelectStatus[
                                                    "gust"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Gust",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),

                      // Other Select
                      Card(
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "atpres"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "atpres"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "atpres"] =
                                                !_chartMeasurementSelectStatus[
                                                    "atpres"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Pressure",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Checkbox(
                                        value: _chartMeasurementSelectStatus[
                                            "rain"],
                                        onChanged: (value) {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                "rain"] = value!;
                                          });
                                          saveSettings();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _chartMeasurementSelectStatus[
                                                    "rain"] =
                                                !_chartMeasurementSelectStatus[
                                                    "rain"]!;
                                          });
                                          saveSettings();
                                        },
                                        child: Text(
                                          "Rainfall",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ])),
              ])),
    );
  }
}
