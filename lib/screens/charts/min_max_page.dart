// Imports of third party packages
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/data.dart';

class MinMaxPage extends StatefulWidget {
  final DataCollection chartData;
  final List<String> chartsToDisplay;

  const MinMaxPage(
      {Key? key, required this.chartData, required this.chartsToDisplay})
      : super(key: key);

  @override
  State<MinMaxPage> createState() => _MinMaxPageState();
}

class _MinMaxPageState extends State<MinMaxPage> {
  // The data for the mimumum, maximum, and average to be calculated with
  late final DataCollection chartData;

  // The charts to show data for
  late final List<String> chartsToDisplay;

  @override
  void initState() {
    chartData = widget.chartData;
    chartsToDisplay = widget.chartsToDisplay;

    chartData.calculateMinMaxAvg();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Graph Details",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: chartsToDisplay.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                ForecastIcons.info_circled,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
              title: Text(
                chartData
                    .getValueAtIndex(0)
                    .returnValue(chartsToDisplay[index])
                    .getDisplayName(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text(
                "Avg: ${chartData.getMinMaxAvg(chartsToDisplay[index], "avg")} | Min: ${chartData.getMinMaxAvg(chartsToDisplay[index], "min")} | Max: ${chartData.getMinMaxAvg(chartsToDisplay[index], "max")}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          },
        ));
  }
}
