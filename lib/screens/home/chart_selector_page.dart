// Imports of third party packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// App Imports
import 'package:weatherapp3/screens/home/chart_selector_layouts/measurement_selection.dart';
import 'package:weatherapp3/utils/inputs/number_input_display.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/inputs/number_input_normal.dart';
import 'package:weatherapp3/screens/charts/chart_page.dart';

enum SelectedPage { within, range }

class ChartSelectorPage extends StatefulWidget {
  final Settings settings;

  const ChartSelectorPage({Key? key, required this.settings}) : super(key: key);

  @override
  State<ChartSelectorPage> createState() => _ChartSelectorPageState();
}

class _ChartSelectorPageState extends State<ChartSelectorPage> {
  late final Settings settings;

  // The controller for the time period text entry in the "within" selection for charts
  final TextEditingController _chartWithinController = TextEditingController()
    ..text = (24).toString();

  // Holds the dates and times for the chart "range" selection
  final Map<String, TextEditingController> _chartRangeControllers = {
    "startDate": TextEditingController()
      ..text = standardDateFormat
          .format(DateTime.now().subtract(const Duration(days: 1)))
          .toString(),
    "startTime": TextEditingController()
      ..text = standardTimeFormat.format(DateTime.now()).toString(),
    "endDate": TextEditingController()
      ..text = standardDateFormat.format(DateTime.now()).toString(),
    "endTime": TextEditingController()
      ..text = standardTimeFormat.format(DateTime.now()).toString(),
  };

  final Map<String, bool> _chartMeasurementSelectStatus = {
    "gTemp": true,
    "feelsLike": false,
    "oHumid": false,
    "wsp": false,
    "gust": false,
    "atpres": false,
    "rain": false,
    "srTemp": false,
    "atticTemp": false,
    "garageTemp": false,
    "driveTemp": false,
  };

  int _selectedTrendline = 6;

  final Map _trendlineSelection = {
    0: TrendlineType.linear,
    1: TrendlineType.exponential,
    2: TrendlineType.power,
    3: TrendlineType.logarithmic,
    4: TrendlineType.polynomial,
    5: TrendlineType.movingAverage,
    6: Null,
  };

  int _currentchartInputValue = 0;

  @override
  void initState() {
    settings = widget.settings;

    super.initState();
  }

  // This is called when the user wants to select a new date or time for the chart page
  void setchartPeriod(type, controller) async {
    if (type == "date") {
      var selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1, 1),
        lastDate: DateTime.now(),
      );
      if (selected != null) {
        setState(() {
          controller.text = (standardDateFormat.format(selected)).toString();
        });
      }
    } else if (type == "time") {
      var selected = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (selected != null) {
        setState(() {
          var df = DateFormat("HH:mm");
          var dt = df.parse(selected.format(context));
          var finalTime = DateFormat("HH:mm").format(dt);
          controller.text = finalTime;
        });
      }
    }
  }

  bool returnMeasurementSelectStatus(String measurement) {
    return _chartMeasurementSelectStatus[measurement]!;
  }

  bool setMeasurementSelectStatus(String measurement, bool value) {
    _chartMeasurementSelectStatus[measurement] = value;
    return true;
  }

  // When the user holds down on a category all of the values will be inverted from their current state
  void toggleGroup(measurement) {
    if (measurement == "temperature") {
      _chartMeasurementSelectStatus["gTemp"] =
          !(_chartMeasurementSelectStatus["gTemp"] ?? false);
      _chartMeasurementSelectStatus["feelsLike"] =
          !(_chartMeasurementSelectStatus["feelsLike"] ?? false);
      _chartMeasurementSelectStatus["srTemp"] =
          !(_chartMeasurementSelectStatus["srTemp"] ?? false);
      _chartMeasurementSelectStatus["atticTemp"] =
          !(_chartMeasurementSelectStatus["atticTemp"] ?? false);
      _chartMeasurementSelectStatus["garageTemp"] =
          !(_chartMeasurementSelectStatus["garageTemp"] ?? false);
      _chartMeasurementSelectStatus["driveTemp"] =
          !(_chartMeasurementSelectStatus["driveTemp"] ?? false);
    } else if (measurement == "humidity") {
      _chartMeasurementSelectStatus["oHumid"] =
          !(_chartMeasurementSelectStatus["oHumid"] ?? false);
    } else if (measurement == "wind") {
      _chartMeasurementSelectStatus["wsp"] =
          !(_chartMeasurementSelectStatus["wsp"] ?? false);
      _chartMeasurementSelectStatus["gust"] =
          !(_chartMeasurementSelectStatus["gust"] ?? false);
    } else if (measurement == "pressure") {
      _chartMeasurementSelectStatus["atpres"] =
          !(_chartMeasurementSelectStatus["atpres"] ?? false);
    } else if (measurement == "rain") {
      _chartMeasurementSelectStatus["rain"] =
          !(_chartMeasurementSelectStatus["rain"] ?? false);
    }

    setState(() {});
  }

  // Create the chart and navigate to the display page
  void buildChart(parameters) async {
    List<String> chartsToDisplay = [];
    // The length changes based on which type is used
    String type = parameters[0];

    if (type == "default") {
      _chartMeasurementSelectStatus.forEach((key, value) {
        if (value == true) {
          chartsToDisplay.add(key);
        }
      });
    } else if (type == "category") {
      String category = parameters[1];
      for (String key in measurementCategories[category] ?? []) {
        if (_chartMeasurementSelectStatus[key] == true) {
          chartsToDisplay.add(key);
        }
      }
    }

    DataCollection chartCollection;
    String fetchURL;

    // If you are using the "within" selection
    if (selectedTimeSelection == SelectedPage.within) {
      // Get the number of hours or days
      String time = _chartWithinController.text;
      String units;

      // Get the units
      if (_currentchartInputValue == 0) {
        units = "hours";
      } else {
        units = "days";
      }

      // Format the request to the API
      fetchURL =
          "/api/v2/request/within.php?&passkey=$dataPasskey&units=$units&number=$time";
    } else if (selectedTimeSelection == SelectedPage.range) {
      // Combine the date and time to give start datetime and end datetime
      String startDate =
          "${_chartRangeControllers["startDate"]!.text} ${_chartRangeControllers["startTime"]!.text}";
      String endDate =
          "${_chartRangeControllers["endDate"]!.text} ${_chartRangeControllers["endTime"]!.text}";

      fetchURL =
          "/api/v2/request/range.php?&passkey=$dataPasskey&start_datetime=$startDate&end_datetime=$endDate";
    } else {
      fetchURL =
          "/api/v2/request/within.php?passkey=$dataPasskey&units=hours&number=12";
    }

    Map<String, dynamic> chartSettings = {
      "trendline": _trendlineSelection[_selectedTrendline],
      "trendlineColour": Theme.of(context).colorScheme.primary
    };

    // Create the collection and fetch the data
    chartCollection = DataCollection(fetchURL);

    // Navigate to the viewing page
    if (mounted) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => ChartPage(
                    chartsToDisplay: chartsToDisplay,
                    chartType: "chartPage",
                    chartData: chartCollection,
                    chartSettings: chartSettings,
                    settings: settings,
                  )));
    }
  }

  enterWithinNumber() async {
    _chartWithinController.text = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (SystemInformation().getAppType(context) == AppType.display) {
            return AlertDialog(
              scrollable: true,
              content: NumberInputDisplay(
                startingValue: _chartWithinController.text,
              ),
            );
          } else {
            return AlertDialog(
              scrollable: true,
              content: NumberInput(
                startingValue: _chartWithinController.text,
              ),
            );
          }
        });
  }

  dateInputWidth() {
    if (SystemInformation().getAppType(context) == AppType.mobile) {
      return 150.toDouble();
    } else {
      return 115.toDouble();
    }
  }

  SelectedPage selectedTimeSelection = SelectedPage.within;

  @override
  Widget build(BuildContext context) {
    Map<SelectedPage, Widget> selectionSystem = {
      //WITHIN SYSTEM
      SelectedPage.within: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SystemInformation().getDisplaySize(context) ==
                            DisplaySize.portrait
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.onPrimary),
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    controller: _chartWithinController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      enterWithinNumber();
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: 0,
                        groupValue: _currentchartInputValue,
                        onChanged: (value) {
                          setState(() {
                            _currentchartInputValue =
                                int.parse(value.toString());
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentchartInputValue = 0;
                          });
                        },
                        child: Text(
                          "Hours",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: 1,
                        groupValue: _currentchartInputValue,
                        onChanged: (value) {
                          setState(() {
                            _currentchartInputValue =
                                int.parse(value.toString());
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentchartInputValue = 1;
                          });
                        },
                        child: Text(
                          "Days",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),

      // RANGE system
      SelectedPage.range: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: SystemInformation().getDisplaySize(context) ==
                                DisplaySize.portrait
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context).colorScheme.onPrimary),
                    child: SizedBox(
                      width: dateInputWidth(),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).colorScheme.primary,
                          child: TextField(
                            controller: _chartRangeControllers["startDate"],
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                labelText: "Start Date",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                border: InputBorder.none),
                            style: Theme.of(context).textTheme.titleMedium,
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                setchartPeriod("date",
                                    _chartRangeControllers["startDate"]);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SystemInformation().getDisplaySize(context) ==
                              DisplaySize.portrait
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context).colorScheme.onPrimary),
                  child: SizedBox(
                    width: 80,
                    child: TextField(
                      controller: _chartRangeControllers["startTime"],
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: "Start Time",
                        border: InputBorder.none,
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          setchartPeriod(
                              "time", _chartRangeControllers["startTime"]);
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SystemInformation().getDisplaySize(context) ==
                              DisplaySize.portrait
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context).colorScheme.onPrimary),
                  child: SizedBox(
                    width: dateInputWidth(),
                    child: TextField(
                      controller: _chartRangeControllers["endDate"],
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: "End Date",
                        border: InputBorder.none,
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          setchartPeriod(
                              "date", _chartRangeControllers["endDate"]);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: SystemInformation().getDisplaySize(context) ==
                                DisplaySize.portrait
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context).colorScheme.onPrimary),
                    child: SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _chartRangeControllers["endTime"],
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: "End Time",
                          border: InputBorder.none,
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                        readOnly: true,
                        onTap: () {
                          setState(() {
                            setchartPeriod(
                                "time", _chartRangeControllers["endTime"]);
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    };

    Column timeSelection = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SystemInformation().getDisplaySize(context) ==
                        DisplaySize.portrait
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Select Time Period: ",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SegmentedButton(
                        segments: const [
                          ButtonSegment(
                              value: SelectedPage.within,
                              label: Text("Within")),
                          ButtonSegment(
                              value: SelectedPage.range, label: Text("Range"))
                        ],
                        selected: <SelectedPage>{selectedTimeSelection},
                        onSelectionChanged: (Set<SelectedPage> newSelection) {
                          setState(() {
                            selectedTimeSelection = newSelection.first;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: selectionSystem[selectedTimeSelection],
                      ),
                    ],
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: SystemInformation().getDisplaySize(context) ==
                      DisplaySize.portrait
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    buildChart(["default"]);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              "Create Chart",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      // color: Theme.of(context).colorScheme.onPrimaryContainer
                                      color: SystemInformation()
                                                  .getDisplaySize(context) ==
                                              DisplaySize.portrait
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                            ),
                          ),
                          Icon(
                            ForecastIcons.right_open_big,
                            color:
                                SystemInformation().getDisplaySize(context) ==
                                        DisplaySize.portrait
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );

    Widget experimentalFeatures = Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: SystemInformation().getDisplaySize(context) ==
                  DisplaySize.portrait
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Experimental Features",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trend Line",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.left,
                  ),
                  DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        _selectedTrendline = int.parse(value.toString());
                      });
                    },
                    value: _selectedTrendline,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text(
                          "Linear",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          "Exponential",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          "Power",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text(
                          "Logarithmic",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text(
                          "Polynomial",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 5,
                        child: Text(
                          "Moving Average",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 6,
                        child: Text(
                          "None",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (SystemInformation().getAppType(context) == AppType.display) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: DisplayMeasurementSelector(
                    buildChart: buildChart,
                    setMeasurementSelectStatus: setMeasurementSelectStatus,
                    returnMeasurementSelectStatus:
                        returnMeasurementSelectStatus,
                    toggleGroup: toggleGroup,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  timeSelection,
                  settings.getSetting("experimentalFeatures", bool) == false
                      ? Container()
                      : experimentalFeatures,
                ],
              ),
            ),
          )
        ],
      );
    } else if (SystemInformation().getDisplaySize(context) ==
        DisplaySize.landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: false,
              child: NormalMeasurementSelector(
                buildChart: buildChart,
                setMeasurementSelectStatus: setMeasurementSelectStatus,
                returnMeasurementSelectStatus: returnMeasurementSelectStatus,
                toggleGroup: toggleGroup,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  timeSelection,
                  settings.getSetting("experimentalFeatures", bool) == false
                      ? Container()
                      : experimentalFeatures,
                ],
              ),
            ),
          )
        ],
      );
    } else if (SystemInformation().getDisplaySize(context) ==
        DisplaySize.portrait) {
      return SingleChildScrollView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            timeSelection,
            NormalMeasurementSelector(
              buildChart: buildChart,
              setMeasurementSelectStatus: setMeasurementSelectStatus,
              returnMeasurementSelectStatus: returnMeasurementSelectStatus,
              toggleGroup: toggleGroup,
            ),
            settings.getSetting("experimentalFeatures", bool) == false
                ? Container()
                : experimentalFeatures,
          ],
        ),
      );
    } else {
      return const Text("ERROR");
    }
  }
}
