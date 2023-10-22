// jlwilson
// 27/02/22
// This contains the code for creating and returning a chart

// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'data.dart';

class ChartBuilder extends StatefulWidget {
  final DataCollection chartCollection;
  final List chartsToDisplay;
  final String chartType;
  final Map<String, dynamic> chartSettings;

  const ChartBuilder({
    Key? key,
    required this.chartCollection,
    required this.chartsToDisplay,
    required this.chartType,
    this.chartSettings = const {
      "trendline": Null,
      "trendlineColour": Colors.blue,
    },
  }) : super(key: key);

  @override
  State<ChartBuilder> createState() => _ChartBuilderState();
}

class _ChartBuilderState extends State<ChartBuilder> {
  late final DataCollection chartCollection;
  late final List chartsToDisplay;
  late String chartType;
  late Map<String, dynamic> chartSettings;

  Widget chartWidget = const CircularProgressIndicator();

  @override
  void initState() {
    chartCollection = widget.chartCollection;
    chartsToDisplay = widget.chartsToDisplay;
    chartType = widget.chartType;
    chartSettings = widget.chartSettings;

    super.initState();
    main();
  }

  main() async {
    await createChart();
  }

  createChart() async {
    bool validChartData = false;

    if (chartCollection.getCollection().isNotEmpty) {
      validChartData = true;
    } else {
      validChartData = await chartCollection.createCollection();
    }

    if (validChartData) {
      if (chartsToDisplay.isNotEmpty) {
        double animationDuration = 2000;
        if (chartType == "homepage") {
          animationDuration = 0;
        } else {
          animationDuration = 2000;
        }

        List<ChartData> formattedData = [];
        for (var slice in chartCollection.getCollection()) {
          formattedData.add(ChartData(slice));
        }

        List<LineSeries<ChartData, DateTime>> series = [];
        chartCollection.calculateMinMaxAvg();

        List<double> minList = [];
        List<double> maxList = [];

        for (var chartName in chartsToDisplay) {
          minList.add(double.parse(
              chartCollection.getMinMaxAvg(chartName, "min").toString()));
          maxList.add(double.parse(
              chartCollection.getMinMaxAvg(chartName, "max").toString()));
        }

        List<double> minMax = [minList[0], maxList[0]];

        for (var i = 0; i < minList.length; i++) {
          if (minList[i] < minMax[0]) {
            minMax[0] = minList[i] - (minList[i] * 0.05);
          }

          if (maxList[i] > minMax[1]) {
            minMax[1] = maxList[i];
          }
        }

        if (chartsToDisplay.contains("atpres")) {
          minMax[1] = (minMax[1] + 1).ceilToDouble();
          minMax[0] = (minMax[0] - 1).floorToDouble();
        } else {
          minMax[1] = (minMax[1] + (minMax[1] * 0.05)).ceilToDouble();
          minMax[0] = (minMax[0] - (minMax[0] * 0.05)).floorToDouble();
        }

        List<Trendline> trendLines = [];
        var selectedTrendline = chartSettings["trendline"];

        if (selectedTrendline != Null) {
          trendLines.add(Trendline(
            type: selectedTrendline,
            color: chartSettings["trendlineColour"],
          ));
        }

        for (var chartName in chartsToDisplay) {
          series.add(LineSeries(
            dataSource: formattedData,
            animationDuration: animationDuration,
            trendlines: trendLines,
            name: chartCollection
                .getValueAtIndex(0)
                .returnValue(chartName)
                .getDisplayName(),
            xValueMapper: (ChartData series, _) =>
                getChartDataValue(series, "tstamp"),
            yValueMapper: (ChartData series, _) =>
                getChartDataValue(series, chartName),
          ));
        }

        if (chartType == "homepage") {
          chartWidget = SfCartesianChart(
            plotAreaBorderWidth: 0,
            legend: const Legend(
              isVisible: true,
              isResponsive: true,
              position: LegendPosition.bottom,
            ),
            primaryXAxis: DateTimeAxis(
                isVisible: false,
                majorGridLines: const MajorGridLines(
                  width: 0,
                ),
                axisLine: const AxisLine(
                  width: 0,
                )),
            primaryYAxis: NumericAxis(
              minimum: minMax[0],
              maximum: minMax[1],
              isVisible: false,
              majorGridLines: const MajorGridLines(
                width: 0,
              ),
              axisLine: const AxisLine(
                width: 0,
              ),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            borderWidth: 0,
            series: series,
          );
        } else {
          chartWidget = SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: NumericAxis(
              minimum: minMax[0],
              maximum: minMax[1],
            ),
            legend: const Legend(
              position: LegendPosition.top,
              isVisible: true,
              isResponsive: true,
            ),
            series: series,
            plotAreaBorderWidth: 0,
            borderWidth: 0,
            tooltipBehavior: TooltipBehavior(enable: true),
            zoomPanBehavior: ZoomPanBehavior(
              enableDoubleTapZooming: true,
              enableMouseWheelZooming: true,
              enablePanning: true,
              enablePinching: true,
              enableSelectionZooming: true,
            ),
          );
        }
      } else {
        chartWidget = const Text("Invalid chart Selection");
      }
    } else {
      chartWidget = const Text("Data Error");
    }

    if (mounted) {
      setState(() {});
    }
  }

  getChartDataValue(series, valueName) {
    switch (valueName) {
      case 'tstamp':
        return series.tstamp;
      case 'atpres':
        return series.atpres;
      case 'gTemp':
        return series.gTemp;
      case 'oHumid':
        return series.oHumid;
      case 'wsp':
        return series.wsp;
      case 'gust':
        return series.gust;
      case 'rain':
        return series.rain;
      case 'feelsLike':
        return series.feelsLike;
      case "srTemp":
        return series.srTemp;
      case "atticTemp":
        return series.atticTemp;
      case "garageTemp":
        return series.garageTemp;
      case "driveTemp":
        return series.driveTemp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: chartWidget,
    );
  }
}

class ChartData {
  late DateTime tstamp;
  late int dlta;
  late double atpres;
  late double gTemp;
  late double oHumid;
  late double wsp;
  late double gust;
  late double rain;
  late double feelsLike;
  late double srTemp;
  late double atticTemp;
  late double garageTemp;
  late double driveTemp;

  final DataSlice _dataToLoad;

  ChartData(this._dataToLoad) {
    // This could probably be simplified into a loop at some point
    tstamp = DateTime.parse(_dataToLoad.returnValue("tstamp").getValue());
    dlta = _dataToLoad.returnValue("dlta").getValue();
    atpres = _dataToLoad.returnValue("atpres").getValue();
    gTemp = _dataToLoad.returnValue("gTemp").getValue();
    oHumid =
        double.parse(_dataToLoad.returnValue("oHumid").getValue().toString());
    wsp = _dataToLoad.returnValue("wsp").getValue();
    gust = _dataToLoad.returnValue("gust").getValue();
    rain = _dataToLoad.returnValue("rain").getValue();
    feelsLike = _dataToLoad.returnValue("feelsLike").getValue();
    srTemp = _dataToLoad.returnValue("srTemp").getValue();
    atticTemp = _dataToLoad.returnValue("atticTemp").getValue();
    garageTemp = _dataToLoad.returnValue("garageTemp").getValue();
    driveTemp = _dataToLoad.returnValue("driveTemp").getValue();
  }
}
