// Imports of third party packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// App Imports
import 'package:weatherapp3/config/config_variables.dart';
import 'package:weatherapp3/utils/map_utils.dart';

class MapSliderWidget extends StatefulWidget {
  final double mapImage;
  final Function sliderUpdate;
  final DateTime modelTime;
  final Map<SelectedMap, int> sliderMax;
  final Map<SelectedMap, int> sliderMin;
  final int timeOffset;
  final SelectedMap selectedMap;

  const MapSliderWidget({
    Key? key,
    required this.mapImage,
    required this.sliderUpdate,
    required this.modelTime,
    required this.sliderMax,
    required this.sliderMin,
    required this.timeOffset,
    required this.selectedMap,
  }) : super(key: key);

  @override
  State<MapSliderWidget> createState() => _MapSliderWidgetState();
}

class _MapSliderWidgetState extends State<MapSliderWidget> {
  late double mapImage;
  late final Function sliderUpdate;
  late final DateTime modelTime;
  late Map<SelectedMap, int> sliderMax;
  late Map<SelectedMap, int> sliderMin;
  late final int timeOffset;
  late final SelectedMap selectedMap;

  @override
  void initState() {
    mapImage = widget.mapImage;
    sliderUpdate = widget.sliderUpdate;
    modelTime = widget.modelTime;
    sliderMax = widget.sliderMax;
    sliderMin = widget.sliderMin;
    timeOffset = widget.timeOffset;
    selectedMap = widget.selectedMap;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Model Time: ${standardDateTimeFormat.format(modelTime)}"),
                  action: SnackBarAction(
                    label: "Close",
                    onPressed: () {},
                  ),
                ));
              },
              child: Text(
                DateFormat("EEEE h:mm aaa")
                    .format(modelTime.add(Duration(hours: mapImage.toInt()))),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(),
            child: Slider(
              value: mapImage,
              onChanged: (value) {
                setState(() {
                  mapImage = value;
                });
                sliderUpdate(value);
              },
              divisions: (sliderMax[selectedMap]! - timeOffset) - 2,
              min: double.parse(sliderMin[selectedMap].toString()) + 1,
              max: double.parse(sliderMax[selectedMap].toString()) - 1,
            ),
          ),
        ],
      ),
    );
  }
}
