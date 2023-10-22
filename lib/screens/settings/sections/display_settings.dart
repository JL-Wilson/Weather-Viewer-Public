import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/screens/settings/sections/homepage_settings_page.dart';
import 'package:weatherapp3/screens/settings/sections/theme_settings.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class DisplaySettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const DisplaySettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<DisplaySettingsPage> createState() => _DisplaySettingsPageState();
}

class _DisplaySettingsPageState extends State<DisplaySettingsPage> {
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
          "Display Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ThemeSettingsPage(
                              latestData: widget.latestData,
                              settings: widget.settings,
                            )));
              },
              child: ListTile(
                title: Text(
                  "Theme Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  ForecastIcons.right_open_big,
                  size: 40,
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => HomePageSettingsPage(
                              latestData: latestData,
                              settings: settings,
                            )));
              },
              child: ListTile(
                title: Text(
                  "Homepage Chart Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  ForecastIcons.right_open_big,
                  size: 40,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Homepage Map",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    settings.setSetting("homepageMapSetting", value, int);
                  });
                },
                value: settings.getSetting("homepageMapSetting", int),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      "Rainfall",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      "Temperature",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Homepage Measurement",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    settings.setSetting("homepageMeasurement", value, int);
                  });
                },
                value: settings.getSetting("homepageMeasurement", int),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      "Garden",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      "Feels Like",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text(
                      "Outdoor Humidity",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text(
                      "Wind Speed",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text(
                      "Wind Gust",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 5,
                    child: Text(
                      "Pressure",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 6,
                    child: Text(
                      "Rainfall",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 21,
                    child: Text(
                      "Wind Direction",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 22,
                    child: Text(
                      "Wind Degrees",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Wind Type",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    settings.setSetting("windDisplayType", value, int);
                  });
                },
                value: settings.getSetting("windDisplayType", int),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      "Degrees",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      "Compass",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SystemInformation().getAppType(context) == AppType.mobile
              ? Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      "Fullscreen Mode",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Checkbox(
                      value: widget.settings.getSetting("fullscreenMode", bool),
                      onChanged: (value) {
                        setState(() {
                          widget.settings
                              .setSetting("fullscreenMode", value, bool);
                          platformInfo.toggleFullscreen();
                        });
                      },
                    ),
                  ),
                )
              : Container(),
          Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                "Experimental Features",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Checkbox(
                value: widget.settings.getSetting("experimentalFeatures", bool),
                onChanged: (value) {
                  setState(() {
                    widget.settings.toggleSetting("experimentalFeatures");
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
