// Imports of third party packages
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/screens/home/chart_selector_layouts/grids/humidity.dart';
import 'package:weatherapp3/screens/home/chart_selector_layouts/grids/other.dart';
import 'package:weatherapp3/screens/home/chart_selector_layouts/grids/temperature.dart';
import 'package:weatherapp3/screens/home/chart_selector_layouts/grids/wind.dart';
import 'package:weatherapp3/screens/home/chart_selector_layouts/icons.dart';
import 'package:weatherapp3/utils/platform_type.dart';

class NormalMeasurementSelector extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const NormalMeasurementSelector(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<NormalMeasurementSelector> createState() =>
      _NormalMeasurementSelectorState();
}

class _NormalMeasurementSelectorState extends State<NormalMeasurementSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: SystemInformation().getDisplaySize(context) ==
                      DisplaySize.portrait
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 15),
                  child: Text(
                    "Select Measurements: ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onLongPress: () {
                        widget.toggleGroup("temperature");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TemperatureChartIcon(buildChart: widget.buildChart),
                          TemperatureGrid(
                            toggleGroup: widget.toggleGroup,
                            buildChart: widget.buildChart,
                            returnMeasurementSelectStatus:
                                widget.returnMeasurementSelectStatus,
                            setMeasurementSelectStatus:
                                widget.setMeasurementSelectStatus,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onLongPress: () {
                        widget.toggleGroup("humidity");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HumidityChartIcon(buildChart: widget.buildChart),
                          HumidityGrid(
                              toggleGroup: widget.toggleGroup,
                              buildChart: widget.buildChart,
                              returnMeasurementSelectStatus:
                                  widget.returnMeasurementSelectStatus,
                              setMeasurementSelectStatus:
                                  widget.setMeasurementSelectStatus),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onLongPress: () {
                        widget.toggleGroup("wind");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WindChartIcon(buildChart: widget.buildChart),
                          WindGrid(
                              toggleGroup: widget.toggleGroup,
                              buildChart: widget.buildChart,
                              returnMeasurementSelectStatus:
                                  widget.returnMeasurementSelectStatus,
                              setMeasurementSelectStatus:
                                  widget.setMeasurementSelectStatus),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onLongPress: () {
                        widget.toggleGroup("pressure");
                        widget.toggleGroup("rain");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OtherChartIcon(buildChart: widget.buildChart),
                          OtherGrid(
                              toggleGroup: widget.toggleGroup,
                              buildChart: widget.buildChart,
                              returnMeasurementSelectStatus:
                                  widget.returnMeasurementSelectStatus,
                              setMeasurementSelectStatus:
                                  widget.setMeasurementSelectStatus),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DisplayMeasurementSelector extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const DisplayMeasurementSelector(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<DisplayMeasurementSelector> createState() =>
      _DisplayMeasurementSelectorState();
}

class _DisplayMeasurementSelectorState
    extends State<DisplayMeasurementSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 15),
              child: Text(
                "Select Measurements: ",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),

        const Divider(
          indent: 10,
          endIndent: 10,
        ),

        // Temperature Select
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onLongPress: () {
            widget.toggleGroup("temperature");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TemperatureChartIcon(buildChart: widget.buildChart),
              TemperatureGrid(
                toggleGroup: widget.toggleGroup,
                buildChart: widget.buildChart,
                returnMeasurementSelectStatus:
                    widget.returnMeasurementSelectStatus,
                setMeasurementSelectStatus: widget.setMeasurementSelectStatus,
              ),
            ],
          ),
        ),

        const Divider(
          indent: 10,
          endIndent: 10,
        ),

        // Humidity Select
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onLongPress: () {
            widget.toggleGroup("humidity");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HumidityChartIcon(buildChart: widget.buildChart),
              HumidityGrid(
                  toggleGroup: widget.toggleGroup,
                  buildChart: widget.buildChart,
                  returnMeasurementSelectStatus:
                      widget.returnMeasurementSelectStatus,
                  setMeasurementSelectStatus:
                      widget.setMeasurementSelectStatus),
            ],
          ),
        ),

        const Divider(
          indent: 10,
          endIndent: 10,
        ),

        // Wind Select
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onLongPress: () {
            widget.toggleGroup("wind");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WindChartIcon(buildChart: widget.buildChart),
              WindGrid(
                  toggleGroup: widget.toggleGroup,
                  buildChart: widget.buildChart,
                  returnMeasurementSelectStatus:
                      widget.returnMeasurementSelectStatus,
                  setMeasurementSelectStatus:
                      widget.setMeasurementSelectStatus),
            ],
          ),
        ),

        const Divider(
          indent: 10,
          endIndent: 10,
        ),

        // Other Select
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onLongPress: () {
              widget.toggleGroup("pressure");
              widget.toggleGroup("rain");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OtherChartIcon(buildChart: widget.buildChart),
                OtherGrid(
                    toggleGroup: widget.toggleGroup,
                    buildChart: widget.buildChart,
                    returnMeasurementSelectStatus:
                        widget.returnMeasurementSelectStatus,
                    setMeasurementSelectStatus:
                        widget.setMeasurementSelectStatus),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
