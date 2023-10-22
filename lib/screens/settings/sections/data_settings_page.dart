import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/screens/settings/sections/location_settings_page.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class DataSettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const DataSettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<DataSettingsPage> createState() => _DataSettingsPageState();
}

class _DataSettingsPageState extends State<DataSettingsPage> {
  late Settings settings;
  late CurrentDataSlice latestData;

  @override
  void initState() {
    settings = widget.settings;
    latestData = widget.latestData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Last Data Update",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        DateFormat("dd/MM/yyyy h:mm a").format(DateTime.parse(
                            widget.latestData
                                .returnValue("tstamp")
                                .getValue()
                                .toString())),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Last Data Check",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(widget.latestData.lastRefresh.toString(),
                          style: Theme.of(context).textTheme.labelLarge),
                    ],
                  )
                ],
              ),
            ),
          ),
          latestData.forecastAvailable
              ? Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => LocationSettingsPage(
                                    latestData: latestData,
                                    settings: settings,
                                  )));
                    },
                    child: ListTile(
                      title: Text(
                        "Location Settings",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.left,
                      ),
                      trailing: const Icon(
                        ForecastIcons.right_open_big,
                        size: 40,
                      ),
                    ),
                  ),
                )
              : Container(),
          Card(
            child: ListTile(
                title: Text(
                  "Temperature Units",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      settings.setSetting("temperatureUnits", value, int);
                    });
                  },
                  value: settings.getSetting("temperatureUnits", int),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "Celcius (°C)",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "Farenheit (°F)",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        "Kelvin (K)",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                )),
          ),
          Card(
            child: ListTile(
                title: Text(
                  "Wind Units",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      settings.setSetting("windUnits", value, int);
                    });
                  },
                  value: settings.getSetting("windUnits", int),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "km/h",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "mph",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                )),
          ),
          Card(
            child: ListTile(
                title: Text(
                  "Rain Units",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      settings.setSetting("rainUnits", value, int);
                    });
                  },
                  value: settings.getSetting("rainUnits", int),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "mm",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "inches",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                )),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Homepage Chart Period",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                "${settings.getSetting("homepageChartPeriod", int)} hours",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: SizedBox(
                width: 200,
                child: Slider(
                  thumbColor: Theme.of(context).colorScheme.onPrimary,
                  value: double.parse(settings
                      .getSetting("homepageChartPeriod", int)
                      .toString()),
                  onChanged: (value) {
                    setState(() {
                      settings.setSetting("homepageChartPeriod",
                          value.toStringAsFixed(0), String);
                    });
                  },
                  min: 1,
                  max: 24,
                  divisions: 24,
                  label: settings
                      .getSetting("homepageChartPeriod", int)
                      .toString(),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Rain Comparison",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    settings.setSetting("rainComparisonPeriod", value, int);
                  });
                },
                value: settings.getSetting("rainComparisonPeriod", int),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      "Latest",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      "Period (${settings.getSetting("rainComparisonTimePeriod", int)} hours)",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          settings.getSetting("rainComparisonPeriod", int) == 1
              ? Card(
                  child: ListTile(
                    title: Text(
                      "Rain Period",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      "${settings.getSetting("rainComparisonTimePeriod", int)} hours",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    trailing: SizedBox(
                      width: 200,
                      child: Slider(
                        thumbColor: Theme.of(context).colorScheme.onPrimary,
                        value: double.parse(settings
                            .getSetting("rainComparisonTimePeriod", int)
                            .toString()),
                        onChanged: (value) {
                          setState(() {
                            settings.setSetting("rainComparisonTimePeriod",
                                value.toStringAsFixed(0), String);
                          });
                        },
                        min: 1,
                        max: 24,
                        divisions: 24,
                        label: settings
                            .getSetting("rainComparisonTimePeriod", int)
                            .toString(),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
