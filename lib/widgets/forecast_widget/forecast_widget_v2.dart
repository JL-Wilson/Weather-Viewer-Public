import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/widgets/forecast_widget/display_popup.dart';
import 'package:weatherapp3/widgets/forecast_widget/phone_popup.dart';

class ForecastWidgetV2 extends StatelessWidget {
  late final Map forecast;
  late final Map measurementInfo;
  late final String forecastDate;
  late final CurrentDataSlice latestData;
  late final bool dateEnabled;

  ForecastWidgetV2(
      forecastData, measurements, date, currentData, this.dateEnabled,
      {Key? key})
      : super(key: key) {
    forecast = forecastData;
    measurementInfo = measurements;
    latestData = currentData;
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
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (latestData.loaded) {
                if (SystemInformation().getDisplaySize(context) ==
                    DisplaySize.portrait) {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) => PhoneForecastPopup(
                          forecast: forecast,
                          forecastDate: forecastDate,
                          latestData: latestData,
                          measurementInfo: measurementInfo));
                } else if (SystemInformation().getDisplaySize(context) ==
                    DisplaySize.landscape) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return WideForecastPopup(
                          measurementInfo: measurementInfo,
                          forecastDate: forecastDate,
                          forecast: forecast,
                          latestData: latestData,
                        );
                      });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "°" +
                                              latestData
                                                  .measurements["F"]!["units"]!,
                                          // "°" + findMeasurementInfo("F", "units", measurementInfo),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Feels Like",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
            ),
          ),
        ),
      ),
    );
  }
}
