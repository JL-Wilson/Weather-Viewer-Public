// Imports of third party packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/screens/charts/chart_page.dart';
import 'package:weatherapp3/screens/forecast/map_page.dart';
import 'package:weatherapp3/screens/forecast/widgets/homepage_view_more_widget.dart';
import 'package:weatherapp3/screens/loading/data_fetch_screen.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/forecast_data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';
import 'package:weatherapp3/widgets/display/home/homepage_main_display.dart';
import 'package:weatherapp3/widgets/display/home/humidity.dart';
import 'package:weatherapp3/widgets/display/home/other.dart';
import 'package:weatherapp3/widgets/display/home/temperature.dart';
import 'package:weatherapp3/widgets/display/home/wind.dart';

class DataPage extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Settings settings;

  const DataPage({Key? key, required this.latestData, required this.settings})
      : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late final CurrentDataSlice latestData;
  late final Settings settings;
  late final ForecastDay currentDayForecasts;

  @override
  void initState() {
    latestData = widget.latestData;
    settings = widget.settings;
    super.initState();
  }

  viewChart(charts) async {
    if (latestData.loaded) {
      DataCollection chartCollection = DataCollection(
          "/api/v2/request/within.php?&passkey=$dataPasskey&units=hours&number=${settings.getSetting("homepageChartPeriod", int)}");

      await chartCollection.createCollection();

      if (mounted) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ChartPage(
                      chartsToDisplay: charts,
                      chartType: "chartPage",
                      chartData: chartCollection,
                      settings: settings,
                    )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildWideLayout() {
      return SingleChildScrollView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: HomepageMainDisplayWidget(
                          latestData: latestData, settings: settings),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WindDisplayWidget(
                      latestData: latestData,
                      viewChart: viewChart,
                      settings: settings,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    latestData.forecastAvailable &&
                            SystemInformation().getAppType(context) ==
                                AppType.display
                        ? HomepageViewMoreWidget(
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
                            dateEnabled: true)
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TemperatureDisplayWidget(
                          latestData: latestData, viewChart: viewChart),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OtherDisplayWidget(
                          latestData: latestData, viewChart: viewChart),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HumidityDisplayWidget(
                          latestData: latestData, viewChart: viewChart),
                    ),
                  ]),
            ),
          ],
        ),
      );
    }

    Widget buildNormalLayout() {
      return RefreshIndicator(
        onRefresh: () {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => RefreshPage(
                        latestData: latestData,
                        pageToDisplay: 0,
                      )),
              (route) => false);
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          primary: false,
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomepageMainDisplayWidget(
                    latestData: latestData, settings: settings),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Theme.of(context).colorScheme.surface),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TemperatureDisplayWidget(
                              latestData: latestData, viewChart: viewChart),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: HumidityDisplayWidget(
                                latestData: latestData, viewChart: viewChart),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: WindDisplayWidget(
                              latestData: latestData,
                              viewChart: viewChart,
                              settings: settings,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: OtherDisplayWidget(
                                latestData: latestData, viewChart: viewChart),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
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
