// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// App Imports
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/widgets/forecast_widget/forecast_widget_v2.dart';
import 'package:weatherapp3/utils/data.dart';

class ForecastPage extends StatefulWidget {
  final CurrentDataSlice latestData;

  const ForecastPage({Key? key, required this.latestData}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late CurrentDataSlice _latestData;

  Map<int, List<Widget>> widgetList = {};
  int? _value = 0;

  @override
  void initState() {
    _latestData = widget.latestData;
    createPages();

    super.initState();
  }

  createPages() {
    int i = 0;
    for (var day in _latestData.returnForecasts()) {
      List<Widget> temp = [];
      for (var forecast in day.forecasts) {
        if (i == 0) {
          DateTime now = DateTime.now();
          DateFormat customTimeFormat = DateFormat("HH");
          int currentTime = int.parse(customTimeFormat.format(now));

          if ((forecast["time"] > currentTime) &&
              (_latestData.returnForecasts()[0].date ==
                  DateFormat("yyyy-MM-dd").format(DateTime.now()))) {
            temp.add(ForecastWidgetV2(forecast, _latestData.measurements,
                day.date, _latestData, false));
          }
        } else {
          temp.add(ForecastWidgetV2(
            forecast,
            _latestData.measurements,
            day.date,
            _latestData,
            false,
          ));
        }
      }
      if (temp.isEmpty) {
        Widget placeholder = const ListTile(
          title: Text(
            "No Relevant Forecast",
            textAlign: TextAlign.center,
          ),
        );
        temp.add(placeholder);
      } else {}

      widgetList[i] = temp;
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_latestData.loaded) {
      if (SystemInformation().getDisplaySize(context) == DisplaySize.portrait) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SingleChildScrollView(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            children: List<Widget>.generate(
                              _latestData.returnForecasts().length,
                              (int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: ChoiceChip(
                                    visualDensity: const VisualDensity(
                                        horizontal: 1, vertical: 1),
                                    selectedColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    label: Text(
                                      _latestData
                                          .returnForecasts()[index]
                                          .shortDate(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ),
                                    selected: _value == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _value = selected ? index : null;
                                      });
                                    },
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  children: widgetList[_value] ?? [],
                ),
              )
            ]));
      } else if (SystemInformation().getDisplaySize(context) ==
          DisplaySize.landscape) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(
                _latestData.returnForecasts().length,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Card(
                      elevation: 2,
                      child: SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            primary: false,
                            child: Column(
                              children: [
                                Text(
                                  _latestData
                                      .returnForecasts()[index]
                                      .shortDate(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                ...?widgetList[index],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      }
    } else {
      return const Text("Data Error");
    }
    return const Text("Data Error");
  }
}
