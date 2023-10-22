import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

import 'package:weatherapp3/main.dart';
import 'package:weatherapp3/screens/loading/shutdown_loading_screen.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/config/config_variables.dart';

class ApplicationDetails extends StatefulWidget {
  final CurrentDataSlice latestData;

  const ApplicationDetails({Key? key, required this.latestData})
      : super(key: key);

  @override
  State<ApplicationDetails> createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  shutdownDevice() async {
    var shell = Shell();
    await shell.run("sudo shutdown -h now");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                splashColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  showLicensePage(context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            SystemInformation().getAppName(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            SystemInformation().getAppType(context) ==
                                    AppType.display
                                ? "linux-display"
                                : "${SystemInformation().getOSString()}-$versionName-$versionCode",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface),
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Current Server",
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(platformInfo.serverToUse,
                            style: Theme.of(context).textTheme.labelLarge),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SystemInformation().getAppType(context) == AppType.display
              ? Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const ShutdownLoadingPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Shutdown",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onError),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
