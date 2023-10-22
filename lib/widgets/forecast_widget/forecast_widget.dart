import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/widgets/forecast_widget/display_popup.dart';
import 'package:weatherapp3/widgets/forecast_widget/phone_popup.dart';

class ForecastWidget extends StatelessWidget {
  late final Map forecast;
  late final Map measurementInfo;
  late final String forecastDate;
  late final CurrentDataSlice latestData;

  ForecastWidget(forecastData, measurements, date, currentData, {Key? key})
      : super(key: key) {
    forecast = forecastData;
    measurementInfo = measurements;
    latestData = currentData;
    var temp = DateTime.parse(date);
    forecastDate = DateFormat.yMMMd().format(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (latestData.loaded) {
            if (SystemInformation().getDisplaySize(context) ==
                DisplaySize.portrait) {
              showModalBottomSheet(
                  enableDrag: true,
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    forecast["displayTime"],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      Text(
                        forecast["F"],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "°${latestData.measurements["F"]!["units"]!}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        forecast["I"],
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 35,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
