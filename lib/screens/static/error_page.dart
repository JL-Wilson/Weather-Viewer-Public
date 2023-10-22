import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:weatherapp3/screens/boot/boot_screen.dart';
import 'package:weatherapp3/screens/loading/shutdown_loading_screen.dart';
import 'package:weatherapp3/screens/settings/boot_settings.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';

class ErrorPage extends StatelessWidget {
  final String errorCode;
  final String errorMessage;

  const ErrorPage(
      {Key? key,
      this.errorCode = "n/a",
      this.errorMessage = "Sorry, something has gone wrong!"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.error,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.error,
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
                  color: Theme.of(context).colorScheme.onError,
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
                Icon(
                  ForecastIcons.attention,
                  color: Theme.of(context).colorScheme.onError,
                  size: 75,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  errorMessage,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onError),
                ),
                Text(
                  "Error Code: $errorCode",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onError),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.onError),
                        ),
                        onPressed: () {
                          Phoenix.rebirth(context);
                        },
                        child: Text(
                          "Reload",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.onError),
                        ),
                      ),
                      SystemInformation().getAppType(context) == AppType.display
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onError),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ShutdownLoadingPage()));
                                },
                                child: Text(
                                  "Shut Down",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
