import 'package:flutter/material.dart';

import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/inputs/number_input_display.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class LocationSettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const LocationSettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<LocationSettingsPage> createState() => _LocationSettingsPageState();
}

class _LocationSettingsPageState extends State<LocationSettingsPage> {
  late final Settings settings;
  late final CurrentDataSlice latestData;

  TextEditingController searchController = TextEditingController();

  List searchItems = [];

  @override
  void initState() {
    settings = widget.settings;
    latestData = widget.latestData;

    super.initState();
  }

  void filterSearchResults(String query) {
    List<List> dummySearchList = [];
    
    dummySearchList.addAll(latestData.locationList);
    if (query.isNotEmpty) {
      List<List> dummyListData = [];
      for (var item in dummySearchList) {
        if (item[2].toString().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }

      setState(() {
        searchItems.clear();
        searchItems.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        searchItems.clear();
      });
    }
  }

  locationInputTapped() async {
    if (SystemInformation().getAppType(context) == AppType.display) {
      searchController.text = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              content: NumberInputDisplay(
                startingValue: searchController.text,
              ),
            );
          });
    }

    filterSearchResults(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Location Settings",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  "Current Location",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      latestData.currentSetLocation(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      latestData.currentSetLocationID(),
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  locationInputTapped();
                },
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  style: Theme.of(context).textTheme.titleLarge,
                  controller: searchController,
                  decoration: InputDecoration(
                      enabled: SystemInformation().getAppType(context) ==
                              AppType.display
                          ? false
                          : true,
                      labelText: "Search",
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      // hintText: "Search",
                      prefixIcon: Icon(
                        ForecastIcons.location,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      settings.setSetting(
                          "forecastLocation", searchItems[index][1], String);
                      setState(() {});
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          searchItems[index][0],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          searchItems[index][1],
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
