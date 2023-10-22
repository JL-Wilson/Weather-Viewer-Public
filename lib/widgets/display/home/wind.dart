import 'package:flutter/material.dart';

import 'package:weatherapp3/config/text_info.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class WindDisplayWidget extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Function viewChart;
  final Settings settings;

  const WindDisplayWidget(
      {Key? key,
      required this.latestData,
      required this.viewChart,
      required this.settings})
      : super(key: key);

  @override
  State<WindDisplayWidget> createState() => _WindDisplayWidgetState();
}

class _WindDisplayWidgetState extends State<WindDisplayWidget> {
  late final CurrentDataSlice latestData;
  late final Function viewChart;
  late final Settings settings;

  @override
  void initState() {
    latestData = widget.latestData;
    viewChart = widget.viewChart;
    settings = widget.settings;

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
                      "Wind",
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
                            var categories = ["wsp"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData.returnValue("wsp").getDisplayName(),
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
                                        .returnValue("wsp")
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
                                    latestData.returnValue("wsp").getUnits(),
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
                            var categories = ["gust"];
                            viewChart(categories);
                          },
                          child: Column(
                            children: [
                              Text(
                                latestData.returnValue("gust").getDisplayName(),
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
                                        .returnValue("gust")
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
                                    latestData.returnValue("gust").getUnits(),
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
                      child: Column(
                        children: [
                          Text(
                            settings.getSetting("windDisplayType", int) == 0
                                ? latestData
                                    .returnValue("dlta")
                                    .getDisplayName()
                                : latestData
                                    .returnValue("wdir")
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
                                settings.getSetting("windDisplayType", int) == 0
                                    ? latestData
                                        .returnValue("dlta")
                                        .getValue()
                                        .toString()
                                    : latestData
                                        .returnValue("wdir")
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
                                settings.getSetting("windDisplayType", int) == 0
                                    ? latestData.returnValue("dlta").getUnits()
                                    : latestData.returnValue("wdir").getUnits(),
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
