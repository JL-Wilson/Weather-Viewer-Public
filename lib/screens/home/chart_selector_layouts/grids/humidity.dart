// Imports of third party packages
import 'package:flutter/material.dart';

class HumidityGrid extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const HumidityGrid(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<HumidityGrid> createState() => _HumidityGridState();
}

class _HumidityGridState extends State<HumidityGrid> {
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
                  value: widget.returnMeasurementSelectStatus("oHumid"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("oHumid", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("oHumid",
                          !widget.returnMeasurementSelectStatus("oHumid"));
                    });
                  },
                  child: Text(
                    "Humidity",
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
