// Imports of third party packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// App Imports
import 'package:weatherapp3/assets/forecast_icons_icons.dart';
import 'package:weatherapp3/screens/static/error_page.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/screens/loading/data_fetch_screen.dart';

class LoginPage extends StatefulWidget {
  final CurrentDataSlice latestData;

  const LoginPage({Key? key, required this.latestData}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isProcessing = false;

  late final CurrentDataSlice latestData;

  @override
  void initState() {
    latestData = widget.latestData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isProcessing
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.surface,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Theme.of(context).colorScheme.surface),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Text(
                              "Sign In",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Divider(),
                            SignInButtonBuilder(
                              text: "Microsoft Account",
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              icon: FontAwesomeIcons.microsoft,
                              iconColor: Theme.of(context).colorScheme.surface,
                              onPressed: () async {
                                setState(() {
                                  _isProcessing = true;
                                });

                                MicrosoftAuthProvider microsoftProvider =
                                    MicrosoftAuthProvider();
                                microsoftProvider.setCustomParameters({
                                  "tenant":
                                      "280d3919-952c-48d5-8a71-87fc3dc03b64",
                                  "prompt": "select_account",
                                  "domain_hint": "jlwilson.me"
                                });

                                try {
                                  if (kIsWeb) {
                                    await FirebaseAuth.instance
                                        .signInWithPopup(microsoftProvider);
                                  } else {
                                    await FirebaseAuth.instance
                                        .signInWithProvider(microsoftProvider);
                                  }

                                  User? tempUser =
                                      FirebaseAuth.instance.currentUser;

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
                                  }
                                } on FirebaseAuthException {
                                  if (mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const ErrorPage(
                                          errorCode: "4F",
                                          errorMessage: "Sign In Error",
                                        ),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                }
                                setState(() {
                                  _isProcessing = false;
                                });
                              },
                            ),
                            const Divider(),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              child: Icon(
                                ForecastIcons.info_circled,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Text("Info"),
                                        content: const Text(
                                            'Make sure that your web browser supports opening apps from web pages.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
