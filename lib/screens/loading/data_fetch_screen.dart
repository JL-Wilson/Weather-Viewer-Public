// Imports of third party packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// App Imports
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/screens/home/home_page.dart';
import 'package:weatherapp3/screens/static/error_page.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/home_screen_chart.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class RefreshPage extends StatefulWidget {
  final CurrentDataSlice latestData;
  final int pageToDisplay;

  const RefreshPage(
      {Key? key, required this.latestData, required this.pageToDisplay})
      : super(key: key);

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  late CurrentDataSlice latestData;
  late int pageToDisplay;

  final Settings _settings = Settings();

  @override
  void initState() {
    latestData = widget.latestData;
    pageToDisplay = widget.pageToDisplay;

    super.initState();

    main();
  }

  void main() async {
    dynamic refreshResponse = await refreshData(latestData, _settings);

    if (refreshResponse != false) {
      CurrentDataSlice latestData = refreshResponse[0];
      DataCollection homeChartCollection = refreshResponse[1];
      DataCollection rainComparisonCollection = refreshResponse[2];

      createWidgets(latestData, homeChartCollection, rainComparisonCollection);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (context) => HomePage(
                      latestData: latestData,
                      pageToDisplay: pageToDisplay,
                    )),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (context) => ErrorPage(
                    errorCode: 1.toString(),
                    errorMessage: "Error collecting data",
                  )),
          (route) => false);
    }
  }

  createWidgets(CurrentDataSlice latestData, DataCollection homeChartCollection,
      DataCollection rainComparisonCollection) {
    dynamic oldestValue = Null;

    if (_settings.getSetting("rainComparisonPeriod", int) == 0) {
      oldestValue = rainComparisonCollection
          .getLatestSlice()
          .returnValue("rain")
          .getValue();
    } else if (_settings.getSetting("rainComparisonPeriod", int) == 1) {
      oldestValue = rainComparisonCollection
          .getOldestSlice()
          .returnValue("rain")
          .getValue();
    }

    dynamic latestValue = rainComparisonCollection
        .getLatestSlice()
        .returnValue("rain")
        .getValue();
    dynamic newestValue = latestData.returnValue("rain").getValue();

    if ((double.tryParse(oldestValue.toString()) != null) &&
        (double.tryParse(newestValue.toString()) != null) &&
        (double.tryParse(latestValue.toString()) != null)) {
      double newValue = double.parse(newestValue.toString());
      double oldValue = double.parse(oldestValue.toString());

      double difference = newValue - oldValue;

      if (difference > 0) {
        latestData.returnValue("rainChange").setValue(difference);
        if ((newValue - double.parse(latestValue.toString()) > 0) &&
            latestData.homepageMessageType != "error") {
          latestData.sethomepageMessage("It is raining");
        }
      } else {
        latestData.returnValue("rainChange").setValue(0);
      }
    } else {
      latestData.returnValue("rainChange").setValue("n/a");
    }

    latestData.homeChart = HomeScreenChart(
        homeChartCollection: homeChartCollection, settings: _settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            SystemInformation().getAppType(context) == AppType.display
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Phoenix.rebirth(context);
                    },
                    label: const Text('Reload'),
                  )
                : null,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Refreshing Data..."),
              ],
            )),
          ],
        ));
  }
}

// Return list in format [CurrentDataSlice, HomepageChartData]
refreshData(CurrentDataSlice latestData, Settings settings) async {
  latestData.loaded = false;

  // Re-fetches the data from the server
  await latestData.reload();

  // Collect the data used in the homepage chart
  DataCollection homeChartCollection = DataCollection(
      "/api/v2/request/within.php?passkey=$dataPasskey&units=hours&number=${settings.getSetting("homepageChartPeriod", int)}");
  DataCollection rainComparisonCollection = DataCollection(
      "/api/v2/request/within.php?&passkey=$dataPasskey&units=hours&number=${settings.getSetting("rainComparisonTimePeriod", int)}");

  if (await homeChartCollection.createCollection() &&
      await rainComparisonCollection.createCollection()) {
    latestData.loaded = true;
    return [latestData, homeChartCollection, rainComparisonCollection];
  } else {
    return false;
  }
}
