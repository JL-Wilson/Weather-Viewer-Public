import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/utils/url_request.dart';

enum SelectedMap { rainfall, temperature }

class MapInfo {
  Map<SelectedMap, String> measurements = {
    SelectedMap.rainfall: "rainfall",
    SelectedMap.temperature: "temperature"
  };
  late Map<SelectedMap, int> sliderMax;
  late Map<SelectedMap, int> sliderMin;
  late DateTime modelTime;
  late int timeOffset;

  bool setupComplete = false;

  late int startingMapImage;

  refresh() async {
    dynamic mapInfo = await urlRequest(
        "http://${platformInfo.serverToUse}/api/v2/request/maps/info.txt", 5);

    if (mapInfo != false) {
      List info = mapInfo.toString().split("/");

      DateTime currentTime = DateTime.now();
      DateTime modelTime = DateTime.parse(info[0].toString().split(":")[0]);

      modelTime = DateTime.parse(info[0].toString().split(":")[0])
          .add(Duration(hours: int.parse(info[0].toString().split(":")[1])));

      Duration timeDifference = currentTime.difference(modelTime);

      sliderMin = {};

      this.modelTime = modelTime;
      timeOffset = timeDifference.inHours;

      for (var i = 0; i < measurements.length; i++) {
        sliderMin[measurements.keys.toList()[i]] = timeDifference.inHours;
      }

      sliderMax = {};

      for (var i = 0; i < measurements.length; i++) {
        sliderMax[measurements.keys.toList()[i]] = (int.parse(info[1 + i]));
      }

      startingMapImage = (1 + timeDifference.inHours);

      setupComplete = true;

      return true;
    } else {
      return false;
    }
  }
}
