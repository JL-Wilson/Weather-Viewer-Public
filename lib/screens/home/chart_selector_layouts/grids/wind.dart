// Imports of third party packages
import 'package:flutter/material.dart';

class WindGrid extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const WindGrid(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<WindGrid> createState() => _WindGridState();
}

class _WindGridState extends State<WindGrid> {
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
                  value: widget.returnMeasurementSelectStatus("wsp"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("wsp", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus(
                          "wsp", !widget.returnMeasurementSelectStatus("wsp"));
                    });
                  },
                  child: Text(
                    "Average",
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
                  value: widget.returnMeasurementSelectStatus("gust"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("gust", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("gust",
                          !widget.returnMeasurementSelectStatus("gust"));
                    });
                  },
                  child: Text(
                    "Gust",
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
