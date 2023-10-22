import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/screens/forecast/map_page.dart';
import 'package:weatherapp3/screens/forecast/widgets/homepage_view_more_widget.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class HomepageMainDisplayWidget extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Settings settings;

  const HomepageMainDisplayWidget(
      {Key? key, required this.latestData, required this.settings})
      : super(key: key);

  @override
  State<HomepageMainDisplayWidget> createState() =>
      _HomepageMainDisplayWidgetState();
}

class _HomepageMainDisplayWidgetState extends State<HomepageMainDisplayWidget> {
  late final CurrentDataSlice latestData;
  late final Settings settings;

  Map<int, String> measurementSettingsID = {
    0: "gTemp",
    1: "feelsLike",
    2: "oHumid",
    3: "wsp",
    4: "gust",
    5: "atpres",
    6: "rain",
    7: "forecastFeelsLike",
    8: "forecastGust",
    9: "forecastHumidity",
    10: "forecastTemp",
    11: "forecastVisibility",
    12: "forecastWindDirection",
    13: "forecastWindSpeed",
    14: "forecastUV",
    15: "forecastWeatherType",
    16: "forecastPrecipitationProbability",
    17: "srTemp",
    18: "atticTemp",
    19: "garageTemp",
    20: "driveTemp",
    21: "wdir",
    22: "dlta",
  };

  @override
  void initState() {
    latestData = widget.latestData;
    settings = widget.settings;

    super.initState();
  }

  String getMapUrl() {
    String measurement = settings.getSetting("homepageMapSetting", int) == 0
        ? "rainfall"
        : "temperature";

    return "http://${platformInfo.serverToUse}/api/v2/request/maps/$measurement/${latestData.mapInfo.startingMapImage}.png";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          getMapUrl(),
                          width: SystemInformation().getAppType(context) ==
                                  AppType.display
                              ? 75
                              : 150,
                          height: SystemInformation().getAppType(context) ==
                                  AppType.display
                              ? 75
                              : 150,
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ForecastMapPage(
                                              settings: settings,
                                              latestData: latestData,
                                            )));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            latestData
                                .returnValue(measurementSettingsID[settings
                                    .getSetting("homepageMeasurement", int)])
                                .getValue()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          Text(
                            latestData
                                .returnValue(measurementSettingsID[settings
                                    .getSetting("homepageMeasurement", int)])
                                .getShortUnits()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        latestData
                            .returnValue(measurementSettingsID[settings
                                .getSetting("homepageMeasurement", int)])
                            .getDisplayName()
                            .toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            latestData.forecastAvailable &&
                    SystemInformation().getAppType(context) != AppType.display
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                    child: HomepageViewMoreWidget(
                        forecast: latestData.nextForecast(),
                        measurementInfo: latestData.measurements,
                        date: latestData.nextForecast()["DD"],
                        latestData: latestData,
                        clickFunction: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ForecastMapPage(
                                        settings: settings,
                                        latestData: latestData,
                                      )));
                        },
                        dateEnabled: true),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(20)),
                child: latestData.homeChart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
