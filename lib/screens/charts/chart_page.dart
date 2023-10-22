// jlwilson
// 27/02/22

// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp3/screens/charts/min_max_page.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

// App Imports
import 'package:weatherapp3/utils/chart_builder.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';

class ChartPage extends StatefulWidget {
  final List<String> chartsToDisplay;
  final String chartType;
  final DataCollection chartData;
  final Map<String, dynamic> chartSettings;
  final Settings settings;

  const ChartPage({
    Key? key,
    required this.chartsToDisplay,
    required this.chartType,
    required this.chartData,
    required this.settings,
    this.chartSettings = const {
      "trendline": Null,
      "trendlineColour": Colors.blue,
    },
  }) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // List of which charts to be displayed
  late final List<String> _chartsToDisplay;

  // This does not matter as long as it is not "homepage". In the future it could be used to specify diferent formatting or similar.
  late final String _chartType;
  late final DataCollection _chartData;
  late final Map<String, dynamic> _chartSettings;
  late final Settings settings;

  @override
  void initState() {
    _chartsToDisplay = widget.chartsToDisplay;
    _chartType = widget.chartType;
    _chartData = widget.chartData;
    _chartSettings = widget.chartSettings;
    settings = widget.settings;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SystemInformation().getAppType(context) == AppType.display ||
              SystemInformation().getDisplaySize(context) ==
                  DisplaySize.landscape
          ? null
          : AppBar(
              title: Text(
                "Charts",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MinMaxPage(
                                chartData: _chartData,
                                chartsToDisplay: _chartsToDisplay)),
                      );
                    },
                    child: const Icon(
                      ForecastIcons.info_circled,
                    ),
                  ),
                )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton:
          SystemInformation().getAppType(context) != AppType.display &&
                  SystemInformation().getDisplaySize(context) ==
                      DisplaySize.portrait
              ? Container()
              : Padding(
                  padding:
                      SystemInformation().getAppType(context) == AppType.display
                          ? const EdgeInsets.only(top: 8)
                          : EdgeInsets.zero,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          FloatingActionButton.small(
                            heroTag: null,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: FloatingActionButton.small(
                              heroTag: null,
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => MinMaxPage(
                                          chartData: _chartData,
                                          chartsToDisplay: _chartsToDisplay)),
                                );
                              },
                              child: Icon(
                                ForecastIcons.info_circled,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
      body: SafeArea(
        child: Center(
          child: ChartBuilder(
            chartCollection: _chartData,
            chartType: _chartType,
            chartsToDisplay: _chartsToDisplay,
            chartSettings: _chartSettings,
          ),
        ),
      ),
    );
  }
}
