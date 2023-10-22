import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:weatherapp3/utils/settings.dart';

class ServerSettingsPage extends StatefulWidget {
  final Settings settings;

  const ServerSettingsPage({Key? key, required this.settings})
      : super(key: key);

  @override
  State<ServerSettingsPage> createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  late Settings settings;

  TextEditingController primaryController = TextEditingController();
  TextEditingController secondaryController = TextEditingController();

  @override
  void initState() {
    settings = widget.settings;

    super.initState();
    primaryController.text = settings.getSetting("serverOne", String);
    secondaryController.text = settings.getSetting("serverTwo", String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Server Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: () {
                String server = primaryController.text;
                if (server.substring(0, 7) == "http://") {
                  primaryController.text = server.substring(7);
                }

                server = secondaryController.text;
                if (server.substring(0, 7) == "http://") {
                  primaryController.text = server.substring(7);
                }

                settings.setSetting(
                    "serverOne", primaryController.text, String);
                settings.setSetting(
                    "serverTwo", secondaryController.text, String);

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Restart App",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        content: Text(
                          "Restart app to apply changes",
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
              child: const Icon(
                Icons.save,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: TextField(
                style: Theme.of(context).textTheme.titleMedium,
                controller: primaryController,
                decoration: InputDecoration(
                    labelText: "Primary",
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    hintText: "e.g. WeatherCollector",
                    prefixIcon: Icon(
                      Icons.dns,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: TextField(
                style: Theme.of(context).textTheme.titleMedium,
                controller: secondaryController,
                decoration: InputDecoration(
                    labelText: "Secondary",
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    hintText: "e.g. 192.168.0.200",
                    prefixIcon: Icon(
                      Icons.dns,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
