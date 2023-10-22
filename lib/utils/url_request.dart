import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/utils/settings.dart';

dynamic urlRequest(String url, int timeout) async {
  Response response;

  try {
    response = await get(Uri.parse(url)).timeout(Duration(seconds: timeout),
        onTimeout: () {
      return Response("Error", 408);
    }).catchError((error) {
      debugPrint(error.toString());
      return Response("Error", 408);
    });
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return false;
  }
}

dynamic apiRequest(String request, int timeout) async {
  String url = "http://${platformInfo.serverToUse}$request";

  return urlRequest(url, timeout);
}

dynamic ping(String host) async {
  host = "http://$host" "/api/v2/generate_204.php";

  bool output = false;

  Response response;

  try {
    response = await get(Uri.parse(host)).timeout(const Duration(seconds: 5),
        onTimeout: () {
      return Response("Error", 408);
    }).catchError((error) {
      debugPrint(error.toString());
      return Response("Error", 408);
    });
  } catch (error) {
    debugPrint(error.toString());
    response = Response("Error", 408);
  }

  if (response.statusCode == 204) {
    output = true;
  }

  return output;
}

dynamic pickServer() async {
  Settings settings = Settings();

  dynamic serverToUse = 0; // 1 = Server 1, 2 = Server 2, 0 = None

  if (await ping(settings.getSetting("serverOne", String)) == true) {
    serverToUse = settings.getSetting("serverOne", String);
  } else if (await ping(settings.getSetting("serverTwo", String)) == true) {
    serverToUse = settings.getSetting("serverTwo", String);
  } else {
    serverToUse = 0;
  }

  return serverToUse;
}
