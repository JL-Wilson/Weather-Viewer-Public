import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/platform_type.dart';

import 'chart_builder.dart';
import 'data.dart';
import 'settings.dart';

class HomeScreenChart extends StatefulWidget {
  final Settings settings;
  final DataCollection homeChartCollection;

  const HomeScreenChart(
      {Key? key, required this.homeChartCollection, required this.settings})
      : super(key: key);

  @override
  State<HomeScreenChart> createState() => _HomeScreenChartState();
}

class _HomeScreenChartState extends State<HomeScreenChart> {
  late Settings _settings;
  late DataCollection homeChartCollection;

  @override
  void initState() {
    homeChartCollection = widget.homeChartCollection;
    _settings = widget.settings;

    super.initState();
  }

  List<String> returnCharts() {
    List userSelectedCharts =
        _settings.getSetting("homepageChartSelection", List);
    List<String> charts = [];

    for (String chart in userSelectedCharts) {
      List tempChartDetail = chart.split(":");

      if (int.parse(tempChartDetail[1].toString()) == 0 ? false : true) {
        charts.add(tempChartDetail[0]);
      }
    }
    return charts;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SystemInformation().getAppType(context) == AppType.display
          ? 200 * 0.75
          : 200,
      child: ChartBuilder(
        chartCollection: homeChartCollection,
        chartType: "homepage",
        chartsToDisplay: returnCharts(),
      ),
    );
  }
}
