import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/data.dart';

class PhoneForecastPopup extends StatelessWidget {
  final Map forecast;
  final Map measurementInfo;
  final String forecastDate;
  final CurrentDataSlice latestData;

  const PhoneForecastPopup(
      {Key? key,
      required this.forecast,
      required this.forecastDate,
      required this.latestData,
      required this.measurementInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            forecast["displayTime"],
            style: Theme.of(context).textTheme.displayMedium!,
            textAlign: TextAlign.center,
          ),
          Text(
            forecastDate,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                forecast["W"],
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forecast["F"],
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        "°C",
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                  Text(
                    "Feels Like",
                    style: Theme.of(context).textTheme.labelLarge,
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
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Humidity",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["H"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        measurementInfo["H"]["units"],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Wind Direction",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["D"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Precipitation",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["Pp"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        measurementInfo["Pp"]["units"],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Wind Gust",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["G"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        measurementInfo["G"]["units"],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Max UV Index",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["U"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Wind Speed",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["S"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        measurementInfo["S"]["units"],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Visibility",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["V"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        measurementInfo["V"]["units"],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperature",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        forecast["T"],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "°",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            measurementInfo["T"]["units"],
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 16) / 3,
              )
            ],
          ),
        ],
      ),
    );
  }
}
