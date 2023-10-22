// jlwilson
// 27/02/22
// This contains the pages of the settings menu

// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:weatherapp3/screens/settings/homepage_subsections/application_details.dart';
import 'package:weatherapp3/screens/settings/homepage_subsections/section_select.dart';
import 'package:weatherapp3/utils/platform_type.dart';

// Imports of other code written for this app
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class SettingsPage extends StatefulWidget {
  final CurrentDataSlice latestData;

  const SettingsPage({
    Key? key,
    required this.latestData,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // The latest data (CurrentDataSlice)
  late final CurrentDataSlice latestData;

  // An instance of Settings
  final Settings _settings = Settings();

  @override
  void initState() {
    latestData = widget.latestData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildWideLayout() {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: const BackButton(),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              primary: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: ApplicationDetails(latestData: latestData),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: SectionSelect(
                        latestData: latestData,
                        settings: _settings,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

    Widget buildNormalLayout() {
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
              ApplicationDetails(latestData: latestData),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child:
                    SectionSelect(latestData: latestData, settings: _settings),
              ),
            ],
          ),
        ),
      );
    }

    if (SystemInformation().getDisplaySize(context) == DisplaySize.landscape) {
      return buildWideLayout();
    } else {
      return buildNormalLayout();
    }
  }
}
