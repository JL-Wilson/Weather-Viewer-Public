// Imports of third party packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/screens/forecast/forecast_detail.dart';
import 'package:weatherapp3/screens/forecast/widgets/next_forecast.dart';
import 'package:weatherapp3/screens/forecast/widgets/map_slider.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/map_utils.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/settings.dart';

class ForecastMapPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const ForecastMapPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<ForecastMapPage> createState() => _ForecastMapPageState();
}

class _ForecastMapPageState extends State<ForecastMapPage> {
  late Settings settings;
  late CurrentDataSlice latestData;

  TransformationController mapController = TransformationController();

  int time = 0;

  late String mapImageUrl;
  double mapImage = 0;

  List<List<int>> loadedImages = [[], []];

  bool setupComplete = false;

  SelectedMap selectedMap = SelectedMap.rainfall;

  @override
  void initState() {
    settings = widget.settings;
    latestData = widget.latestData;

    super.initState();

    initial();
  }

  void initial() async {
    if (await latestData.mapInfo.refresh()) {
      mapImage = double.parse(latestData.mapInfo.startingMapImage.toString());
      updateMapImage(latestData.mapInfo.startingMapImage);

      setupComplete = true;
    }
  }

  void viewFunctionPage() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ForecastPage(
                  latestData: latestData,
                )));
  }

  void sliderUpdate(value) {
    setState(() {
      mapImage = value;
    });

    time = value.toInt();
    updateMapImage(time);
  }

  void updateMapImage(number) async {
    mapImageUrl =
        "http://${platformInfo.serverToUse}/api/v2/request/maps/${latestData.mapInfo.measurements[selectedMap]}/$number.png";
    setState(() {});
  }

  Widget buildWideLayout() {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Forecast",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          elevation: 0,
        ),
        body: setupComplete && latestData.mapInfo.setupComplete
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: InteractiveViewer(
                              panEnabled: true,
                              trackpadScrollCausesScale: true,
                              boundaryMargin: const EdgeInsets.all(0),
                              minScale: 0.5,
                              maxScale: 10,
                              transformationController: mapController,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  mapImageUrl,
                                  gaplessPlayback: true,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text("Error Loading Image");
                                  },
                                ),
                              ))),
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SegmentedButton(
                            showSelectedIcon: false,
                            segments: const [
                              ButtonSegment(
                                  value: SelectedMap.rainfall,
                                  label: Text("Rainfall")),
                              ButtonSegment(
                                  value: SelectedMap.temperature,
                                  label: Text("Temperature")),
                            ],
                            selected: <SelectedMap>{selectedMap},
                            onSelectionChanged:
                                (Set<SelectedMap> newSelection) {
                              setState(() {
                                selectedMap = newSelection.first;
                              });
                              updateMapImage(time);
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: MapSliderWidget(
                              mapImage: mapImage,
                              sliderUpdate: sliderUpdate,
                              modelTime: latestData.mapInfo.modelTime,
                              sliderMax: latestData.mapInfo.sliderMax,
                              sliderMin: latestData.mapInfo.sliderMin,
                              timeOffset: latestData.mapInfo.timeOffset,
                              selectedMap: selectedMap,
                            )),
                        NextForecastDetailWidget(
                            forecast: latestData.nextForecast(),
                            measurementInfo: latestData.measurements,
                            date: latestData.nextForecast()["DD"],
                            latestData: latestData,
                            dateEnabled: true)
                      ],
                    ),
                  )),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget buildNormalLayout() {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Forecast",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          elevation: 0,
        ),
        body: setupComplete
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SegmentedButton(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                            value: SelectedMap.rainfall,
                            label: Text("Rainfall")),
                        ButtonSegment(
                            value: SelectedMap.temperature,
                            label: Text("Temperature")),
                      ],
                      selected: <SelectedMap>{selectedMap},
                      onSelectionChanged: (Set<SelectedMap> newSelection) {
                        setState(() {
                          selectedMap = newSelection.first;
                        });
                        updateMapImage(time);
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InteractiveViewer(
                            panEnabled: true,
                            trackpadScrollCausesScale: true,
                            boundaryMargin: const EdgeInsets.all(0),
                            minScale: 0.5,
                            maxScale: 10,
                            transformationController: mapController,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                mapImageUrl,
                                gaplessPlayback: true,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text("Error Loading Image");
                                },
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: MapSliderWidget(
                          mapImage: mapImage,
                          sliderUpdate: sliderUpdate,
                          modelTime: latestData.mapInfo.modelTime,
                          sliderMax: latestData.mapInfo.sliderMax,
                          sliderMin: latestData.mapInfo.sliderMin,
                          timeOffset: latestData.mapInfo.timeOffset,
                          selectedMap: selectedMap,
                        )),
                    NextForecastDetailWidget(
                        forecast: latestData.nextForecast(),
                        measurementInfo: latestData.measurements,
                        date: latestData.nextForecast()["DD"],
                        latestData: latestData,
                        dateEnabled: true)
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  @override
  Widget build(BuildContext context) {
    if (SystemInformation().getDisplaySize(context) == DisplaySize.landscape) {
      return buildWideLayout();
    } else {
      return buildNormalLayout();
    }
  }
}
