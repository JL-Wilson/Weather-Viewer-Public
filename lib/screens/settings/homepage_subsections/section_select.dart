import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/screens/settings/sections/account_settings_page.dart';
import 'package:weatherapp3/screens/settings/sections/data_settings_page.dart';
import 'package:weatherapp3/screens/settings/sections/display_settings.dart';
import 'package:weatherapp3/screens/settings/sections/notification_settings_page.dart';
import 'package:weatherapp3/screens/settings/sections/server_settings.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class SectionSelect extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Settings settings;

  const SectionSelect(
      {Key? key, required this.latestData, required this.settings})
      : super(key: key);

  @override
  State<SectionSelect> createState() => _SectionSelectState();
}

class _SectionSelectState extends State<SectionSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SystemInformation().getAppType(context) == AppType.mobile
              ? Card(
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AccountSettingsPage(
                                    settings: widget.settings,
                                    latestData: widget.latestData,
                                  )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Settings",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Icon(
                            ForecastIcons.right_open_big,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          SystemInformation().getAppType(context) == AppType.mobile
              ? Card(
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => NotificationSettingsPage(
                                    settings: widget.settings,
                                  )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification Settings",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Icon(
                            ForecastIcons.right_open_big,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          Card(
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => DataSettingsPage(
                              settings: widget.settings,
                              latestData: widget.latestData,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Data Settings",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                    Icon(
                      ForecastIcons.right_open_big,
                      size: 40,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => DisplaySettingsPage(
                              settings: widget.settings,
                              latestData: widget.latestData,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Display Settings",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                    Icon(
                      ForecastIcons.right_open_big,
                      size: 40,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SystemInformation().getAppType(context) != AppType.display
              ? Card(
                  elevation: 2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ServerSettingsPage(
                                    settings: widget.settings,
                                  )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Server Settings",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.left,
                          ),
                          Icon(
                            ForecastIcons.right_open_big,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.error,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  widget.settings.resetSettings();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reset Settings",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onError),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
