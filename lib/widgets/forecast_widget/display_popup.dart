import 'package:flutter/material.dart';

import 'package:weatherapp3/utils/data.dart';

class WideForecastPopup extends StatelessWidget {
  final Map forecast;
  final Map measurementInfo;
  final String forecastDate;
  final CurrentDataSlice latestData;

  const WideForecastPopup(
      {Key? key,
      required this.forecast,
      required this.forecastDate,
      required this.latestData,
      required this.measurementInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              forecast["displayTime"],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              forecastDate,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  forecast["W"],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          forecast["F"],
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "°C",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                    Text(
                      "Feels Like",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Humidity",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["H"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          measurementInfo["H"]["units"],
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Wind Direction",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["D"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Precipitation",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["Pp"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          measurementInfo["Pp"]["units"],
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Wind Gust",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["G"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          measurementInfo["G"]["units"],
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Max UV Index",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["U"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 16) / 4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Wind Speed",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          forecast["S"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          measurementInfo["S"]["units"],
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 16) / 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Visibility",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            forecast["V"],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            measurementInfo["V"]["units"],
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 16) / 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Temperature",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            forecast["T"],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "°",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                measurementInfo["T"]["units"],
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
