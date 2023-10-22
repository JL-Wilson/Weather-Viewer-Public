// Imports of third party packages
import 'package:flutter/material.dart';

class TemperatureGrid extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const TemperatureGrid(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<TemperatureGrid> createState() => _TemperatureGridState();
}

class _TemperatureGridState extends State<TemperatureGrid> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("gTemp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("gTemp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("gTemp",
                          !widget.returnMeasurementSelectStatus("gTemp"));
                    });
                  },
                  child: Text(
                    "Outdoors",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("srTemp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("srTemp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("srTemp",
                          !widget.returnMeasurementSelectStatus("srTemp"));
                    });
                  },
                  child: Text(
                    "Indoors",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("garageTemp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("garageTemp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("garageTemp",
                          !widget.returnMeasurementSelectStatus("garageTemp"));
                    });
                  },
                  child: Text(
                    "Garage",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("feelsLike"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("feelsLike", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("feelsLike",
                          !widget.returnMeasurementSelectStatus("feelsLike"));
                    });
                  },
                  child: Text(
                    "Feels Like",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("driveTemp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("driveTemp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("driveTemp",
                          !widget.returnMeasurementSelectStatus("driveTemp"));
                    });
                  },
                  child: Text(
                    "Drive",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("atticTemp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("atticTemp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("atticTemp",
                          !widget.returnMeasurementSelectStatus("atticTemp"));
                    });
                  },
                  child: Text(
                    "Attic",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
