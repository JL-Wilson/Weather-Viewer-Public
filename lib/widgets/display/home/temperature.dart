import 'package:flutter/material.dart';

import 'package:weatherapp3/config/text_info.dart';
import 'package:weatherapp3/utils/data.dart';

class TemperatureDisplayWidget extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Function viewChart;

  const TemperatureDisplayWidget(
      {Key? key, required this.latestData, required this.viewChart})
      : super(key: key);

  @override
  State<TemperatureDisplayWidget> createState() =>
      _TemperatureDisplayWidgetState();
}

class _TemperatureDisplayWidgetState extends State<TemperatureDisplayWidget> {
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
                      "Temperature",
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
                            var categories = ["gTemp"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData
                                    .returnValue("gTemp")
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestData
                                        .returnValue("gTemp")
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
                                    latestData.returnValue("gTemp").getUnits(),
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
                    Expanded(
                      flex: 1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onLongPress: () {
                            var categories = ["feelsLike"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData
                                    .returnValue("feelsLike")
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestData
                                        .returnValue("feelsLike")
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
                                        .returnValue("feelsLike")
                                        .getUnits(),
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
                            var categories = ["srTemp"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData
                                    .returnValue("srTemp")
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestData
                                        .returnValue("srTemp")
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
                                    latestData.returnValue("srTemp").getUnits(),
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
                    Expanded(
                      flex: 1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onLongPress: () {
                            var categories = ["driveTemp"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData
                                    .returnValue("driveTemp")
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestData
                                        .returnValue("driveTemp")
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
                                        .returnValue("driveTemp")
                                        .getUnits(),
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
