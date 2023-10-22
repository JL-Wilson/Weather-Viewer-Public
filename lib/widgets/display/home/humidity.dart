import 'package:flutter/material.dart';

import 'package:weatherapp3/config/text_info.dart';
import 'package:weatherapp3/utils/data.dart';

class HumidityDisplayWidget extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Function viewChart;

  const HumidityDisplayWidget(
      {Key? key, required this.latestData, required this.viewChart})
      : super(key: key);

  @override
  State<HumidityDisplayWidget> createState() => _HumidityDisplayWidgetState();
}

class _HumidityDisplayWidgetState extends State<HumidityDisplayWidget> {
  late final CurrentDataSlice latestData;
  late final Function viewChart;

  @override
  void initState() {
    latestData = widget.latestData;
    viewChart = widget.viewChart;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "Humidity",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onLongPress: () {
                            var categories = ["oHumid"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData
                                    .returnValue("oHumid")
                                    .getDisplayName(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    latestData
                                        .returnValue("oHumid")
                                        .getValue()
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            fontWeight: bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                  Text(
                                    latestData
                                        .returnValue("oHumid")
                                        .getShortUnits(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
