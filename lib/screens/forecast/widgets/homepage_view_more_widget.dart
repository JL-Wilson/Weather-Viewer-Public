// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// App Imports
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';

class HomepageViewMoreWidget extends StatelessWidget {
  late final Map forecast;
  late final Map measurementInfo;
  late final String forecastDate;
  late final CurrentDataSlice latestData;
  late final bool dateEnabled;
  late final Function clickFunction;

  HomepageViewMoreWidget(
      {Key? key,
      required this.forecast,
      required this.measurementInfo,
      required date,
      required this.latestData,
      required this.clickFunction,
      required this.dateEnabled})
      : super(key: key) {
    var temp = DateTime.parse(date);
    forecastDate = DateFormat.yMMMd().format(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: SystemInformation().getAppType(context) == AppType.display
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.onPrimary),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              clickFunction();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, right: 16, left: 8, bottom: 8),
                        child: Icon(
                          forecast["I"],
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 35,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forecast["displayTime"],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          dateEnabled
                              ? Text(
                                  forecastDate,
                                  style: Theme.of(context).textTheme.labelLarge,
                                )
                              : Container(),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              forecast["F"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text(
                                              "°${latestData.measurements["F"]!["units"]!}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Feels Like",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              forecast["Pp"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text(
                                              measurementInfo["Pp"]["units"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Precipitation",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SystemInformation().getAppType(context) == AppType.display
                      ? Divider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Container(),
                  SystemInformation().getAppType(context) == AppType.display
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "More Forecasts",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                ),
                              ),
                              Icon(
                                ForecastIcons.right_open_big,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                size: 15,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
