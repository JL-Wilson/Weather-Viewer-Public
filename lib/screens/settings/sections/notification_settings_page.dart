import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class NotificationSettingsPage extends StatefulWidget {
  final Settings settings;

  const NotificationSettingsPage({Key? key, required this.settings})
      : super(key: key);

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late Settings settings;
  late CurrentDataSlice latestData;

  @override
  void initState() {
    settings = widget.settings;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            child: ListTile(
              title: Text(
                "Daily Notification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Checkbox(
                value: settings.getSetting("dailyNotification", bool),
                onChanged: (value) {
                  setState(() {
                    settings.toggleSetting("dailyNotification");
                    if (value != null) {
                      if (value) {
                        FirebaseMessaging.instance
                            .subscribeToTopic("daily_notification");
                      } else {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic("daily_notification");
                      }
                    }
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Rain Notification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Checkbox(
                value: settings.getSetting("rainNotification", bool),
                onChanged: (value) {
                  setState(() {
                    settings.toggleSetting("rainNotification");
                    if (value != null) {
                      if (value) {
                        FirebaseMessaging.instance
                            .subscribeToTopic("rain_notification");
                      } else {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic("rain_notification");
                      }
                    }
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "High Temperature Notification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Checkbox(
                value: settings.getSetting("highTempNotification", bool),
                onChanged: (value) {
                  setState(() {
                    settings.toggleSetting("highTempNotification");
                    if (value != null) {
                      if (value) {
                        FirebaseMessaging.instance
                            .subscribeToTopic("high_temp_notification");
                      } else {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic("high_temp_notification");
                      }
                    }
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Indoor-Outdoor Temperature Notification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Checkbox(
                value: settings.getSetting(
                    "indoorOutdoorTemperatureNotification", bool),
                onChanged: (value) {
                  setState(() {
                    settings
                        .toggleSetting("indoorOutdoorTemperatureNotification");
                    if (value != null) {
                      if (value) {
                        FirebaseMessaging.instance
                            .subscribeToTopic("hotter_now_notification");
                      } else {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic("hotter_now_notification");
                      }
                    }
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
