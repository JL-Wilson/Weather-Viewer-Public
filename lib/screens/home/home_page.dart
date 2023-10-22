// Imports of third party packages
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// App Imports
import 'package:weatherapp3/screens/home/data_page.dart';
import 'package:weatherapp3/utils/platform_type.dart';
import 'package:weatherapp3/screens/loading/data_fetch_screen.dart';
import 'package:weatherapp3/screens/home/chart_selector_page.dart';
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/utils/settings.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/screens/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  final CurrentDataSlice latestData;
  final int pageToDisplay;

  const HomePage(
      {Key? key, required this.latestData, required this.pageToDisplay})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CurrentDataSlice latestData;

  final Settings _storage = Settings();
  late PageController _homepageController;
  int _currentIndex = 0;
  final bool _isStopped = false;
  bool isPaused = false;
  Orientation? previousOrientation;

  @override
  void initState() {
    latestData = widget.latestData;
    _currentIndex = widget.pageToDisplay;

    _homepageController = PageController(initialPage: _currentIndex);

    super.initState();
    loopTimer();
  }

  void loopTimer() {
    // Wait 5 minutes before repeating
    Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_isStopped) {
        timer.cancel();
      }
      if (!isPaused && mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (context) => RefreshPage(
                      latestData: latestData,
                      pageToDisplay: _currentIndex,
                    )),
            (route) => false);
      }
    });
  }

  void navigationBarTapped(int index) {
    int offset = 0;

    if (latestData.loaded) {
      if (index >= 0 && index <= 1 - offset) {
        setState(() {
          _currentIndex = index;
          _homepageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        });
      } else {
        if (index == 2 - offset) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => RefreshPage(
                        latestData: latestData,
                        pageToDisplay: _currentIndex,
                      )),
              (route) => false);
        } else if (index == 3 - offset) {
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => SettingsPage(
                      latestData: latestData,
                    )),
          ).then((value) => Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => RefreshPage(
                        latestData: latestData,
                        pageToDisplay: _currentIndex,
                      )),
              (route) => false));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (previousOrientation != null) {
      if (previousOrientation != MediaQuery.of(context).orientation) {
        _homepageController = PageController(initialPage: _currentIndex);
      }
    } else {
      previousOrientation = MediaQuery.of(context).orientation;
    }

    Widget buildWideLayout() {
      return Scaffold(
        body: Row(
          children: <Widget>[
            NavigationRail(
                groupAlignment:
                    SystemInformation().getAppType(context) == AppType.desktop
                        ? -1
                        : 0,
                labelType: NavigationRailLabelType.all,
                selectedIndex: _currentIndex,
                onDestinationSelected: (int index) {
                  navigationBarTapped(index);
                },
                trailing: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.primary),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            DateFormat("HH:mm").format(DateTime.parse(latestData
                                .returnValue("tstamp")
                                .getValue()
                                .toString())),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SettingsPage(
                                  latestData: latestData,
                                )),
                      ).then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => RefreshPage(
                                    latestData: latestData,
                                    pageToDisplay: _currentIndex,
                                  )),
                          (route) => false));
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        ForecastIcons.cog,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                ]),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(ForecastIcons.home),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(ForecastIcons.chart_line),
                    label: Text("Charts"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(ForecastIcons.arrows_ccw),
                    label: Text("Refresh"),
                  ),
                ]),
            Expanded(
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _homepageController,
                  scrollDirection: Axis.vertical,
                  children: [
                    DataPage(
                      latestData: latestData,
                      settings: _storage,
                    ),
                    ChartSelectorPage(
                      settings: _storage,
                    ),
                  ]),
            ),
          ],
        ),
      );
    }

    Widget buildNormalLayout() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    latestData.currentLocation,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
              Text(
                latestData.homepageMessage,
                style: latestData.homepageMessageType == "error"
                    ? Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
              ),
            ],
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.onPrimary),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat("HH:mm").format(DateTime.parse(latestData
                        .returnValue("tstamp")
                        .getValue()
                        .toString())),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SettingsPage(
                              latestData: latestData,
                            )),
                  ).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => RefreshPage(
                                latestData: latestData,
                                pageToDisplay: _currentIndex,
                              )),
                      (route) => false));
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: Icon(
                    ForecastIcons.cog,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              navigationBarTapped(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(ForecastIcons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(ForecastIcons.chart_line),
                label: "Charts",
              )
            ]),
        body: SizedBox.expand(
          child: PageView(
              controller: _homepageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                DataPage(latestData: latestData, settings: _storage),
                ChartSelectorPage(
                  settings: _storage,
                ),
              ]),
        ),
      );
    }

    if (SystemInformation().getDisplaySize(context) == DisplaySize.landscape) {
      return buildWideLayout();
    } else {
      return buildNormalLayout();
    }
  }
}
