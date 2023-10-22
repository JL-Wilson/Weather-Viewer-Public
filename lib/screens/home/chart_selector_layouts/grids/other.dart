// Imports of third party packages
import 'package:flutter/material.dart';

class OtherGrid extends StatefulWidget {
  final Function toggleGroup;
  final Function buildChart;
  final Function returnMeasurementSelectStatus;
  final Function setMeasurementSelectStatus;

  const OtherGrid(
      {Key? key,
      required this.toggleGroup,
      required this.buildChart,
      required this.returnMeasurementSelectStatus,
      required this.setMeasurementSelectStatus})
      : super(key: key);

  @override
  State<OtherGrid> createState() => _OtherGridState();
}

class _OtherGridState extends State<OtherGrid> {
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
                  value: widget.returnMeasurementSelectStatus("atpres"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("atpres", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("atpres",
                          !widget.returnMeasurementSelectStatus("atpres"));
                    });
                  },
                  child: Text(
                    "Pressure",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.returnMeasurementSelectStatus("rain"),
                  onChanged: (value) {
                    setState(() {
                      widget.setMeasurementSelectStatus("rain", value);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.setMeasurementSelectStatus("rain",
                          !widget.returnMeasurementSelectStatus("rain"));
                    });
                  },
                  child: Text(
                    "Rainfall",
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
