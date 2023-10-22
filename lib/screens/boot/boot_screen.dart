// Imports of third party packages
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// App Imports
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/screens/loading/data_fetch_screen.dart';
import 'package:weatherapp3/screens/settings/boot_settings.dart';
import 'package:weatherapp3/screens/static/error_page.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/utils/url_request.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/screens/boot/login_page.dart';

class BootPage extends StatefulWidget {
  const BootPage({Key? key}) : super(key: key);

  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  final CurrentDataSlice latestData = CurrentDataSlice();
  String actionMessage = "Loading...";

  @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    actionMessage = "Checking connection...";

    if (await pingServers()) {
      actionMessage = "Authenticating";
      if (!kIsWeb) {
        if (Platform.isAndroid && !kDebugMode) {
          Future.delayed(Duration.zero, () {
            initializeFirebase();
          });
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => RefreshPage(
                        latestData: latestData,
                        pageToDisplay: 0,
                      )),
              (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (context) => RefreshPage(
                      latestData: latestData,
                      pageToDisplay: 0,
                    )),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (context) => ErrorPage(
                    errorCode: 2.toString(),
                    errorMessage: "Can't reach API",
                  )),
          (route) => false);
    }
  }

  pingServers() async {
    dynamic pickServerResult = await pickServer();

    if (pickServerResult != 0) {
      platformInfo.setServer(pickServerResult.toString());
      if (await urlRequest("https://www.metoffice.gov.uk/", 5) != false) {
        latestData.forecastAvailable = true; // Don't try and load forecast
      }
      return true;
    }
    return false;
  }

  initializeFirebase() async {
    User? tempUser = FirebaseAuth.instance.currentUser;

    tempUser?.reload();
    tempUser = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((tempUser) {
      if (tempUser != null) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => RefreshPage(
                        latestData: latestData,
                        pageToDisplay: 0,
                      )),
              (route) => false);
        }
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => LoginPage(
                        latestData: latestData,
                      )),
              (route) => false);
        }
      }
    });
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
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const BootSettings()),
                  ).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const BootPage()),
                      (route) => false));
                },
                child: Icon(
                  ForecastIcons.cog,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(actionMessage),
              ],
            )),
          ],
        ));
  }
}
