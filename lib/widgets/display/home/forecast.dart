import 'package:flutter/material.dart';

import 'package:weatherapp3/config/text_info.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/widgets/forecast_widget/display_popup.dart';
import 'package:weatherapp3/widgets/forecast_widget/phone_popup.dart';

class ForecastDisplayWidget extends StatefulWidget {
  final CurrentDataSlice latestData;
  final Function viewChart;

  const ForecastDisplayWidget(
      {Key? key, required this.latestData, required this.viewChart})
      : super(key: key);

  @override
  State<ForecastDisplayWidget> createState() => _ForecastDisplayWidgetState();
}

class _ForecastDisplayWidgetState extends State<ForecastDisplayWidget> {
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
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onLongPress: () {
          if (latestData.loaded) {
            if (SystemInformation().getDisplaySize(context) ==
                DisplaySize.portrait) {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  builder: (context) => PhoneForecastPopup(
                        measurementInfo: latestData.measurements,
                        forecastDate: latestData.nextForecast()["DD"],
                        forecast: latestData.nextForecast(),
                        latestData: latestData,
                      ));
            } else if (SystemInformation().getDisplaySize(context) ==
                DisplaySize.landscape) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WideForecastPopup(
                      measurementInfo: latestData.measurements,
                      forecastDate: latestData.nextForecast().date,
                      forecast: latestData.nextForecast(),
                      latestData: latestData,
                    );
                  });
            }
          }
        },
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
                        "Forecast",
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
                        child: Column(
                          children: [
                            Text(
                              "Outdoors",
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
                                  latestData.nextForecast()["T"].toString(),
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
                                  "°C",
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "Humidity",
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
                                  latestData.nextForecast()["H"].toString(),
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
                                  "%",
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
                              "Wind Speed",
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
                                  latestData.nextForecast()["S"].toString(),
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
                                  "mph",
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "Precipitation Chance",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  latestData.nextForecast()["Pp"].toString(),
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
                                  "%",
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
      ),
    );
  }
}
