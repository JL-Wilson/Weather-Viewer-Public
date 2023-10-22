import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/inputs/color_picker.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class ThemeSettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const ThemeSettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  late Settings settings;
  late CurrentDataSlice latestData;

  @override
  void initState() {
    settings = widget.settings;
    latestData = widget.latestData;

    super.initState();
  }

  enterColour(settingName) async {
    var pickedColour = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: ColorPicker(
              settings: settings,
            ),
          );
        });
    if (pickedColour.toString().toLowerCase() != "null") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Confirm",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              "Restart app to save changes",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      settings.setSetting(settingName, pickedColour, int);
                    });
                    Phoenix.rebirth(context);
                  },
                  child: Text(
                    "Restart",
                    style: Theme.of(context).textTheme.labelLarge,
                  ))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                "Theme",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: DropdownButton(
                onChanged: (value) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Confirm",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(
                            "Restart app to save changes",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: Theme.of(context).textTheme.labelLarge,
                                )),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    widget.settings
                                        .setSetting("themeMode", value, int);
                                  });
                                  Phoenix.rebirth(context);
                                },
                                child: Text(
                                  "Restart",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ))
                          ],
                        );
                      });
                },
                value: widget.settings.getSetting("themeMode", int),
                items:
                    SystemInformation().getAppType(context) == AppType.display
                        ? [
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                "Light",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text(
                                "Dark",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ]
                        : [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                "System",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                "Light",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text(
                                "Dark",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
              ),
            ),
          ),
          SystemInformation().getAppType(context) == AppType.mobile &&
                  settings.getSetting("experimentalFeatures", bool) != false
              ? Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      "Material You",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Checkbox(
                      value: widget.settings.getSetting("materialYou", bool),
                      onChanged: (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Confirm",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              content: Text(
                                "Restart app to save changes",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        settings.setSetting(
                                            "materialYou", value, bool);
                                      });
                                      Phoenix.rebirth(context);
                                    },
                                    child: Text(
                                      "Restart",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ))
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Container(),
          settings.getSetting("materialYou", bool) ||
                  settings.getSetting("experimentalFeatures", bool) == false
              ? Container()
              : Card(
                  elevation: 2,
                  child: ListTile(
                      title: Text(
                        "Pick Light Colour",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          enterColour("lightThemeColour");
                        },
                        child: Text(
                          "Pick Colour",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      )),
                ),
          settings.getSetting("materialYou", bool) ||
                  settings.getSetting("experimentalFeatures", bool) == false
              ? Container()
              : Card(
                  elevation: 2,
                  child: ListTile(
                      title: Text(
                        "Pick Dark Colour",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          enterColour("darkThemeColour");
                        },
                        child: Text(
                          "Pick Colour",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      )),
                )
        ],
      ),
    );
  }
}
