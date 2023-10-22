// Imports of third party packages
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/platform_type.dart';

class TemperatureChartIcon extends StatefulWidget {
  final Function buildChart;

  const TemperatureChartIcon({Key? key, required this.buildChart})
      : super(key: key);

  @override
  State<TemperatureChartIcon> createState() => _TemperatureChartIconState();
}

class _TemperatureChartIconState extends State<TemperatureChartIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          widget.buildChart(["category", "temperature"]);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: SystemInformation().getDisplaySize(context) ==
                  DisplaySize.portrait
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.onPrimary,
          child: Icon(
            ForecastIcons.thermometer,
            size: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class HumidityChartIcon extends StatefulWidget {
  final Function buildChart;

  const HumidityChartIcon({Key? key, required this.buildChart})
      : super(key: key);

  @override
  State<HumidityChartIcon> createState() => _HumidityChartIconState();
}

class _HumidityChartIconState extends State<HumidityChartIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          widget.buildChart(["category", "humidity"]);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: SystemInformation().getDisplaySize(context) ==
                  DisplaySize.portrait
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.onPrimary,
          child: Icon(
            ForecastIcons.percent,
            size: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class WindChartIcon extends StatefulWidget {
  final Function buildChart;

  const WindChartIcon({Key? key, required this.buildChart}) : super(key: key);

  @override
  State<WindChartIcon> createState() => _WindChartIconState();
}

class _WindChartIconState extends State<WindChartIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          widget.buildChart(["category", "wind"]);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: SystemInformation().getDisplaySize(context) ==
                  DisplaySize.portrait
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.onPrimary,
          child: Icon(
            ForecastIcons.windy,
            size: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class OtherChartIcon extends StatefulWidget {
  final Function buildChart;

  const OtherChartIcon({Key? key, required this.buildChart}) : super(key: key);

  @override
  State<OtherChartIcon> createState() => _OtherChartIconState();
}

class _OtherChartIconState extends State<OtherChartIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          widget.buildChart(["category", "other"]);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: SystemInformation().getDisplaySize(context) ==
                  DisplaySize.portrait
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.onPrimary,
          child: Icon(
            ForecastIcons.guage,
            size: 25,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
