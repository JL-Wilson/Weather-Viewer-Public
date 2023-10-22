// jlwilson
// 06/06/2023

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/screens/settings/sections/notification_settings_page.dart';
import 'package:weatherapp3/screens/settings/sections/server_settings.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class BootSettings extends StatefulWidget {
  const BootSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<BootSettings> createState() => _BootSettingsPageState();
}

class _BootSettingsPageState extends State<BootSettings> {
  final Settings _settings = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SystemInformation().getAppType(context) == AppType.mobile
                      ? Card(
                          elevation: 2,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          NotificationSettingsPage(
                                            settings: _settings,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notification Settings",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Icon(
                                    ForecastIcons.right_open_big,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
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
                                            settings: _settings,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Server Settings",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Icon(
                                    ForecastIcons.right_open_big,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ]),
          ],
        ),
      ),
    );
  }
}
